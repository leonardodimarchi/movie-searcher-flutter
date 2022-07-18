import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';

import '../models/movie_detail_model.dart';

abstract class MovieDatasource {
  Future<List<MovieModel>> getMovies(int page);
  Future<MovieDetailModel> getMovie(int id);
  Future<List<MovieModel>> searchMovies(String searchText);
}