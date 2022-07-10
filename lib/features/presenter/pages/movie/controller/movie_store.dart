import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_genres_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_usecase.dart';
import '../viewmodel/movie_viewmodel.dart';

class MovieStore extends NotifierStore<Failure, MovieViewModel> {
  final GetMovieUsecase getMovieUsecase;
  final GetGenresUsecase getGenresUsecase;
  final int movieId;

  MovieStore({
    required this.getMovieUsecase,
    required this.getGenresUsecase,
    required this.movieId,
  }) : super(MovieViewModel(
            movie: const MovieEntity(
              id: 0,
              backdropImage: "",
              description: "",
              image: "",
              releaseDate: "",
              title: "",
              genreIds: [],
              average: 0,
            ),
            genres: []));

  getMovie() async {
    final movie = await getMovieUsecase(movieId);

    movie.fold((error) => setError(error), (success) {
      update(MovieViewModel(movie: success, genres: state.genres));
    });
  }

  getGenres() async {
    final genres = await getGenresUsecase(NoParams());

    genres.fold((error) => setError(error), (success) {
      update(MovieViewModel(movie: state.movie, genres: success));
    });
  }
}
