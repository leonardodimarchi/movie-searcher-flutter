import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_genres_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/search_movies_usecase.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeStore extends NotifierStore<Failure, HomeViewModel> {
  final GetMoviesUsecase getMoviesUsecase;
  final GetGenresUsecase getGenresUsecase;
  final SearchMoviesUsecase searchMoviesUsecase;

  HomeStore({
    required this.getMoviesUsecase,
    required this.getGenresUsecase,
    required this.searchMoviesUsecase,
  }) : super(HomeViewModel(moviePagination: MoviePagination(), genres: []));

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

    genres.fold((error) => setError(error), (success) {
      update(HomeViewModel(
          moviePagination: state.moviePagination, genres: success));
    });
  }

  refreshMovieList() async {
    int page = 0;

    final movieList = await getMoviesUsecase(page + 1);

    movieList.fold(
      (error) => setError(error),
      (success) {
        MoviePagination movies = MoviePagination(
            page: page + 1,
            list: success);

        update(HomeViewModel(moviePagination: movies, genres: state.genres));
      },
    );
  }

  searchMovies(String searchText) async {
    final movieList = await searchMoviesUsecase(SearchMovieParams(
      searchText: searchText,
      page: 0
    ));

    movieList.fold(
      (error) => setError(error),
      (success) {
        MoviePagination movies = MoviePagination(
            page: 0,
            list: success);

        update(HomeViewModel(moviePagination: movies, genres: state.genres));
      },
    );
  }
}
