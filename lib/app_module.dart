import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/movie/movie_module.dart';
import 'features/presenter/pages/home/home_module.dart';

class AppModule extends Module {

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
    ModuleRoute('/movie', module: MovieModule()),
  ];
}