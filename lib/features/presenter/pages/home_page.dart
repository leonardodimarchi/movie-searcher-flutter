// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/presenter/controllers/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final ScrollController scrollController = ScrollController();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: ScopedBuilder(
          store: store,
          onLoading: (context) =>
              const Center(child: CircularProgressIndicator()),
          onError: (context, error) => Center(
            child: Text(
              'An error occurred, try again later.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          onState: (context, MoviePagination moviePagination) {
            return LayoutBuilder(builder: (context, boxConstraints) {
              return Stack(
                children: [
                  ListView.separated(
                    controller: scrollController,
                    itemCount: moviePagination.movies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(moviePagination.movies[index].title),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },
                  ),
                  if(isLoadingMoreData)
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                      height: 80,
                      width: boxConstraints.maxWidth,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        )
                      )
                    ),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}
