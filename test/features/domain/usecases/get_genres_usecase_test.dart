
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/core/usecase/usecase.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/genre_repository.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_genres_usecase.dart';

import '../../../mocks/genre_entity.mock.dart';

class MockedGetGenreRepository extends Mock implements GenreRepository {

}

void main() {
  late GetGenresUsecase usecase;
  late GenreRepository repository;

  setUp(() {
    repository = MockedGetGenreRepository();
    usecase = GetGenresUsecase(repository: repository);
  });

  final NoParams noParams = NoParams();
  final List<GenreEntity> mockedGenreEntities = [
    mockedGenreEntity,
    mockedGenreEntity,
    mockedGenreEntity,
  ];

  test('Should retrieve a list of genres when successful', () async {
    when(() => repository.getGenres())
      .thenAnswer((_) async => Right(mockedGenreEntities));

    final result = await usecase(noParams);

    expect(result, Right(mockedGenreEntities));
    verify(() => repository.getGenres()).called(1);
  });

  test('Should return a failure when the repository call is unsuccessful', () async {
    when(() => repository.getGenres())
    .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(noParams);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getGenres()).called(1);
  });
}