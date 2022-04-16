import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

class MoviePagination {
  late int page;
  List<MovieEntity> movies;

  MoviePagination({ this.page = 1, this.movies = const [] });
}