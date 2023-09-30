
import '../utils/genre_helper.dart';


class PopularMovie {

   int id;
   String originalTitle;
   String overview;
   double score;
   String posterPath;
   String releaseDate;
   List<int> genreIds;

  PopularMovie({required this.id,
      required this.originalTitle,
      required this.overview,
      required this.score,
      required this.posterPath,
      required this.releaseDate,
      required this.genreIds,
  });

   List<String> getGenreNames(List<int> genreIds) {
      return GenreHelper.getGenreNames(genreIds);
   }


  factory PopularMovie.fromMap(Map<String, dynamic> json) {

    final List<int> genreIds = List<int>.from(json['genre_ids'] ?? []);

    return PopularMovie(
      id: json["id"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      score: json["vote_average"]!= null ? json["vote_average"].toDouble() : 0.0,
      posterPath: json["poster_path"] ?? "",
      releaseDate: json["release_date"] != null ? json["release_date"].toString() : "",
      genreIds: genreIds,
    );
  }
}
