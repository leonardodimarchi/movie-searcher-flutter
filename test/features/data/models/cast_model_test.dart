import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searcher_flutter/features/data/models/cast_model.dart';
import 'package:movie_searcher_flutter/features/domain/entities/cast_entity.dart';

import '../../../mocks/cast_entity_json_mock.dart';
import '../../../mocks/cast_model_mock.dart';

void main() {
  test('Should be a subclass of CastEntity', () {
    expect(mockedCastModel, isA<CastEntity>());
  });

  test('Should return a valid model (fromJson)', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(mockedCastEntityJson);

    // Act
    final result = CastModel.fromJson(jsonMap);

    // Assert
    expect(result, mockedCastModel);
  });

  test('Should return a json map with the proper data when calling toJson method', () {
    const expectedMap = {
      "id": 634649,
      "credit_id": "Mocked creditId",
      "character": "Mocked character",
      "adult": true,
      "name": "Mocked name",
      "original_name": "Mocked originalName",
      "popularity": 2,
      "profile_path": "Mocked profilePath",
      "cast_id": 2,
      "order": 2,
      "known_for_department": "Mocked knownForDepartment"
    };

    final result = mockedCastModel.toJson();

    expect(result, expectedMap);
  });
}
