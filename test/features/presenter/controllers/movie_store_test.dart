import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_genres_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movie_usecase.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/movie/controller/movie_store.dart';

import '../../../mocks/genre_entity.mock.dart';
import '../../../mocks/movie_entity_mock.dart';

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
    const mockedMovieEntity = movieEntityMock;

    test('Should return a movie entity from the GetMovieUseCase', () async {
      when(() => getMovieUsecase(any()))
          .thenAnswer((_) async => const Right(mockedMovieEntity));

      await movieStore.getMovie();

      expect(movieStore.state.movie, mockedMovieEntity);
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

  group('GetGenres', () {
    const genreEntityList = [
      mockedGenreEntity,
      mockedGenreEntity,
      mockedGenreEntity,
    ];

    test('Should return a List of genres from the GetGenresUsecase', () async {
      when(() => getGenresUsecase(any()))
          .thenAnswer((_) async => const Right(genreEntityList));

      await movieStore.getGenres();

      movieStore.observer(
        onState: (state) {
          expect(state.genres, genreEntityList);
          verify(() => getGenresUsecase(noParams)).called(1);
        },
      );
    });

    test(
        'Should return a failure from the GetMoviesUseCase when there is an error',
        () async {
      when(() => getGenresUsecase(any()))
          .thenAnswer((_) async => Left(ServerFailure()));

      await movieStore.getGenres();

      movieStore.observer(onError: (error) {
        expect(error, ServerFailure());
        verify(() => getGenresUsecase(noParams)).called(1);
      });
    });
  });
}
