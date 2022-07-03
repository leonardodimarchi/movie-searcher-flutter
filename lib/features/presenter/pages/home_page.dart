// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/presenter/controllers/home_store.dart';
import 'package:movie_searcher_flutter/features/presenter/widgets/movie_banner.dart';

import '../widgets/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final ScrollController scrollController = ScrollController();
  final Color backgroundColor = Colors.grey[850]!;

  bool isLoadingMoreData = false;

  @override
  void initState() {
    super.initState();
    store.getMovies();

    scrollController.addListener(() async {
      ScrollPosition position = scrollController.position;

      if (position.pixels >= position.maxScrollExtent &&
          !store.isLoading &&
          !isLoadingMoreData) {
        setState(() {
          isLoadingMoreData = true;
        });

        await store.getMovies();

        setState(() {
          isLoadingMoreData = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ScopedBuilder(
          store: store,
          onLoading: (context) =>  const Center(child: CircularProgressIndicator()),
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
          onState: (context, MoviePagination moviePagination) {
            return  SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  MovieBanner(
                    backgroundColor,
                    imageUrl: moviePagination.list[0].image,
                  ),
                  Stack(
                    children: [
                      ListView.builder(
                    itemCount: moviePagination.list.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => MovieCard(moviePagination.list[index])                  ,
                  ),

                  if (isLoadingMoreData)
                    Positioned(
                      bottom: 0,
                      height: 80,
                      child: SizedBox(
                        width: size.width,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                    ],                
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
