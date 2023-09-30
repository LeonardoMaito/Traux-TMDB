import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traux_tmdb/providers/translations_provider.dart';

import '../providers/popular_movie_provider.dart';
import 'movie_details_screen.dart';

final movieNameFilterProvider = StateProvider<String>((ref) => '');

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMovies = ref.watch(getPopularMoviesProvider);
    final filter = ref.watch(movieNameFilterProvider).toLowerCase();
    return Scaffold(
      body: popularMovies.when(
        data: (movies) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left:30.0,top: 35, bottom: 25),
              child: Text("Filmes", style: TextStyle(
                fontSize: 20
              ),
              ),
            ),
            searchMovieField(ref),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: ListView(
                  children: [
                    for (final movie in movies)
                      Builder(
                        builder: (context) {
                          final translations =
                              ref.watch(getTranslations(movie.id));
                          final isFiltered = translations.when(
                            data: (translation) => translation.translatedName
                                .toLowerCase()
                                .contains(filter),
                            loading: () => true,
                            error: (err, stack) => true,
                          );
                          if (!isFiltered) {
                            return const SizedBox
                                .shrink(); // Hide the movie if not filtered
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: translations.when(
                              data: (translation) => ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 450,
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  ProviderScope(child:MovieDetailsScreen(popularMovie: movie, movieTranslation: translation))));
                                    },
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                         Positioned(
                                           bottom: 30.0,
                                           left: 18.0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                translation.translatedName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                                ),
                                              ),
                                              const SizedBox(height: 5,),
                                              Text(
                                                (movie.getGenreNames(movie.genreIds).join(' - ').toString()),
                                                style: const TextStyle(color: Colors.white),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              error: (err, stack) => Text("Error: $err"),
                              loading: () =>
                                  const Text("Carregando traduções..."),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Text("Error: $err"),
      ),
    );
  }

  Widget searchMovieField(WidgetRef ref) {
    Timer? debounceTimer;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.only(right: 20.0, left: 20),
      child: TextField(
        onChanged: (value) {
          debounceTimer?.cancel();
          debounceTimer = Timer(const Duration(milliseconds: 500), () {
            ref.read(movieNameFilterProvider.notifier).state = value;
          });
        },
        decoration: const InputDecoration(
          hintText: "Pesquise Filmes",
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
