import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_credits_usecase.dart';

import '../../../mocks/movie_credits_entity_mock.dart';

class MockedMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetMovieCreditsUsecase usecase;
  late MovieRepository repository;

  setUp(() {
    repository = MockedMovieRepository();
    usecase = GetMovieCreditsUsecase(repository: repository);
  });

  const mockedMovieCredits = mockedMovieCreditsEntity;
  const mockedMovieId = 10;

  void successMock() {
    when(() => repository.getMovieCredits(any()))
      .thenAnswer((_) async => const Right(mockedMovieCredits));
  }

  void failureMock() {
    when(() => repository.getMovieCredits(any()))
      .thenAnswer((_) async => Left(ServerFailure()));
  }

  test('Should call repository with the correct params', () async {
    successMock();

    await usecase(mockedMovieId);

    verify(() => repository.getMovieCredits(mockedMovieId)).called(1);
  });

  test('Should return a movie credits entity when calling sucessfully', () async {
    successMock();

    final result = await usecase(mockedMovieId);

    expect(result, const Right(mockedMovieCredits));
    verify(() => repository.getMovieCredits(mockedMovieId)).called(1);
  });

  test('Should return a failure when something went wrong', () async {
    failureMock();

    final result = await usecase(mockedMovieId);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getMovieCredits(mockedMovieId)).called(1);
  });
}