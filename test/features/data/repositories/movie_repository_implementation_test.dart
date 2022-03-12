import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/data/repositories/movie_repository_implementation.dart';

import '../../../mocks/movie_model_mock.dart';

class MockMovieDatasource extends Mock implements MovieDatasource {

}

void main() {
  late MovieRepositoryImplementation repository;
  late MovieDatasource datasource;

  setUp(() {
    datasource = MockMovieDatasource();
    repository = MovieRepositoryImplementation(datasource: datasource);
  });

  const movieModelsListMock = [
    movieModelMock,
    movieModelMock,
    movieModelMock,
    movieModelMock,
  ];

  test('Should return a list of MovieModel when calls the datasource', () async {
    when(() => datasource.getMovies()).thenAnswer((_) async => movieModelsListMock);

    final result = await repository.getMovies();

    expect(result, const Right(movieModelsListMock));
    verify(() => datasource.getMovies()).called(1);
  });

  test('Should throw an ServerFailure when data source call is unsucessfull', () async {
    when(() => datasource.getMovies()).thenThrow(ServerException());

    final result = await repository.getMovies();

    expect(result, Left(ServerFailure()));
    verify(() => datasource.getMovies()).called(1);
  });
}