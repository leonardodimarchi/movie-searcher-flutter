// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/cast_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/home/viewmodel/home_viewmodel.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/movie/viewmodel/movie_viewmodel.dart';
import 'package:movie_searcher_flutter/features/presenter/widgets/movie_banner.dart';
import 'package:movie_searcher_flutter/features/presenter/widgets/movie_cast_card.dart';

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

  String minutesToHourString(int minutes) {
    if (minutes == 0) {
      return '-';
    }

    var duration = Duration(minutes: minutes);

    List<String> parts = duration.toString().split(':');

    String hoursResult =
        int.parse(parts[0]) == 0 ? '' : '${parts[0].padLeft(1, '0')}h ';
    String minutesResult =
        int.parse(parts[1]) == 0 ? '' : '${parts[1].padLeft(1, '0')}m';

    return '$hoursResult$minutesResult';
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
            final releaseDate = DateFormat('dd/MM/yyyy')
                .format(DateTime.parse(state.movie.releaseDate));

            List<String> genreNames = [];

            genreNames = state.movie.genres.map((genre) => genre.name).toList();

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
                                top: 80,
                                bottom: 50,
                                left: 50,
                                right: 50,
                              ),
                              child: Column(
                                children: [
                                  Transform.translate(
                                    offset: const Offset(-20, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: BackButton(
                                          color: Colors.white,
                                          onPressed: () =>
                                              Modular.to.navigate('/')),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            state.movie.average
                                                .toStringAsFixed(1),
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
                                  ),
                                  const SizedBox(height: 30),
                                  Text(state.movie.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                          )),
                                  const SizedBox(height: 20),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                          text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                        children: [
                                          const TextSpan(
                                              text: 'Release date: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: releaseDate)
                                        ],
                                      ))),
                                  const SizedBox(height: 15),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                          text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                        children: [
                                          const TextSpan(
                                              text: 'Duration: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: minutesToHourString(
                                                  state.movie.runtimeInMinutes))
                                        ],
                                      ))),
                                  const SizedBox(height: 15),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                          text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                        children: [
                                          const TextSpan(
                                              text: 'Budget: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: NumberFormat.currency(
                                                      locale: "en_US",
                                                      symbol: "US\$ ")
                                                  .format(state.movie.budget))
                                        ],
                                      ))),
                                  const SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        for (String genre in genreNames)
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[800]!,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.grey[700]!)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3,
                                                  bottom: 3,
                                                  left: 8,
                                                  right: 8),
                                              child: Text(
                                                genre,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: Colors.white70,
                                                    ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Actors',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent:
                                          300, // here set custom Height You Want
                                    ),
                                    itemCount: state.movieCredits.cast.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return MovieCastCard(
                                          castEntity:
                                              state.movieCredits.cast[index]);
                                    },
                                  ),
                                ],
                              ))),
                    ])));
          }),
    );
  }
}
