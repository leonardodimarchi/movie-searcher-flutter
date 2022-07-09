import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_usecase.dart';

import '../../../mocks/movie_entity_mock.dart';

class MockedMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetMovieUsecase usecase;
  late MovieRepository repository;

  setUp(() {
    repository = MockedMovieRepository();
    usecase = GetMovieUsecase(repository: repository);
  });

  const mockedMovieEntity = movieEntityMock;

  void successMock() {
    when(() => repository.getMovie(any()))
      .thenAnswer((_) async => const Right(mockedMovieEntity));
  }

  void failureMock() {
    when(() => repository.getMovie(any()))
      .thenAnswer((_) async => Left(ServerFailure()));
  }

  test('Should call repository with the correct params', () async {
    successMock();

    await usecase(mockedMovieEntity.id);

    verify(() => repository.getMovie(mockedMovieEntity.id)).called(1);
  });

  test('Should return a movie entity when calling sucessfully', () async {
    successMock();

    final result = await usecase(mockedMovieEntity.id);

    expect(result, const Right(mockedMovieEntity));
    verify(() => repository.getMovie(mockedMovieEntity.id)).called(1);
  });

  test('Should return a failure when something went wrong', () async {
    failureMock();

    final result = await usecase(mockedMovieEntity.id);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getMovie(mockedMovieEntity.id)).called(1);
  });
}