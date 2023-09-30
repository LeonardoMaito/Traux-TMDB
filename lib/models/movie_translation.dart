
class MovieTranslation {

  final String iso_3166_1;
  final String translatedName;
  final String translatedOverview;

  MovieTranslation({
    required this.iso_3166_1,
    required this.translatedName,
    required this.translatedOverview
  });

  factory MovieTranslation.fromMap(Map<String, dynamic> json) {
    return MovieTranslation(
        iso_3166_1: json["iso_3166_1"],
        translatedName: json["data"]["title"],
        translatedOverview: json["data"]["overview"]
    );
  }
}