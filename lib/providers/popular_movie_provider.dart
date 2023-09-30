
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/popular_movie.dart';
import 'movie_repository_provider.dart';

final getPopularMoviesProvider = FutureProvider<List<PopularMovie>>((ref) async {
  final repository = ref.read(movieRepositoryProvider);
  final popularMovies = repository.fetchPopularMovies();
  return popularMovies;
});

