import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';

class HomeViewModel {
  MoviePagination moviePagination;
  List<GenreEntity> genres;

  HomeViewModel({
    required this.moviePagination,
    required this.genres,
  });
}