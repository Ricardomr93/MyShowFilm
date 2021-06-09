import 'Serie.dart';

class SerieResponse {
  List<Serie> films;
  String error;

  SerieResponse(
    this.films,
    this.error,
  );

  SerieResponse.fromJson(Map<String, dynamic> json)
      : films = (json["results"] as List)
            .map((i) => new Serie.fromJson(i))
            .toList(),
        error = "";
  SerieResponse.withError(String errorValue)
      : films = [],
        error = errorValue;
}
