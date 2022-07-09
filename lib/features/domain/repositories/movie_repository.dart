import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies(int page);
  Future<Either<Failure, MovieEntity>> getMovie(int id);
}