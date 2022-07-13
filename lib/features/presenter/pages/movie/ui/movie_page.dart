// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/home/viewmodel/home_viewmodel.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/movie/viewmodel/movie_viewmodel.dart';
import 'package:movie_searcher_flutter/features/presenter/widgets/movie_banner.dart';

import '../../../widgets/movie_card.dart';
import '../controller/movie_store.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends ModularState<MoviePage, MovieStore> {
  final Color backgroundColor = Colors.grey[850]!;

  @override
  void initState() {
    super.initState();

    store.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ScopedBuilder(
          store: store,
          onLoading: (context) =>
              const Center(child: CircularProgressIndicator()),
          onError: (context, error) => Center(
                child: Text(
                  'An error occurred, try again later.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white70),
                ),
              ),
          onState: (context, MovieViewModel state) {
            return ScrollConfiguration(
                behavior: const ScrollBehavior(
                    androidOverscrollIndicator:
                        AndroidOverscrollIndicator.stretch),
                child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: backgroundColor,
                    child: Stack(children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop),
                        child: MovieBanner(
                          backgroundColor,
                          height: 400,
                          imageUrl: state.movie.backdropImage,
                        ),
                      ),
                      SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                top: 150,
                                bottom: 50,
                                left: 50,
                                right: 50,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      height: 400,
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withAlpha(100),
                                            blurRadius: 10.0),
                                      ]),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 145),
                                            child: Container(
                                              color: Colors.grey[900],
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          ),
                                          Image(
                                            image:
                                                NetworkImage(state.movie.image),
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          state.movie.title,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                color: Colors.white,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[800]!,
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.grey[700]!)),
                                        child: Center(
                                          child: Text(
                                            state.movie.average.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color:
                                                      state.movie.average >= 5
                                                          ? Colors.green
                                                          : Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ))),
                      Positioned(
                        left: 20,
                        top: 65,
                        child: BackButton(
                            color: Colors.white,
                            onPressed: () => Modular.to.navigate('/')),
                      ),
                    ])));
          }),
    );
  }
}
