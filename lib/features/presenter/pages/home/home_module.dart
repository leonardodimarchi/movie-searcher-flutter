import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_searcher_flutter/features/data/datasources/tmdb_genre_datasource_implementation.dart';
import 'package:movie_searcher_flutter/features/data/repositories/genre_repository_implementation.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/search_movies_usecase.dart';

import '../../../../core/http_client/http_client_implementation.dart';
import '../../../data/datasources/tmdb_movie_datasource_implementation.dart';
import '../../../data/repositories/movie_repository_implementation.dart';
import '../../../domain/usecases/get_genres_usecase.dart';
import '../../../domain/usecases/get_movies_usecase.dart';
import 'controller/home_store.dart';
import 'ui/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(getGenresUsecase: i(), getMoviesUsecase: i(), searchMoviesUsecase: i())),
    Bind.lazySingleton((i) => SearchMoviesUsecase(repository: i())),
    Bind.lazySingleton((i) => GetGenresUsecase(repository: i())),
    Bind.lazySingleton((i) => GetMoviesUsecase(repository: i())),
    Bind.lazySingleton((i) => GenreRepositoryImplementation(datasource: i())),
    Bind.lazySingleton((i) => TmdbGenreDatasourceImplementation(httpClient: i())),
    Bind.lazySingleton((i) => MovieRepositoryImplementation(datasource: i())),
    Bind.lazySingleton((i) => TmdbMovieDatasourceImplementation(httpClient: i())),
    Bind.lazySingleton((i) => HttpClientImplementation()),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}