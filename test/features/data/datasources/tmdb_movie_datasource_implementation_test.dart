import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/http_client/http_client.dart';
import 'package:movie_searcher_flutter/core/utils/keys/tmdb_api_keys.dart';
import 'package:movie_searcher_flutter/features/data/datasources/endpoints/tmdb_movies_endpoints.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/data/datasources/tmdb_movie_datasource_implementation.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_detail_model.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';

import '../../../mocks/movie_credits_entity_json_mock.dart';
import '../../../mocks/movie_credits_model_mock.dart';
import '../../../mocks/movie_detail_entity_json_mock.dart';
import '../../../mocks/movie_entity_json_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late MovieDatasource datasource;
  late HttpClient httpClient;

  setUp(() {
    httpClient = HttpClientMock();
    datasource = TmdbMovieDatasourceImplementation(httpClient: httpClient);
  });

  group('getMovies', () {
    final expectedUrl = TmdbMoviesEndpoints.discoverMovies(TmdbApiKeys.apiKey);

    void successMock() {
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => HttpResponse(data: movieListJsonMock, statusCode: 200));
    }

    void failureMock() {
      when(() => httpClient.get(any())).thenAnswer((_) async => HttpResponse(
            data: 'Something went wrong',
            statusCode: 400,
          ));
    }

    test('Should call get method with correct url', () async {
      successMock();

      await datasource.getMovies(1);

      verify(() => httpClient.get(expectedUrl)).called(1);
    });

    test('Should return a list of MovieModel when successfull', () async {
      successMock();

      const expectedList = [
        MovieModel(
          id: 634649,
          title: "Spider-Man: No Way Home",
          description:
              "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
          releaseDate: "2021-12-15",
          image:
              "https://image.tmdb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
          backdropImage:
              "https://image.tmdb.org/t/p/original/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
          average: 8.3,
          genreIds: [],
        ),
        MovieModel(
          id: 414906,
          title: "The Batman",
          description:
              "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
          releaseDate: "2022-03-01",
          image:
              "https://image.tmdb.org/t/p/original/74xTEgt7R36Fpooo50r9T25onhq.jpg",
          backdropImage:
              "https://image.tmdb.org/t/p/original/5P8SmMzSNYikXpxil6BYzJ16611.jpg",
          average: 8,
          genreIds: [],
        ),
      ];

      final result = await datasource.getMovies(1);

      expect(result, expectedList);
    });

    test('Should throw a ServerException when the call is unsuccessfull',
        () async {
      failureMock();

      final result = datasource.getMovies(1);

      expect(() => result, throwsA(ServerException()));
    });
  });

  group('getMovie', () {
    const mockedMovieDetailEntityJson = movieDetailEntityJsonMock;
    final mockedMovieDetailsModel =
        MovieDetailModel.fromJson(jsonDecode(mockedMovieDetailEntityJson));

    final expectedUrl = TmdbMoviesEndpoints.movieDetails(TmdbApiKeys.apiKey,
        id: mockedMovieDetailsModel.id);

    void successMock() {
      when(() => httpClient.get(any())).thenAnswer((_) async =>
          HttpResponse(data: mockedMovieDetailEntityJson, statusCode: 200));
    }

    void failureMock() {
      when(() => httpClient.get(any())).thenAnswer((_) async => HttpResponse(
            data: 'Something went wrong',
            statusCode: 400,
          ));
    }

    test('Should call get method with correct url', () async {
      successMock();

      await datasource.getMovie(mockedMovieDetailsModel.id);

      verify(() => httpClient.get(expectedUrl)).called(1);
    });

    test('Should return a movie model if successful', () async {
      successMock();

      final result = await datasource.getMovie(mockedMovieDetailsModel.id);

      expect(result, mockedMovieDetailsModel);
      verify(() => httpClient.get(expectedUrl)).called(1);
    });

    test('Should throw a ServerException if something is wrong', () async {
      failureMock();

      final result = datasource.getMovie(mockedMovieDetailsModel.id);

      expect(() => result, throwsA(ServerException()));
    });
  });

  group('getMovieCredits', () {
    const mockedMovieId = 1;
    const mockedMovieCreditsJson = movieCreditsEntityJsonMock;
    const mockedMovieCreditsModel = movieCreditsModelMock;
    
    final expectedUrl = TmdbMoviesEndpoints.movieCredits(TmdbApiKeys.apiKey, movieId: mockedMovieId);

    void successMock() {
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => HttpResponse(data: mockedMovieCreditsJson, statusCode: 200));
    }

    void failureMock() {
      when(() => httpClient.get(any())).thenAnswer((_) async => HttpResponse(
            data: 'Something went wrong',
            statusCode: 400,
          ));
    }

    test('Should call get method with correct url', () async {
      successMock();

      await datasource.getMovieCredits(mockedMovieId);

      verify(() => httpClient.get(expectedUrl)).called(1);
    });

    test('Should return a MovieCreditsModel when successfull', () async {
      successMock();

      final result = await datasource.getMovieCredits(mockedMovieId);

      expect(result, mockedMovieCreditsModel);
    });

    test('Should throw a ServerException when the call is unsuccessfull', () async {
      failureMock();

      final result = datasource.getMovieCredits(mockedMovieId);

      expect(() => result, throwsA(ServerException()));
    });
  });

  group('searchMovies', () {
    const mockedSearchText = 'Search text';
    const mockedParams = SearchMovieParams(
      searchText: mockedSearchText,
      page: 0,
    );
    final expectedUrl = TmdbMoviesEndpoints.searchMovies(TmdbApiKeys.apiKey,
        searchText: mockedParams.searchText, page: mockedParams.page);

    void successMock() {
      when(() => httpClient.get(any())).thenAnswer(
          (_) async => HttpResponse(data: movieListJsonMock, statusCode: 200));
    }

    void failureMock() {
      when(() => httpClient.get(any())).thenAnswer((_) async => HttpResponse(
            data: 'Something went wrong',
            statusCode: 400,
          ));
    }

    test('Should call get method with correct url', () async {
      successMock();

      await datasource.searchMovies(mockedParams);

      verify(() => httpClient.get(expectedUrl)).called(1);
    });

    test('Should return a list of MovieModel when successfull', () async {
      successMock();

      const expectedList = [
        MovieModel(
          id: 634649,
          title: "Spider-Man: No Way Home",
          description:
              "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
          releaseDate: "2021-12-15",
          image:
              "https://image.tmdb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
          backdropImage:
              "https://image.tmdb.org/t/p/original/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
          average: 8.3,
          genreIds: [],
        ),
        MovieModel(
          id: 414906,
          title: "The Batman",
          description:
              "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
          releaseDate: "2022-03-01",
          image:
              "https://image.tmdb.org/t/p/original/74xTEgt7R36Fpooo50r9T25onhq.jpg",
          backdropImage:
              "https://image.tmdb.org/t/p/original/5P8SmMzSNYikXpxil6BYzJ16611.jpg",
          average: 8,
          genreIds: [],
        ),
      ];

      final result = await datasource.searchMovies(mockedParams);

      expect(result, expectedList);
    });

    test('Should throw a ServerException when the call is unsuccessfull',
        () async {
      failureMock();

      final result = datasource.searchMovies(mockedParams);

      expect(() => result, throwsA(ServerException()));
    });
  });
}
