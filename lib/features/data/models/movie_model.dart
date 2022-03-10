import 'package:movie-searcher-flutter/features/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required int id, 
    required String title, 
    required String description,
    required String releaseDate,
    required String image,
    required String backdropImage,
    required double average,
  }) : super(
    id, 
    title, 
    description,
    releaseDate,
    image,
    backdropImage,
    average
  );

    factory MovieModel.fromJson(Map<String, dynamic> json) => 
      MovieModel(
        id: json['id'], 
        title: json['title'],
        description: json['description'],
        releaseDate: json['releaseDate'],
        image: json['image'],
        backdropImage: json['backdropImage'],
        average: json['average'],
      );

    Map<String, dynamic> toJson() => {
      'id': id,
      'title': title,
      'description': description,
      'releaseDate': releaseDate,
      'image': image,
      'backdropImage': backdropImage,
      'average': average
    };
}