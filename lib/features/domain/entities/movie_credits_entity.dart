import 'package:equatable/equatable.dart';
import 'package:movie_searcher_flutter/features/domain/entities/cast_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/crew_entity.dart';

class MovieCreditsEntity extends Equatable {
  final int id;
  final List<CastEntity> cast;
  final List<CrewEntity> crew;

  const MovieCreditsEntity({
    required this.id,
    required this.cast,
    required this.crew,
  });

  @override
  List<Object?> get props => [
    id,
    cast,
    crew,
  ];
}