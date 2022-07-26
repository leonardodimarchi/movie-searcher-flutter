import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final int id;
  final bool isAdult;
  final String knownForDepartment;
  final String originalName;
  final String name;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  const CastEntity({
    required this.id,
    required this.isAdult,
    required this.knownForDepartment,
    required this.originalName,
    required this.name,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
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
        castId,
        character,
        creditId,
        order,
      ];
}
