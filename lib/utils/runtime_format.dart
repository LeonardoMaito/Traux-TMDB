class MovieUtils {
  static String formatRuntime(int runtime) {
    double hours = runtime / 60;
    double minutes = runtime % 60;

    String formattedHours = hours.truncate() == hours
        ? hours.toInt().toString()
        : hours.toStringAsFixed(0);
    String formattedMinutes = minutes.truncate() == minutes
        ? minutes.toInt().toString()
        : minutes.toStringAsFixed(0);

    return ("$formattedHours h $formattedMinutes min ");
  }
}