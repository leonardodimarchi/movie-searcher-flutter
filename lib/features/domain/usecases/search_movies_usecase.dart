import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

class SearchMoviesUsecase extends UseCase<List<MovieEntity>, String> {
  final MovieRepository repository;

  SearchMoviesUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> call(params) async {
    return await repository.searchMovies(params);
  }
}