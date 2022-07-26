import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_credits_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_usecase.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/movie/controller/movie_store.dart';

import '../../../mocks/movie_credits_entity_mock.dart';
import '../../../mocks/movie_detail_entity_mock.dart';

class MockedGetMovieUsecase extends Mock implements GetMovieUsecase {}

class MockedGetMovieCreditsUsecase extends Mock implements GetMovieCreditsUsecase {}

void main() {
  late MovieStore movieStore;
  late GetMovieUsecase getMovieUsecase;
  late GetMovieCreditsUsecase getMovieCreditsUsecase;

  final noParams = NoParams();
  const mockedMovieId = 1;

  setUp(() {
    getMovieUsecase = MockedGetMovieUsecase();
    getMovieCreditsUsecase = MockedGetMovieCreditsUsecase();

    movieStore = MovieStore(
        movieId: mockedMovieId,
        getMovieUsecase: getMovieUsecase,
        getMovieCreditsUsecase: getMovieCreditsUsecase,
      );

    registerFallbackValue(noParams);
  });

  group('GetMovie', () {
    const mockedMovieDetailEntity = movieDetailEntityMock;

    test('Should return a movie entity from the GetMovieUseCase', () async {
      when(() => getMovieUsecase(any()))
          .thenAnswer((_) async => const Right(mockedMovieDetailEntity));

      await movieStore.getMovie();

      expect(movieStore.state.movie, mockedMovieDetailEntity);
      verify(() => getMovieUsecase(mockedMovieId)).called(1);
    });

    test(
        'Should return a failure from the GetMoviesUseCase when there is an error',
        () async {
      when(() => getMovieUsecase(any()))
          .thenAnswer((_) async => Left(ServerFailure()));

      await movieStore.getMovie();

      movieStore.observer(onError: (error) {
        expect(error, ServerFailure());
        verify(() => getMovieUsecase(mockedMovieId)).called(1);
      });
    });
  });

  group('GetMovieCredits', () {
    const mockedMovieCredits = mockedMovieCreditsEntity;

    test('Should return a MovieCreditsEntity from the GetMovieCreditsUseCase', () async {
      when(() => getMovieCreditsUsecase(any()))
          .thenAnswer((_) async => const Right(mockedMovieCredits));

      await movieStore.getMovieCredits();

      expect(movieStore.state.movieCredits, mockedMovieCredits);
      verify(() => getMovieCreditsUsecase(mockedMovieId)).called(1);
    });

    test('Should return a failure from the GetMovieCreditsUsecase when there is an error', () async {
      when(() => getMovieCreditsUsecase(any()))
          .thenAnswer((_) async => Left(ServerFailure()));

      await movieStore.getMovieCredits();

      movieStore.observer(onError: (error) {
        expect(error, ServerFailure());
        verify(() => getMovieCreditsUsecase(mockedMovieId)).called(1);
      });
    });
  });
}
