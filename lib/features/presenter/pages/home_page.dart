import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/presenter/controllers/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ScopedBuilder(
            store: store,
            onLoading: (context) =>
                const Center(child: CircularProgressIndicator()),
            onError: (context, error) => Center(
              child: Text(
                'An error occurred, try again later.',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white),
              ),
            ),
            onState: (context, List<MovieEntity> movies) {
              List<Text> movieCards = movies.map((movie) => Text(movie.title)).toList();

              return ListView(
                children: movieCards,
              );
            },
          ),
        ),
      ),
    );
  }
}
