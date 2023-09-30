
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traux_tmdb/models/movie_details.dart';

import 'movie_repository_provider.dart';

final getMovieDetails = FutureProvider.family<MovieDetails, int>((ref, movieId) async {
  final repository = ref.read(movieRepositoryProvider);
  try{
    final movieDetails = await repository.fetchMovieDetails(movieId);
    return movieDetails;
  } catch(e){
    return MovieDetails(id: 0, budget: 0, productionCompany: '', runtime: 0);
  }
});