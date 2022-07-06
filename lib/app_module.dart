import 'package:flutter_modular/flutter_modular.dart';
import 'features/presenter/pages/home/home_module.dart';

class AppModule extends Module {

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
  ];
}