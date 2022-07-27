import 'package:movie_searcher_flutter/features/data/datasources/endpoints/movie_image_prefix.dart';
import 'package:movie_searcher_flutter/features/domain/entities/cast_entity.dart';

class CastModel extends CastEntity {
  const CastModel({
    required int id,
    required bool isAdult,
    required String knownForDepartment,
    required String originalName,
    required String name,
    required double popularity,
    required String profilePath,
    required String character,
    required String creditId,
    required int castId,
    required int order,
  }) : super(
          id: id,
          isAdult: isAdult,
          knownForDepartment: knownForDepartment,
          originalName: originalName,
          name: name,
          popularity: popularity,
          profilePath: profilePath,
          character: character,        
          creditId: creditId,
          castId: castId,
          order: order,
        );

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        id: json['id'] ?? "",
        isAdult: json['adult'] ?? false,
        knownForDepartment: json['known_for_department'] ?? "",
        originalName: json['original_name'] ?? "",
        name: json['name'] ?? "",
        popularity: json['popularity'] != null ? json['popularity'].toDouble() : 0,
        profilePath: json['profile_path'] != null ? MovieImagePrefix.tmdbOriginalImagePrefix() + json['profile_path'] : "",
        character: json['character'] ?? "",
        creditId: json['credit_id'] ?? "",
        castId: json['cast_id'] ?? 0,
        order: json['order'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'adult': isAdult,
        'known_for_department': knownForDepartment,
        'original_name': originalName,
        'name': name,
        'popularity': popularity,
        'profile_path': profilePath,
        'character': character,
        'cast_id': castId,
        'credit_id': creditId,
        'order': order,
      };
}
