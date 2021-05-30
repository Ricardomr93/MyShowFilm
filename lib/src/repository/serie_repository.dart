import 'package:dio/dio.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/models/serie_response.dart';

class SerieRepository {
  Dio _dio = Dio();
  var getPopularUrl = '${ApiConstants.BASE_URL}${ApiConstants.POPULAR_SERIE}';
  var getFilmUrl = '${ApiConstants.BASE_URL}${ApiConstants.DISCOVER_FILM}';
  var getPlayingUrl = '${ApiConstants.BASE_URL}${ApiConstants.POPULAR_SERIE}';

  Future<SerieResponse> getSerie() async {
    var params = {
      "api_key": ApiConstants.API_KEY,
      "language": "en-US",
      "page": 1
    };
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return SerieResponse.fromJson(response.data);
    } catch (error) {
      return SerieResponse.withError("$error");
    }
  }

  Future<SerieResponse> getPlayingSerie() async {
    var params = {
      "api_key": ApiConstants.API_KEY,
      "language": "en-US",
      "page": 1
    };
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return SerieResponse.fromJson(response.data);
    } catch (error) {
      return SerieResponse.withError("$error");
    }
  }
}
