import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traux_tmdb/models/movie_translation.dart';
import 'package:traux_tmdb/models/popular_movie.dart';
import 'package:traux_tmdb/providers/movie_credits_provider.dart';

import '../providers/movie_details_provider.dart';
import 'package:intl/intl.dart';

import '../utils/runtime_format.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({
    required this.popularMovie,
    required this.movieTranslation,
    super.key,
  });

  final PopularMovie popularMovie;
  final MovieTranslation movieTranslation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetails = ref.watch(getMovieDetails(popularMovie.id));
    final asyncCredits = ref.watch(getMovieCredits(popularMovie.id));
    List<String> genreNames = popularMovie.getGenreNames(popularMovie.genreIds);
    return Scaffold(
      body: asyncCredits.when(
        data: (credits) => asyncDetails.when(
          data: (details) => ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 35.0,
                  top: 30,
                  bottom: 10,
                  right: 275,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white70,
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 24,
                        color: Colors.black54,
                      ),
                      Text(
                        'Voltar',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 48.0,
                  right: 60.0,
                  left: 60.0,
                  bottom: 25,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 450,
                        width: double.infinity,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original/${popularMovie.posterPath}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: '${popularMovie.score}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(
                            text: '/10',
                            style: TextStyle(fontSize: 24, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      movieTranslation.translatedName,
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 36),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Título Original:',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: '  ${popularMovie.originalTitle}',
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.grey[300], // Grey background color
                        child: Text(
                          'Ano: ${DateTime.parse(popularMovie.releaseDate).year}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.grey[300], // Grey background color
                        child: Text(
                          'Duração: ${MovieUtils.formatRuntime(details.runtime)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: genreNames.map((genreName) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            genreName,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 12, top: 36, bottom: 12),
                    child: RichText(
                      text: TextSpan(
                        text: 'Descrição\n',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: movieTranslation.translatedOverview,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12.0,
                      left: 12.0,
                      bottom: 6,
                      top: 16,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: Colors.grey[300], // Grey background color
                      child: Text(
                        'Orçamento:  \$${NumberFormat.decimalPattern().format(details.budget)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: Colors.grey[300], // Grey background color
                      child: Text(
                        'Produtoras: ${details.productionCompany}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Diretor\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: credits.directors
                                  .take(2)
                                  .map((director) => director.name)
                                  .join(', '),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Elenco\n',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: credits.cast
                                  .take(3)
                                  .map((castMember) => castMember.name)
                                  .join(', '),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => Text("Error: $err"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Text("Error: $err"),
      ),
    );
  }
}
