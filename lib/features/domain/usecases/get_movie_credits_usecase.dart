import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_credits_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

class GetMovieCreditsUsecase extends UseCase<MovieCreditsEntity, int> {
  final MovieRepository repository;

  GetMovieCreditsUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, MovieCreditsEntity>> call(int params) async {
    return await repository.getMovieCredits(params);
  }
}