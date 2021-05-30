import 'package:dio/dio.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/models/film_response.dart';

class FilmRepository {
  Dio _dio = Dio();
  var getPopularUrl = '${ApiConstants.BASE_URL}${ApiConstants.POPULAR_FILM}';
  var getFilmUrl = '${ApiConstants.BASE_URL}${ApiConstants.DISCOVER_FILM}';
  var getPlayingUrl = '${ApiConstants.BASE_URL}${ApiConstants.POPULAR_FILM}';

  Future<FilmResponse> getFilms() async {
    var params = {
      "api_key": ApiConstants.API_KEY,
      "language": "en-US",
      "page": 1
    };
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return FilmResponse.fromJson(response.data);
    } catch (error) {
      return FilmResponse.withError("$error");
    }
  }

  Future<FilmResponse> getPlayingFilms() async {
    var params = {
      "api_key": ApiConstants.API_KEY,
      "language": "en-US",
      "page": 1
    };
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return FilmResponse.fromJson(response.data);
    } catch (error) {
      return FilmResponse.withError("$error");
    }
  }
}
