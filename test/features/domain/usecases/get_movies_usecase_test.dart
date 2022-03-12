import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';

import '../../../mocks/movie_entity_mock.dart';

class MockMoviesRepository extends Mock implements MovieRepository {

}

void main() {
  late GetMoviesUsecase usecase;
  late MovieRepository repository;

  setUp(() {
    repository = MockMoviesRepository();
    usecase = GetMoviesUsecase(repository: repository);
  });

  const movieEntityList = [
    movieEntityMock,
    movieEntityMock,
    movieEntityMock
  ];

  test('Should retrieve a list of movies when successful', () async {
    when(() => repository.getMovies())
    .thenAnswer((_) async => const Right(movieEntityList));

    final result = await usecase(NoParams());

    expect(result, const Right(movieEntityList));
    verify(() => repository.getMovies()).called(1);
  });

  test('Should return a failure when the repository call is unsuccessful', () async {
    when(() => repository.getMovies())
    .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(NoParams());

    expect(result, Left(ServerFailure()));
    verify(() => repository.getMovies()).called(1);
  });
}