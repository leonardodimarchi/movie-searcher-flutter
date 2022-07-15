import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

class GetMovieUsecase extends UseCase<MovieDetailEntity, int> {
  final MovieRepository repository;

  GetMovieUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, MovieDetailEntity>> call(int params) {
    return repository.getMovie(params);
  }
}