
import 'dart:convert';

import 'package:traux_tmdb/data/movie_repository.dart';
import 'package:traux_tmdb/models/movie_credits.dart';
import 'package:traux_tmdb/models/movie_details.dart';
import 'package:traux_tmdb/models/movie_translation.dart';
import 'package:traux_tmdb/models/popular_movie.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class MovieApiRepository implements MovieRepository {

  final String _popularMovieUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

  @override
  Future<List<PopularMovie>> fetchPopularMovies() async {

    final response = await http.get(Uri.parse(_popularMovieUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<PopularMovie> popularMovies = (jsonData['results'] as List)
          .map((data) => PopularMovie.fromMap(data))
          .toList();

      return popularMovies;
    } else {
      throw Exception("Erro ao buscar filmes populares");
    }
  }

  @override
  Future<MovieTranslation> fetchTranslations(int movieId) async {
    final String translationsUrl = 'https://api.themoviedb.org/3/movie/$movieId/translations?api_key=$apiKey';

    final response = await http.get(Uri.parse(translationsUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final translationData = (jsonData['translations'].firstWhere(
              (translation) => translation['iso_3166_1'] == 'BR',
          orElse: () => null
      ));

      return MovieTranslation.fromMap(translationData);
    } else {
      throw Exception("Erro ao buscar tradução do filme");
    }
  }

  @override
  Future<MovieDetails> fetchMovieDetails(int movieId) async  {
    final String detailsUrl = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';

    final response = await http.get(Uri.parse(detailsUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

       final movieDetails = MovieDetails.fromMap(jsonData);
      return movieDetails;
    } else {
      throw Exception("Erro ao buscar tradução do filme");
    }
  }

  @override
  Future<MovieCredits> fetchMovieCredits(int movieId) async {
    final String creditsUrl = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(creditsUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Filter the cast members
        final List<dynamic> castData = jsonData['cast'] ?? [];
        final List<CastMember> cast = castData
            .where((member) =>
        member['known_for_department'] == 'Acting' ||
            member['job'] == 'Director')
            .map((member) => CastMember.fromMap(member))
            .toList();

        // Sort the cast members by their order (usually billed order)
        cast.sort((a, b) => a.order.compareTo(b.order));

        final movieCredits = MovieCredits(cast: cast, directors: cast);

        print(movieCredits);
        return movieCredits;
      } else {
        throw Exception("Error fetching movie credits");
      }
    } catch (e) {
      throw Exception("Error fetching movie credits: $e");
    }
  }
}