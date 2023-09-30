import 'dart:convert';

class MovieCredits{

  final List<CastMember> directors;
  final List<CastMember> cast;

  MovieCredits({
    required this.directors,
    required this.cast,
  });

  factory MovieCredits.fromMap(Map<String, dynamic> json) {

    final List<dynamic> castData = json['cast'] ?? [];
    final List<CastMember> directors = castData
        .where((member) => member['known_for_department'] == 'Directing')
        .map((member) => CastMember.fromJson(member))
        .toList();

    final List<CastMember> cast = castData
        .where((member) =>
    member['known_for_department'] == 'Acting' ||
        member['job'] == 'Director')
        .map((member) => CastMember.fromJson(member))
        .toList();

    return MovieCredits(directors: directors, cast: cast);
  }

}

class CastMember {
  final String name;
  final String character;
  final String knownForDepartment;
  final String profilePath;
  final int order;

  CastMember({
    required this.name,
    required this.character,
    required this.profilePath,
    required this.order,
    required this.knownForDepartment
  });

  factory CastMember.fromJson(String str) => CastMember.fromMap(json.decode(str));

  factory CastMember.fromMap(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'] ?? '',
      order: json['order'] ?? 0,
      knownForDepartment: json['known_for_department']
    );
  }
}