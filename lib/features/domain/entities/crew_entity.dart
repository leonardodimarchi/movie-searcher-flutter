import 'package:equatable/equatable.dart';

class CrewEntity extends Equatable {
  final int id;
  final bool isAdult;
  final String knownForDepartment;
  final String originalName;
  final String name;
  final double popularity;
  final String profilePath;
  final String job;
  final String department;
  final String creditId;

  const CrewEntity({
    required this.id,
    required this.isAdult,
    required this.knownForDepartment,
    required this.originalName,
    required this.name,
    required this.popularity,
    required this.profilePath,
    required this.job,
    required this.department,
    required this.creditId,
  });

  @override
  List<Object?> get props => [
        id,
        isAdult,
        knownForDepartment,
        originalName,
        name,
        popularity,
        profilePath,
        job,
        department,
        creditId,
      ];
}
