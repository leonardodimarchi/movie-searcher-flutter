import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';

abstract class MovieDatasource {
  Future<List<MovieModel>> getMovies();
}