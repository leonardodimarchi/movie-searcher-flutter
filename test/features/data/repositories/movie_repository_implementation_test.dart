import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/data/repositories/movie_repository_implementation.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

import '../../../mocks/movie_credits_model_mock.dart';
import '../../../mocks/movie_detail_model_mock.dart';
import '../../../mocks/movie_model_mock.dart';

class MockMovieDatasource extends Mock implements MovieDatasource {}

void main() {
  late MovieRepositoryImplementation repository;
  late MovieDatasource datasource;

  setUp(() {
    datasource = MockMovieDatasource();
    repository = MovieRepositoryImplementation(datasource: datasource);

    registerFallbackValue(const SearchMovieParams(
      searchText: 'Search text',
    ));

    registerFallbackValue(const GetMoviesParams(page: 1, type: GetMovieType.popular));
  });

  const movieModelsListMock = [
    movieModelMock,
    movieModelMock,
    movieModelMock,
    movieModelMock,
  ];

  group('getMovies', () {
    const params = GetMoviesParams(page: 1, type: GetMovieType.popular);

    void successMock() {
      when(() => datasource.getMovies(any()))
          .thenAnswer((_) async => movieModelsListMock);
    }

    void failureMock() {
      when(() => datasource.getMovies(any())).thenThrow(ServerException());
    }

    test('Should return a list of MovieModel when calls the datasource',
        () async {
      successMock();

      final result = await repository.getMovies(params);

      expect(result, const Right(movieModelsListMock));
      verify(() => datasource.getMovies(params)).called(1);
    });

    test('Should throw an ServerFailure when data source call is unsucessfull',
        () async {
      failureMock();

      final result = await repository.getMovies(params);

      expect(result, Left(ServerFailure()));
      verify(() => datasource.getMovies(params)).called(1);
    });
  });

  group('getMovie', () {
    const mockedMovieDetailModel = movieDetailModelMock;

    void successMock() {
      when(() => datasource.getMovie(any()))
          .thenAnswer((_) async => mockedMovieDetailModel);
    }

    void failureMock() {
      when(() => datasource.getMovie(any())).thenThrow(ServerException());
    }

    test('Should return a MovieModel when calling the datasource', () async {
      successMock();

      final result = await repository.getMovie(mockedMovieDetailModel.id);

      expect(result, const Right(mockedMovieDetailModel));
      verify(() => datasource.getMovie(mockedMovieDetailModel.id)).called(1);
    });

    test('Should return a failure when datasource call is unsucessful',
        () async {
      failureMock();

      final result = await repository.getMovie(mockedMovieDetailModel.id);

      expect(result, Left(ServerFailure()));
      verify(() => datasource.getMovie(mockedMovieDetailModel.id)).called(1);
    });
  });

  group('searchMovies', () {
    const mockedSearchText = 'Search text';
    const mockedParams = SearchMovieParams(
      searchText: mockedSearchText,
    );

    void successMock() {
      when(() => datasource.searchMovies(any()))
          .thenAnswer((_) async => movieModelsListMock);
    }

    void failureMock() {
      when(() => datasource.searchMovies(any())).thenThrow(ServerException());
    }

    test('Should return a list of MovieModel when calling the datasource',
        () async {
      successMock();

      final result = await repository.searchMovies(mockedParams);

      expect(result, const Right(movieModelsListMock));
      verify(() => datasource.searchMovies(mockedParams)).called(1);
    });

    test('Should return a failure when datasource call is unsucessful',
        () async {
      failureMock();

      final result = await repository.searchMovies(mockedParams);

      expect(result, Left(ServerFailure()));
      verify(() => datasource.searchMovies(mockedParams)).called(1);
    });
  });

  group('getMovieCredits', () {
    const mockedMovieId = 10;
    const mockedMovieCredits = movieCreditsModelMock;

    void successMock() {
      when(() => datasource.getMovieCredits(any()))
          .thenAnswer((_) async => mockedMovieCredits);
    }

    void failureMock() {
      when(() => datasource.getMovieCredits(any())).thenThrow(ServerException());
    }

    test('Should return a MovieCreditsModel when calling the datasource',
        () async {
      successMock();

      final result = await repository.getMovieCredits(mockedMovieId);

      expect(result, const Right(mockedMovieCredits));
      verify(() => datasource.getMovieCredits(mockedMovieId)).called(1);
    });

    test('Should return a failure when datasource call is unsucessful',
        () async {
      failureMock();

      final result = await repository.getMovieCredits(mockedMovieId);

      expect(result, Left(ServerFailure()));
      verify(() => datasource.getMovieCredits(mockedMovieId)).called(1);
    });
  });
}
