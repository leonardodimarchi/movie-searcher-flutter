import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_credits_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_credits_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_usecase.dart';
import '../viewmodel/movie_viewmodel.dart';

class MovieStore extends NotifierStore<Failure, MovieViewModel> {
  final GetMovieUsecase getMovieUsecase;
  final GetMovieCreditsUsecase getMovieCreditsUsecase;
  final int movieId;

  MovieStore({
    required this.getMovieUsecase,
    required this.getMovieCreditsUsecase,
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
          movieCredits: const MovieCreditsEntity(
            id: 0, 
            cast: [], 
            crew: []
          )
        ));

  initialize() async {
    setLoading(true);

    await getMovie();

    setLoading(false);
  }

  getMovie() async {
    final movie = await getMovieUsecase(movieId);

    movie.fold((error) => setError(error), (success) {
      update(MovieViewModel(movie: success, movieCredits: state.movieCredits));
    });
  }

  getMovieCredits() async {
    final credits = await getMovieCreditsUsecase(movieId);

    credits.fold((error) => setError(error), (success) {
      update(MovieViewModel(movie: state.movie, movieCredits: success));
    });
  }
}
