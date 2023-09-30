
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie_translation.dart';
import 'movie_repository_provider.dart';

final getTranslations = FutureProvider.family<MovieTranslation, int>((ref, movieId) async {
  final repository = ref.read(movieRepositoryProvider);
  try{
    final translation = await repository.fetchTranslations(movieId);
    return translation;
  } catch(e){
    return MovieTranslation(
       iso_3166_1: '', translatedName: '', translatedOverview: ''
    );
  }
});
