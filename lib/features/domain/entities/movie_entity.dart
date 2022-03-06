import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
final int id;
final String title;
final String description;
final String releaseDate;
final String image;
final String backdropImage;
final double average;

  const MovieEntity({
    required this.id, 
    required this.title, 
    required this.description,
    required this.releaseDate,
    required this.image,
    required this.backdropImage,
    required this.average
  });

  @override
  List<Object?> get props => [
    id, 
    title, 
    description,
    releaseDate,
    image,
    backdropImage,
    average
  ];
}
