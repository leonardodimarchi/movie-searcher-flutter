import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/search_movies_usecase.dart';

import '../../../mocks/movie_entity_mock.dart';

class MockedMovieRepository extends Mock implements MovieRepository {}

void main() {
  late SearchMoviesUsecase usecase;
  late MovieRepository repository;

  setUp(() {
    repository = MockedMovieRepository();
    usecase = SearchMoviesUsecase(repository: repository);

    registerFallbackValue(const SearchMovieParams(
      searchText: 'Search text',
    ));
  });

  final movieEntityList = [
    movieEntityMock,
    movieEntityMock,
  ];

  const mockedSearchText = 'Search text';
  const mockedSearchParams = SearchMovieParams(
    searchText: mockedSearchText,
  );

  test('Should retrieve a list of movies when called sucessfully', () async {
    when(() => repository.searchMovies(any()))
        .thenAnswer((_) async => Right(movieEntityList));

    final result = await usecase(mockedSearchParams);

    expect(result, Right(movieEntityList));
    verify(() => repository.searchMovies(mockedSearchParams)).called(1);
  });

  test('Should return a failure when the repository call is unsuccessful', () async {
    when(() => repository.searchMovies(any()))
    .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(mockedSearchParams);

    expect(result, Left(ServerFailure()));
    verify(() => repository.searchMovies(mockedSearchParams)).called(1);
  });
}
