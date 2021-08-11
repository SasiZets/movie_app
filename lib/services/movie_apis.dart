import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/constants.dart';

class MovieApis {
  static Future<Map<String, dynamic>> postRequest({
    String trigger: '',
    String query: '',
  }) async {
    try {
      print(Uri.parse(kBaseUrl + trigger).toString());
      http.Response response = await http.get(
        Uri.parse(kBaseUrl +
            trigger +
            '?' +
            query +
            ((query.isEmpty) ? '' : '&') +
            'api_key=' +
            kApiKey),

        // body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );

      // print("request:" + Uri.parse(baseUrl + trigger).toString());
      // print("response:" + response.body.toString());

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': e};
    }
  }

  static Future<Map<String, dynamic>> getPopular(String query) async {
    var response = await postRequest(trigger: '/movie/popular', query: query);
    // print(response);
    return response;
  }

  static Future<Map<String, dynamic>> getTopRated(String query) async {
    var response = await postRequest(trigger: '/movie/top_rated', query: query);
    // print(response);
    return response;
  }

  static Future<Map<String, dynamic>> getUpComing(String query) async {
    var response = await postRequest(trigger: '/movie/upcoming', query: query);
    // print(response);
    return response;
  }

  static Future<Map<String, dynamic>> getMovieDescription(String query,
      {required String movieID}) async {
    var response = await postRequest(trigger: '/movie/$movieID', query: query);
    // print(response);
    return response;
  }

  static Future<Map<String, dynamic>> getSimilarMovies(String query,
      {required String movieID}) async {
    var response =
        await postRequest(trigger: '/movie/$movieID/similar', query: query);
    // print(response);
    return response;
  }

  static Future<Map<String, dynamic>> getMoviesByActor(String query) async {
    var response = await postRequest(trigger: '/discover/movie', query: query);
    // print(response);
    return response;
  }

  static String getImage(String path) {
    return kImageUrl + path;
  }
}
