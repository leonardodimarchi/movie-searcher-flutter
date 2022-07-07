import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/data/datasources/genre_datasource.dart';
import 'package:movie_searcher_flutter/features/data/models/genre_model.dart';
import 'package:movie_searcher_flutter/features/data/repositories/genre_repository_implementation.dart';

import '../../../mocks/genre_model_mock.dart';

class MockGenderDatasource extends Mock implements GenreDataSource {

}

void main() {
  late GenreDataSource datasource;
  late GenreRepositoryImplementation repository;

  setUp(() {
    datasource = MockGenderDatasource();
    repository = GenreRepositoryImplementation(datasource: datasource);
  });

  const List<GenreModel> mockedGenreModelList = [
    mockedGenreModel,
    mockedGenreModel,
    mockedGenreModel,
    mockedGenreModel,
  ];

  test('Should return a list of GenreModel when calls the datasource', () async {
    when(() => datasource.getGenres()).thenAnswer((_) async => mockedGenreModelList);

    final result = await repository.getGenres();

    expect(result, const Right(mockedGenreModelList));
    verify(() => datasource.getGenres()).called(1);
  });

  test('Should throw an ServerFailure when data source call is unsucessfull', () async {
    when(() => datasource.getGenres()).thenThrow(ServerException());

    final result = await repository.getGenres();

    expect(result, Left(ServerFailure()));
    verify(() => datasource.getGenres()).called(1);
  });
}