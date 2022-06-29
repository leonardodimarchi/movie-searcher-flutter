class TmdbEndpoints {
  static String discoverMovies(String apiKey, { int page = 1 }) => "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page";
}