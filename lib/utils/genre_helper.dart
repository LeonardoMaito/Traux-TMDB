
final Map<int, String> genreIdToBrazilianName = {
  28: 'Ação',
  12: 'Aventura',
  16: 'Animação',
  35: 'Comédia',
  80: 'Crime',
  99: 'Documentário',
  18: 'Drama',
  10751: 'Familía',
  14: 'Fantasia',
  36: 'História',
  27: 'Terror',
  10402: 'Musical',
  9648: 'Mistério',
  10749: 'Romance',
  878: 'Ficção Científica',
  10770: 'TV-Film',
  53: "Thriller",
  10752: "Guerra",
  37: "Velho Oeste"
};

class GenreHelper {
  static List<String> getGenreNames(List<int> genreIds) {
    final List<String> genreNames = [];

    for (final genreId in genreIds) {
      final translatedName = genreIdToBrazilianName[genreId] ?? "Desconhecido";
      genreNames.add(translatedName);

      if (genreNames.length >= 3) {
        break;
      }
    }

    return genreNames;
  }
}