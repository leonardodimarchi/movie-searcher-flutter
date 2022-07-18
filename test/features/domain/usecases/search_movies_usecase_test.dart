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
  });

  final movieEntityList = [
    movieEntityMock,
    movieEntityMock,
  ];

  test('Should retrieve a list of movies when called sucessfully', () async {
    when(() => repository.searchMovies(any()))
        .thenAnswer((_) async => Right(movieEntityList));

    const searchText = 'Search text';

    final result = await usecase(searchText);

    expect(result, Right(movieEntityList));
    verify(() => repository.searchMovies(searchText)).called(1);
  });

  test('Should return a failure when the repository call is unsuccessful', () async {
    when(() => repository.searchMovies(any()))
    .thenAnswer((_) async => Left(ServerFailure()));

    const searchText = 'Search text';

    final result = await usecase(searchText);

    expect(result, Left(ServerFailure()));
    verify(() => repository.searchMovies(searchText)).called(1);
  });
}
