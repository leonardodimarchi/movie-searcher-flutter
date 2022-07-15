import 'dart:convert';

import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/http_client/http_client.dart';
import 'package:movie_searcher_flutter/core/utils/keys/tmdb_api_keys.dart';
import 'package:movie_searcher_flutter/features/data/datasources/endpoints/tmdb_movies_endpoints.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_detail_model.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';

class TmdbMovieDatasourceImplementation implements MovieDatasource {
  final HttpClient httpClient;

  TmdbMovieDatasourceImplementation({
    required this.httpClient,
  });

  @override
  Future<List<MovieModel>> getMovies(int page) async {
    final url = TmdbMoviesEndpoints.discoverMovies(TmdbApiKeys.apiKey, page: page);
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final moviesFromJson = jsonDecode(response.data)["results"];
      
      List<MovieModel> movies = List<MovieModel>.from(moviesFromJson.map((i) => MovieModel.fromJson(i)));

      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailModel> getMovie(int id) async {
    final url = TmdbMoviesEndpoints.movieDetails(TmdbApiKeys.apiKey, id: id);
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final movieJson = jsonDecode(response.data);

      return MovieDetailModel.fromJson(movieJson);
    } else {
      throw ServerException();
    }
  }
}