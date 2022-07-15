import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_genres_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_usecase.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/movie/controller/movie_store.dart';

import '../../../mocks/movie_detail_entity_mock.dart';

class MockedGetGenresUsecase extends Mock implements GetGenresUsecase {}

class MockedGetMovieUsecase extends Mock implements GetMovieUsecase {}

void main() {
  late MovieStore movieStore;
  late GetGenresUsecase getGenresUsecase;
  late GetMovieUsecase getMovieUsecase;

  final noParams = NoParams();
  const mockedMovieId = 1;

  setUp(() {
    getGenresUsecase = MockedGetGenresUsecase();
    getMovieUsecase = MockedGetMovieUsecase();
    movieStore = MovieStore(
        movieId: mockedMovieId,
        getGenresUsecase: getGenresUsecase,
        getMovieUsecase: getMovieUsecase);

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
}
