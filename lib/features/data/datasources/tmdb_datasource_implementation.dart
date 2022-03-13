import 'dart:convert';

import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/http_client/http_client.dart';
import 'package:movie_searcher_flutter/core/utils/keys/tmdb_api_keys.dart';
import 'package:movie_searcher_flutter/features/data/datasources/endpoints/tmdb_endpoints.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';

class TmdbDatasourceImplementation implements MovieDatasource {
  final HttpClient httpClient;

  TmdbDatasourceImplementation({
    required this.httpClient,
  });

  @override
  Future<List<MovieModel>> getMovies() async {
    final url = TmdbEndpoints.discoverMovies(TmdbApiKeys.apiKey);
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final moviesFromJson = jsonDecode(response.data)["results"];
      
      List<MovieModel> movies = List<MovieModel>.from(moviesFromJson.map((i) => MovieModel.fromJson(i)));

      return movies;
    } else {
      throw ServerException();
    }
  }
}