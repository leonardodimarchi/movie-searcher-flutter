import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/features/data/datasources/genre_datasource.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/genre_repository.dart';

class GenreRepositoryImplementation extends GenreRepository {
  final GenreDataSource datasource;

  GenreRepositoryImplementation({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenres() async {
    try {
      final result = await datasource.getGenres();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}