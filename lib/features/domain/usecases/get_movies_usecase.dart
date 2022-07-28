import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

class GetMoviesUsecase extends UseCase<List<MovieEntity>, GetMoviesParams> {
  final MovieRepository repository;

  GetMoviesUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> call(GetMoviesParams params) async {
    return await repository.getMovies(params);
  }
}