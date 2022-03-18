import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';

class HomeStore extends NotifierStore<Failure, List<MovieEntity>> {
  final GetMoviesUsecase usecase;

  HomeStore(this.usecase) : super([]);

  getMovies() async {
    setLoading(true);

    final movieList = await usecase(NoParams());

    movieList.fold(
      (error) => setError(error), 
      (success) => update(success),
    );
  }
}