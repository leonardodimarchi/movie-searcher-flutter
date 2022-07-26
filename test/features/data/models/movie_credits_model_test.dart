import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_credits_model.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_credits_entity.dart';

import '../../../mocks/movie_credits_entity_json_mock.dart';
import '../../../mocks/movie_credits_model_mock.dart';

void main() {
  test('Should be a subclass of MovieCreditsEntity', () {
    expect(movieCreditsModelMock, isA<MovieCreditsEntity>());
  });

  test('Should return a valid model (fromJson)', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(movieCreditsEntityJsonMock);

    // Act
    final result = MovieCreditsModel.fromJson(jsonMap);

    // Assert
    expect(result, movieCreditsModelMock);
  });

  test('Should return a json map with the proper data when calling toJson method', () {
    const expectedMap = {
      "id": 634649,
      "cast": [],
      "crew": []
    };

    final result = movieCreditsModelMock.toJson();

    expect(result, expectedMap);
  });
}
