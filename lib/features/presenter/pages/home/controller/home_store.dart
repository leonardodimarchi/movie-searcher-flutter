import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_genres_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeStore extends NotifierStore<Failure, HomeViewModel> {
  final GetMoviesUsecase getMoviesUsecase;
  final GetGenresUsecase getGenresUsecase;

  HomeStore({required this.getMoviesUsecase, required this.getGenresUsecase})
      : super(HomeViewModel(moviePagination: MoviePagination(), genres: []));

  getMovies() async {
    int currentPage = state.moviePagination.page;

    if (currentPage == 0) {
      setLoading(true);
    }

    final movieList = await getMoviesUsecase(currentPage + 1);

    if (currentPage == 0) {
      setLoading(false);
    }

    movieList.fold(
      (error) => setError(error),
      (success) {
        MoviePagination movies = MoviePagination(
            page: currentPage + 1,
            list: [...state.moviePagination.list, ...success]);

        update(HomeViewModel(moviePagination: movies, genres: state.genres));
      },
    );
  }

  getGenres() async {
   final genres = await getGenresUsecase(NoParams());

   genres.fold(
    (error) => setError(error),
    (success) {
      update(HomeViewModel(moviePagination: state.moviePagination, genres: success));
    }
   );
  }
}