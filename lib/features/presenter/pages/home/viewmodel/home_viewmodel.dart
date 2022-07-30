import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

class HomeViewModel {
  MoviePagination moviePagination;
  List<GenreEntity> genres;
  GetMovieType selectedType;

  HomeViewModel({
    required this.moviePagination,
    required this.genres,
    required this.selectedType,
  });
}