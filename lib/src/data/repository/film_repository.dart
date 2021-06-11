import 'package:dio/dio.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/data/models/film_response.dart';

class FilmRepository {
  Dio _dio = Dio();
  var getPopularUrl = '${ApiConstants.BASE_URL}${ApiConstants.POPULAR_FILM}';
  var getFilmUrl = '${ApiConstants.BASE_URL}${ApiConstants.DISCOVER_FILM}';
  var getPlayingUrl = '${ApiConstants.BASE_URL}${ApiConstants.POPULAR_FILM}';
  var searchFilmUrl = '${ApiConstants.BASE_URL}${ApiConstants.SEARCH_FILM}';

  Future<FilmResponse> getFilms(int page) async {
    var params = {
      "api_key": ApiConstants.API_KEY,
      "language": "es-ES",
      "page": page
    };
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return FilmResponse.fromJson(response.data);
    } catch (error) {
      return FilmResponse.withError("$error");
    }
  }

  Future<FilmResponse> searchFilms(String query) async {
    var params = {
      "api_key": ApiConstants.API_KEY,
      "language": "es-ES",
      "query": query
    };
    try {
      Response response =
          await _dio.get(searchFilmUrl, queryParameters: params);
      return FilmResponse.fromJson(response.data);
    } catch (error) {
      return FilmResponse.withError("$error");
    }
  }

  Future<FilmResponse> getPlayingFilm(int numPage) async {
    var params = {
      "api_key": ApiConstants.API_KEY,
      "language": "es-ES",
      "page": numPage
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
