import 'dart:convert';

import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/http_client/http_client.dart';
import 'package:movie_searcher_flutter/core/utils/keys/tmdb_api_keys.dart';
import 'package:movie_searcher_flutter/features/data/datasources/endpoints/tmdb_movies_endpoints.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_credits_model.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_detail_model.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

class TmdbMovieDatasourceImplementation implements MovieDatasource {
  final HttpClient httpClient;

  TmdbMovieDatasourceImplementation({
    required this.httpClient,
  });

  @override
  Future<List<MovieModel>> getMovies(GetMoviesParams params) async {
    String url = TmdbMoviesEndpoints.popularMovies(TmdbApiKeys.apiKey, page: params.page);

    if (params.type == GetMovieType.topRated) {
      url = TmdbMoviesEndpoints.topRatedMovies(TmdbApiKeys.apiKey, page: params.page);
    } 
    
    if (params.type == GetMovieType.upcoming) {
      url = TmdbMoviesEndpoints.upcomingMovies(TmdbApiKeys.apiKey, page: params.page);
    }

    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final moviesFromJson = jsonDecode(response.data)["results"];

      List<MovieModel> movies = List<MovieModel>.from(
          moviesFromJson.map((i) => MovieModel.fromJson(i)));

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

  @override
  Future<List<MovieModel>> searchMovies(SearchMovieParams params) async {
    final url = TmdbMoviesEndpoints.searchMovies(
      TmdbApiKeys.apiKey,
      page: params.page,
      searchText: params.searchText
    );
    
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final moviesFromJson = jsonDecode(response.data)["results"];

      List<MovieModel> movies = List<MovieModel>.from(
          moviesFromJson.map((i) => MovieModel.fromJson(i)));

      return movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieCreditsModel> getMovieCredits(int movieId) async {
    final url = TmdbMoviesEndpoints.movieCredits(TmdbApiKeys.apiKey, movieId: movieId);
    final response = await httpClient.get(url);

    if (response.statusCode == 200) {
      final movieCreditsJson = jsonDecode(response.data);

      return MovieCreditsModel.fromJson(movieCreditsJson);
    } else {
      throw ServerException();
    }
  }
}
