import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_credits_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

class MovieRepositoryImplementation extends MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImplementation({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getMovies(int page) async {
    try {
      final result = await datasource.getMovies(page);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovie(int id) async {
    try {
      final result = await datasource.getMovie(id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(SearchMovieParams params) async {
    try {
      final result = await datasource.searchMovies(params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MovieCreditsEntity>> getMovieCredits(int movieId) async {
    try {
      final result = await datasource.getMovieCredits(movieId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
