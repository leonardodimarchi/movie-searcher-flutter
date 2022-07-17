import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';
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
          movie: const MovieDetailEntity(
            id: 0,
            backdropImage: "",
            description: "",
            image: "",
            releaseDate: "",
            title: "",
            runtimeInMinutes: 60,
            average: 0,
            budget: 0,
            genres: [],
          ),
        ));

  initialize() async {
    setLoading(true);

    await getMovie();

    setLoading(false);
  }

  getMovie() async {
    final movie = await getMovieUsecase(movieId);

    movie.fold((error) => setError(error), (success) {
      update(MovieViewModel(movie: success));
    });
  }
}
