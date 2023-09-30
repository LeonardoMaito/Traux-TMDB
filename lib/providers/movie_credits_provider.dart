
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traux_tmdb/models/movie_credits.dart';

import 'movie_repository_provider.dart';

final getMovieCredits = FutureProvider.family<MovieCredits, int>((ref, movieId) async {
  final repository = ref.read(movieRepositoryProvider);
  try{
    final movieCredits = await repository.fetchMovieCredits(movieId);
    return movieCredits;
  } catch(e){
    return MovieCredits(cast: [], directors: []);
  }
});