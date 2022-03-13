import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_model.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

import '../../../mocks/movie_entity_json_mock.dart';
import '../../../mocks/movie_model_mock.dart';

void main() {
  test('Should be a subclass of MovieEntity', () {
    expect(movieModelMock, isA<MovieEntity>());
  });

  test('Should return a valid model (fromJson)', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(movieEntityJsonMock);

    // Act
    final result = MovieModel.fromJson(jsonMap);

    // Assert
    expect(result, movieModelMock);
  });

  test('Should return a json map with the proper data when calling toJson method', () {
    final expectedMap = {
      "id": 634649,
      "title": "Spider-Man: No Way Home",
      "overview": "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
      "release_date": "2021-12-15",
      "poster_path": "https://image.tmdb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
      "backdrop_path": "https://image.tmdb.org/t/p/original/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
      "vote_average": 8.3,
    };

    final result = movieModelMock.toJson();

    expect(result, expectedMap);
  });
}
