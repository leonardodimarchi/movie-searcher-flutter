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

  getMovies({int? page}) async {
    int currentPage = page ?? state.moviePagination.page + 1;

    if (currentPage == 1) {
      setLoading(true);
    }

    final movieList = await getMoviesUsecase(currentPage);

    if (currentPage == 1) {
      setLoading(false);
    }

    movieList.fold(
      (error) => setError(error),
      (success) {
        MoviePagination movies = MoviePagination(
            page: currentPage,
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

  refreshSearchMovieList(String searchText) async {
    int page = 1;

    final movieList = await searchMoviesUsecase(SearchMovieParams(
      searchText: searchText,
      page: page,
    ));


    movieList.fold(
      (error) => setError(error),
      (success) {
        MoviePagination movies = MoviePagination(
            page: page,
            list: success);

        update(HomeViewModel(moviePagination: movies, genres: state.genres));
      },
    );
  }

  searchMovies({required String searchText, int? page}) async {
    final currentPage = page ?? state.moviePagination.page + 1;
    final movieList = await searchMoviesUsecase(SearchMovieParams(
      searchText: searchText,
      page: currentPage,
    ));

    movieList.fold(
      (error) => setError(error),
      (success) {
        MoviePagination movies = MoviePagination(
            page: currentPage,
            list: currentPage == 1 ? success : [...state.moviePagination.list, ...success]);        

        update(HomeViewModel(moviePagination: movies, genres: state.genres));
      },
    );
  }
}
