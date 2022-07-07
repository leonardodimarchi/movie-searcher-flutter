import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_genres_usecase.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/home/controller/home_store.dart';

import '../../../mocks/genre_entity.mock.dart';
import '../../../mocks/movie_entity_mock.dart';

class MockGetMoviesUsecase extends Mock implements GetMoviesUsecase {

}

class MockGetGenresUsecase extends Mock implements GetGenresUsecase {

}

void main() {
  late HomeStore homeStore;
  late GetMoviesUsecase mockedGetMoviesUsecase;
  late GetGenresUsecase mockedGetGenresUsecase;
  final noParams = NoParams();

  setUp((){
    mockedGetMoviesUsecase = MockGetMoviesUsecase();
    mockedGetGenresUsecase = MockGetGenresUsecase();
    homeStore = HomeStore(getMoviesUsecase: mockedGetMoviesUsecase, getGenresUsecase: mockedGetGenresUsecase);

    registerFallbackValue(NoParams());
  });

  final mockedFailure = ServerFailure();

  const movieEntityList = [
    movieEntityMock,
    movieEntityMock,
    movieEntityMock,
  ];

  const genreEntityList = [
    mockedGenreEntity,
    mockedGenreEntity,
    mockedGenreEntity,
  ];

  test('Should return a List of movie entities from the GetMoviesUseCase', () async {
    when(() => mockedGetMoviesUsecase(any())).thenAnswer((_) async => const Right(movieEntityList));

    await homeStore.getMovies();

    homeStore.observer(
      onState: (state) {
        expect(state.moviePagination, MoviePagination(page: 1, list: movieEntityList));
        verify(() => mockedGetMoviesUsecase(1)).called(1);
      },
    );
  });

  test('Should return a failure from the GetMoviesUseCase when there is an error', () async {
    when(() => mockedGetMoviesUsecase(any())).thenAnswer((_) async => Left(mockedFailure));

    await homeStore.getMovies();

    homeStore.observer(
      onError: (error) {
        expect(error, mockedFailure);
        verify(() => mockedGetMoviesUsecase(1)).called(1);
      }
    );
  });

  test('Should return a List of genres from the GetGenresUsecase', () async {
    when(() => mockedGetGenresUsecase(any())).thenAnswer((_) async => const Right(genreEntityList));

    await homeStore.getGenres();

    homeStore.observer(
      onState: (state) {
        expect(state.genres, genreEntityList);
        verify(() => mockedGetGenresUsecase(noParams)).called(1);
      },
    );
  });

  test('Should return a failure from the GetGenresUsecase when there is an error', () async {
    when(() => mockedGetGenresUsecase(any())).thenAnswer((_) async => Left(mockedFailure));

    await homeStore.getGenres();

    homeStore.observer(
      onError: (error) {
        expect(error, mockedFailure);
        verify(() => mockedGetGenresUsecase(noParams)).called(1);
      }
    );
  });
}