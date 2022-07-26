import 'package:movie_searcher_flutter/features/domain/entities/crew_entity.dart';

class CrewModel extends CrewEntity {
  const CrewModel({
    required int id,
    required bool isAdult,
    required String knownForDepartment,
    required String originalName,
    required String name,
    required int popularity,
    required String profilePath,
    required String job,
    required String department,
    required String creditId,
  }) : super(
          id: id,
          isAdult: isAdult,
          knownForDepartment: knownForDepartment,
          originalName: originalName,
          name: name,
          popularity: popularity,
          profilePath: profilePath,
          job: job,
          department: department,
          creditId: creditId,
        );

  factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
        id: json['id'] ?? "",
        isAdult: json['adult'] ?? false,
        knownForDepartment: json['known_for_department'] ?? "",
        originalName: json['original_name'] ?? "",
        name: json['name'] ?? "",
        popularity: json['popularity'] ?? 0,
        profilePath: json['profile_path'] ?? "",
        job: json['job'] ?? "",
        department: json['department'] ?? "",
        creditId: json['credit_id'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'adult': isAdult,
        'known_for_department': knownForDepartment,
        'original_name': originalName,
        'name': name,
        'popularity': popularity,
        'profile_path': profilePath,
        'job': job,
        'department': department,
        'credit_id': creditId,
      };
}
