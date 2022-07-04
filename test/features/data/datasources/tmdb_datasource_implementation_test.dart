import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_searcher_flutter/core/errors/exceptions.dart';
import 'package:movie_searcher_flutter/core/http_client/http_client.dart';
import 'package:movie_searcher_flutter/core/utils/keys/tmdb_api_keys.dart';
import 'package:movie_searcher_flutter/features/data/datasources/endpoints/tmdb_endpoints.dart';
import 'package:movie_searcher_flutter/features/data/datasources/movie_datasource.dart';
import 'package:movie_searcher_flutter/features/data/datasources/tmdb_datasource_implementation.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';

import '../../../mocks/movie_entity_json_mock.dart';

class HttpClientMock extends Mock implements HttpClient {

}

void main() {
  late MovieDatasource datasource;
  late HttpClient httpClient;

  setUp(() {
    httpClient = HttpClientMock();
    datasource = TmdbDatasourceImplementation(httpClient: httpClient);
  });

  final expectedUrl = TmdbEndpoints.discoverMovies(TmdbApiKeys.apiKey);

  void successMock() {
    when(() => httpClient.get(any()))
      .thenAnswer((_) async => HttpResponse(data: movieListJsonMock, statusCode: 200));
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
        description: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
        releaseDate: "2021-12-15",
        image: "https://image.tmdb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
        backdropImage: "https://image.tmdb.org/t/p/original/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
        average: 8.3
      ),
      MovieModel(
        id: 414906,
        title: "The Batman",
        description: "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
        releaseDate: "2022-03-01",
        image: "https://image.tmdb.org/t/p/original/74xTEgt7R36Fpooo50r9T25onhq.jpg",
        backdropImage: "https://image.tmdb.org/t/p/original/5P8SmMzSNYikXpxil6BYzJ16611.jpg",
        average: 8
      ),
    ];

    final result =  await datasource.getMovies(1);

    expect(result, expectedList);
  });

  test('Should throw a ServerException when the call is unsuccessfull', () async {
    when(() => httpClient.get(any()))
      .thenAnswer((_) async => HttpResponse(
        data: 'Something went wrong', 
        statusCode: 400,
      ));

    final result = datasource.getMovies(1);

    expect(() => result, throwsA(ServerException()));
  });
}