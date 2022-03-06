import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies();
}