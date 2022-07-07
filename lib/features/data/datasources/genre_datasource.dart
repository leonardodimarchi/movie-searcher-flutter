import 'package:movie_searcher_flutter/features/data/models/genre_model.dart';


abstract class GenreDataSource {
  Future<List<GenreModel>> getGenres();
}