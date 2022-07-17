import 'package:equatable/equatable.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String releaseDate;
  final String image;
  final String backdropImage;
  final int runtimeInMinutes;
  final double average;
  final double budget;
  final List<GenreEntity> genres;

  const MovieDetailEntity({
    required this.id, 
    required this.title, 
    required this.description,
    required this.releaseDate,
    required this.image,
    required this.backdropImage,
    required this.runtimeInMinutes,
    required this.average,
    required this.budget,
    required this.genres
  });

  @override
  List<Object?> get props => [
    id, 
    title, 
    description,
    releaseDate,
    image,
    backdropImage,
    runtimeInMinutes,
    average,
    budget,
    genres
  ];
}
