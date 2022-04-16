class TmdbEndpoints {
  static String discoverMovies(String apiKey, int page) => "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&page=$page";
}