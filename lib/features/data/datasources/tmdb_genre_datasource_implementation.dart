import 'dart:convert';

import 'package:movie_searcher_flutter/core/http_client/http_client.dart';
import 'package:movie_searcher_flutter/features/data/datasources/endpoints/tmdb_genres_endpoints.dart';
import 'package:movie_searcher_flutter/features/data/datasources/genre_datasource.dart';
import 'package:movie_searcher_flutter/features/data/models/genre_model.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/keys/tmdb_api_keys.dart';

class TmdbGenreDatasourceImplementation implements GenreDataSource {
  final HttpClient httpClient;

  TmdbGenreDatasourceImplementation({
    required this.httpClient,
  });

  @override
  Future<List<GenreModel>> getGenres() async {
    final url = TmdbGenreEndpoints.getGenres(TmdbApiKeys.apiKey);
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final genresFromJson = jsonDecode(response.data)["genres"];
      
      List<GenreModel> genres = List<GenreModel>.from(genresFromJson.map((i) => GenreModel.fromJson(i)));

      return genres;
    } else {
      throw ServerException();
    }
  }
}