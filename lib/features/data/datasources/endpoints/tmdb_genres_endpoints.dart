class TmdbGenreEndpoints {
  static String getGenres(String apiKey) => "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey";
}