

class MovieDetails {
  final int id;
  final double budget;
  final String productionCompany;
  final int runtime;


  MovieDetails({
    required this.id,
    required this.budget,
    required this.productionCompany,
    required this.runtime,
  });


  factory MovieDetails.fromMap(Map<String, dynamic> json) {
    final List<dynamic> productionCompanies = json['production_companies'];
    final String productionCompany =
        productionCompanies.isNotEmpty ? productionCompanies[0]['name'] : '';

    return MovieDetails(
      id: json['id'],
      budget: json['budget'].toDouble(),
      productionCompany: productionCompany,
      runtime: json['runtime'],

    );
  }
}
