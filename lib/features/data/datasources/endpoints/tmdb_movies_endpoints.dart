class TmdbMoviesEndpoints {
  static String popularMovies(String apiKey, { int page = 1 }) => "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&page=$page";
  static String topRatedMovies(String apiKey, { int page = 1 }) => "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&page=$page";
  static String upcomingMovies(String apiKey, { int page = 1 }) => "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&page=$page";
  static String movieDetails(String apiKey, { required int id }) => "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey";
  static String searchMovies(String apiKey, { String searchText = '', int page = 1 }) => "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$searchText&page=$page";
  static String movieCredits(String apiKey, { required int movieId }) => "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";
}