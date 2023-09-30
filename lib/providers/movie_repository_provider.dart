
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traux_tmdb/services/movie_api_repository.dart';

final movieRepositoryProvider = Provider<MovieApiRepository>((ref) {
  return MovieApiRepository();
});