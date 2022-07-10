import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

class MovieViewModel {
  MovieEntity movie;
  List<GenreEntity> genres;

  MovieViewModel({
    required this.movie,
    required this.genres,
  });
}