import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';

const movieDetailEntityMock = MovieDetailEntity(
  id: 634649,
  title: "Spider-Man: No Way Home",
  description: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
  releaseDate: "2021-12-15",
  image: 'https://image.tmdb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
  backdropImage: "https://image.tmdb.org/t/p/original/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
  average: 8.3,
  budget: 2000,
  genres: [
    GenreEntity(id: 1, name: "Action")
  ]
);