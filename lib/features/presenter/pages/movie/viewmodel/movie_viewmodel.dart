import 'package:movie_searcher_flutter/features/domain/entities/movie_credits_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';

class MovieViewModel {
  MovieDetailEntity movie;
  MovieCreditsEntity movieCredits;

  MovieViewModel({
    required this.movie,
    required this.movieCredits,
  });
}