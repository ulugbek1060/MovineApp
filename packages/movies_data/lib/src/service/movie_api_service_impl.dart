import 'package:movies_api/movies_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

///0

import 'package:movies_api/src/models/genre/genres.dart';

const base_url = 'api.themoviedb.org';
const apiKey = '7f442ff583bfb38f84caafd113cbccc';

class MovieApiServiceImpl extends MovieApiService {
  @override
  Future<MoviesResponse> getMovieByType({
    required String type,
    required int page,
    String language = 'en-US',
  }) async {
    var query = {
      'api_key': apiKey,
      'language': language,
      'page': '$page',
    };
    var url = Uri.https(base_url, '/3/movie/$type', query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MoviesResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail({
    required String movieId,
    String language = 'en-US',
  }) async {
    var query = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(base_url, '/3/movie/$movieId', query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MovieDetailResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<Genres> getAllGenres({String language = 'en-US'}) async {
    var query = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(base_url, '/3/genre/movie/list', query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Genres.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<MoviesResponse> getSimilarMovies({
    required String movieId,
    required int page,
    String language = 'en-US',
  }) async {
    var query = {
      'api_key': apiKey,
      'language': language,
      'page': page,
    };
    var url = Uri.https(base_url, '/3/movie/$movieId/similar', query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return MoviesResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }

  @override
  Future<VideosResponse> getVideoDataById({
    required String movieId,
    String language = 'us-US',
  }) async {
    var query = {
      'api_key': apiKey,
      'language': language,
    };
    var url = Uri.https(base_url, '/3/movie/$movieId/videos', query);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return VideosResponse.fromJson(json);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw FailedException();
    }
  }
}

class UnauthorizedException implements Exception {}

class FailedException implements Exception {
  final String message;

  FailedException({this.message = 'Something went wrong!'});
}
