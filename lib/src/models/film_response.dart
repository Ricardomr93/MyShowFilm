import 'film.dart';

class FilmResponse {
  List<Film> films;
  String error;

  FilmResponse(
    this.films,
    this.error,
  );

  FilmResponse.fromJson(Map<String, dynamic> json)
      : films =
            (json["results"] as List).map((i) => new Film.fromJson(i)).toList(),
        error = "";
  FilmResponse.withError(String errorValue)
      : films = [],
        error = errorValue;
}
