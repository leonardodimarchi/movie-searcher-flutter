class TmdbMoviesEndpoints {
  static String discoverMovies(String apiKey, { int page = 1 }) => "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&page=$page";
}