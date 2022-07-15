import 'package:movie_searcher_flutter/features/data/datasources/endpoints/movie_image_prefix.dart';
import 'package:movie_searcher_flutter/features/data/models/genre_model.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';

class MovieDetailModel extends MovieDetailEntity {
  const MovieDetailModel({
    required int id, 
    required String title, 
    required String description,
    required String releaseDate,
    required String image,
    required String backdropImage,
    required double average,
    required double budget,
    required List<GenreModel> genres
  }) : super(
    id: id, 
    title: title, 
    description: description,
    releaseDate: releaseDate,
    image: image,
    backdropImage: backdropImage,
    average: average,
    budget: budget,
    genres: genres,
  );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => 
    MovieDetailModel(
      id: json['id'] ?? "", 
      title: json['title'] ?? "",
      description: json['overview'] ?? "",
      releaseDate: json['release_date'] ?? "",
      image: json['poster_path'] != null ? MovieImagePrefix.movieImagePrefix() + json['poster_path'] : "",
      backdropImage: json['backdrop_path'] != null ? MovieImagePrefix.movieImagePrefix() + json['backdrop_path'] : "",
      average: json['vote_average'] != null ? double.parse(json['vote_average'].toString()) : 0,
      budget: json['budget'] != null ? double.parse(json['budget'].toString()) : 0,
      genres: json['genres'] != null ? List.from(json['genres']).map((g) => GenreModel.fromJson(g)).toList() : [],
    );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'overview': description,
    'release_date': releaseDate,
    'poster_path': image,
    'backdrop_path': backdropImage,
    'vote_average': average,
    'budget': budget,
    'genres': genres,
  };
}