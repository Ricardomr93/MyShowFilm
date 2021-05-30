import 'package:dio/dio.dart';
import 'package:myshowfilm/src/models/film_response.dart';

class FilmRepository {
  String apiKey = "<<14bcd525636524a4f06e9df0229ed5ea>>";
  static String mainUrl = "https://api.themoviedb.org/3/";
  Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getFilmUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getPersonsUrl = '$mainUrl/movie/top_rated';

  Future<FilmResponse> getFilm() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return FilmResponse.fromJson(response.data);
    } catch (error) {
      return FilmResponse.withError("$error");
    }
  }

  Future<FilmResponse> getPlayingFilms() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return FilmResponse.fromJson(response.data);
    } catch (error) {
      return FilmResponse.withError("$error");
    }
  }
}
