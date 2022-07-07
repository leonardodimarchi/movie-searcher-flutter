import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/http_client/http_client.dart';
import 'package:movie_searcher_flutter/core/utils/keys/tmdb_api_keys.dart';
import 'package:movie_searcher_flutter/features/data/datasources/endpoints/tmdb_genres_endpoints.dart';
import 'package:movie_searcher_flutter/features/data/datasources/genre_datasource.dart';
import 'package:movie_searcher_flutter/features/data/datasources/tmdb_genre_datasource_implementation.dart';
import 'package:movie_searcher_flutter/features/data/models/genre_model.dart';

import '../../../mocks/genre_entity_json_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late GenreDataSource datasource;
  late HttpClient httpClient;

  setUp(() {
    httpClient = HttpClientMock();
    datasource = TmdbGenreDatasourceImplementation(httpClient: httpClient);
  });

  final expectedUrl = TmdbGenreEndpoints.getGenres(TmdbApiKeys.apiKey);

  void successMock() {
    when(() => httpClient.get(any())).thenAnswer((_) async =>
        HttpResponse(data: mockedGenreEntityJsonList, statusCode: 200));
  }

  test('Should call get method with correct url', () async {
    successMock();

    await datasource.getGenres();

    verify(() => httpClient.get(expectedUrl)).called(1);
  });

  test('Should return a list of GenreModel when successfull', () async {
    successMock();
    const expectedList = [
      GenreModel(
        id: 1,
        name: "Action",
      ),
    ];

    final result = await datasource.getGenres();

    expect(result, expectedList);
  });

  test('Should throw a ServerException when the call is unsuccessfull',
      () async {
    when(() => httpClient.get(any())).thenAnswer((_) async => HttpResponse(
          data: 'Something went wrong',
          statusCode: 400,
        ));

    final result = datasource.getGenres();

    expect(() => result, throwsA(ServerException()));
  });
}
