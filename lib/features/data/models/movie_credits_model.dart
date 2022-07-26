import 'package:movie_searcher_flutter/features/data/models/cast_model.dart';
import 'package:movie_searcher_flutter/features/data/models/crew_model.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_credits_entity.dart';

class MovieCreditsModel extends MovieCreditsEntity {
  const MovieCreditsModel({
    required int id, 
    required List<CrewModel> crew, 
    required List<CastModel> cast,
  }) : super(
    id: id, 
    crew: crew, 
    cast: cast,
  );

  factory MovieCreditsModel.fromJson(Map<String, dynamic> json) => 
    MovieCreditsModel(
      id: json['id'] ?? "", 
      crew: json['crew'] != null ? List.from(json['crew']).map((g) => CrewModel.fromJson(g)).toList() : [],
      cast: json['cast'] != null ? List.from(json['cast']).map((g) => CastModel.fromJson(g)).toList() : [],
    );

  Map<String, dynamic> toJson() => {
    'id': id,
    'crew': crew,
    'cast': cast,
  };
}