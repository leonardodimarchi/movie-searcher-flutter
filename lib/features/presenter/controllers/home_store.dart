import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';

class HomeStore extends NotifierStore<Failure, MoviePagination> {
  final GetMoviesUsecase usecase;

  HomeStore(this.usecase) : super(MoviePagination());

  getMovies() async {
    if (state.page == 1) {
      setLoading(true);
    }

    final movieList = await usecase(state.page + 1);

    if (state.page == 1) {
      setLoading(false);
    }

    movieList.fold(
      (error) => setError(error), 
      (success) {
        MoviePagination movie = MoviePagination(page: state.page + 1, list: [...state.list, ...success]);

        update(movie);
      },
    );
  }
}