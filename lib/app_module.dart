import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_searcher_flutter/core/http_client/http_client_implementation.dart';
import 'package:movie_searcher_flutter/features/data/datasources/tmdb_movie_datasource_implementation.dart';
import 'package:movie_searcher_flutter/features/data/repositories/movie_repository_implementation.dart';
import 'package:movie_searcher_flutter/features/domain/usecases/get_movies_usecase.dart';
import 'package:movie_searcher_flutter/features/presenter/controllers/home_store.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(i())),
    Bind.lazySingleton((i) => GetMoviesUsecase(repository: i())),
    Bind.lazySingleton((i) => MovieRepositoryImplementation(datasource: i())),
    Bind.lazySingleton((i) => TmdbMovieDatasourceImplementation(httpClient: i())),
    Bind.lazySingleton((i) => HttpClientImplementation()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage()),
  ];
}