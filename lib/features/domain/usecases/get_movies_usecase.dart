import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movies_repository.dart';

class GetMoviesUsecase extends UseCase<List<MovieEntity>, NoParams> {
  final MoviesRepository repository;

  GetMoviesUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParams params) async {
    return await repository.getMovies();
  }
}