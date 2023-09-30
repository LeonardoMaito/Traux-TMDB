
import 'package:traux_tmdb/models/popular_movie.dart';

import '../models/movie_credits.dart';
import '../models/movie_details.dart';
import '../models/movie_translation.dart';

abstract class MovieRepository{
  Future<List<PopularMovie>> fetchPopularMovies();
  Future<MovieTranslation> fetchTranslations(int movieId);
  Future<MovieDetails> fetchMovieDetails(int movieId);
  Future<MovieCredits> fetchMovieCredits(int movieId);
}