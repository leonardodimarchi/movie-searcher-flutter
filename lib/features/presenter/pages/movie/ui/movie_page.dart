// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/home/viewmodel/home_viewmodel.dart';
import 'package:movie_searcher_flutter/features/presenter/widgets/movie_banner.dart';

import '../../../widgets/movie_card.dart';
import '../controller/movie_store.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends ModularState<MoviePage, MovieStore> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
