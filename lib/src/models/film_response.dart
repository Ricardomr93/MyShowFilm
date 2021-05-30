import 'film.dart';

class FilmResponse {
  List<Film> films;
  String error;

  FilmResponse(
    this.films,
    this.error,
  );

  FilmResponse.fromJson(Map<String, dynamic> json)
      : films = (json["result"] as List).map((i) => Film.fromJson(i)).toList(),
        error = '';
  FilmResponse.withError(String errorValue)
      : films = [],
        error = errorValue;
}
