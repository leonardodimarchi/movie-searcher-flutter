import 'package:movie_searcher_flutter/features/data/models/movie_credits_model.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

import '../models/movie_detail_model.dart';

abstract class MovieDatasource {
  Future<List<MovieModel>> getMovies(GetMoviesParams params);
  Future<MovieDetailModel> getMovie(int id);
  Future<MovieCreditsModel> getMovieCredits(int movieId);
  Future<List<MovieModel>> searchMovies(SearchMovieParams params);
}