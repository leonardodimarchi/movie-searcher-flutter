import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_searcher_flutter/features/data/models/crew_model.dart';
import 'package:movie_searcher_flutter/features/domain/entities/crew_entity.dart';

import '../../../mocks/crew_entity_json_mock.dart';
import '../../../mocks/crew_model_mock.dart';

void main() {
  test('Should be a subclass of CrewEntity', () {
    expect(mockedCrewModel, isA<CrewEntity>());
  });

  test('Should return a valid model (fromJson)', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(mockedCrewEntityJson);

    // Act
    final result = CrewModel.fromJson(jsonMap);

    // Assert
    expect(result, mockedCrewModel);
  });

  test('Should return a json map with the proper data when calling toJson method', () {
    const expectedMap = {
      "id": 634649,
      "credit_id": "Mocked creditId",
      "department": "Mocked department",
      "adult": true,
      "name": "Mocked name",
      "original_name": "Mocked originalName",
      "popularity": 2,
      "profile_path": "https://image.tmdb.org/t/p/original/mocked.jpg",
      "job": "Mocked job",
      "known_for_department": "Mocked knownForDepartment"
    };

    final result = mockedCrewModel.toJson();

    expect(result, expectedMap);
  });
}
