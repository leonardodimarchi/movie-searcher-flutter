import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';
import 'package:movie_searcher_flutter/features/presenter/controllers/home_store.dart';

import '../../../mocks/movie_entity_mock.dart';

class MockGetMoviesUsecase extends Mock implements GetMoviesUsecase {

}

void main() {
  late HomeStore homeStore;
  late GetMoviesUsecase mockUsecase;

  setUp((){
    mockUsecase = MockGetSpaceMediaByDateUseCase();
    homeStore = HomeStore(mockUsecase);
  });

  final mockedFailure = ServerFailure();
  const movieEntityList = [
    movieEntityMock,
    movieEntityMock,
    movieEntityMock,
  ]

  test('Should return a List of movie entities from the usecase', () async {
    when(() => mockUsecase(any())).thenAnswer((_) async => const Right(movieEntityList));

    await homeStore.getMovies();

    homeStore.observer(
      onState: (state) {
        expect(state, movieEntityList);
        verify(() => mockUsecase()).called(1);
      },
    );
  });

  test('Should return a failure from the usecase when there is an error', () async {
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(mockedFailure));

    await homeStore.getMovies();

    homeStore.observer(
      onError: (error) {
        expect(error, mockedFailure);
        verify(() => mockUsecase(mockedDate)).called(1);
      }
    );
  });
}