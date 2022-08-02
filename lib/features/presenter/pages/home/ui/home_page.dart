// ignore_for_file: unused_import

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_searcher_flutter/core/utils/extensions/string_casing_extension.dart';
import 'package:movie_searcher_flutter/features/data/models/movie_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/movie_repository.dart';
import 'package:movie_searcher_flutter/features/presenter/pages/home/viewmodel/home_viewmodel.dart';
import 'package:movie_searcher_flutter/features/presenter/widgets/movie_banner.dart';

import '../../../widgets/movie_card.dart';
import '../controller/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final ScrollController scrollController = ScrollController();
  final searchInputController = TextEditingController();

  late StreamSubscription<bool> keyboardSubscription;

  final Color backgroundColor = Colors.grey[850]!;

  bool isLoadingMoreData = false;
  bool isKeyboardOpen = false;
  bool showBackToTopButton = false;

  String searchText = '';
  Timer? searchDebounce;

  @override
  void initState() {
    super.initState();

    store.getMovies();
    store.getGenres();

    scrollController.addListener(() async {
      ScrollPosition position = scrollController.position;

      if (position.pixels >= position.maxScrollExtent &&
          !store.isLoading &&
          !isLoadingMoreData) {
        setState(() {
          isLoadingMoreData = true;
        });

        if (searchText.isNotEmpty) {
          await store.searchMovies(searchText: searchText, page: 1);
        } else {
          await store.getMovies();
        }

        setState(() {
          isLoadingMoreData = false;
        });
      }

      setState(() {
        if (scrollController.offset >= 400) {
          showBackToTopButton = true;
        } else {
          showBackToTopButton = false;
        }
      });
    });

    final keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isKeyboardOpen = visible;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    keyboardSubscription.cancel();
    searchDebounce?.cancel();
    super.dispose();
  }

  void onPullToRefresh() async {
    if (searchText.isEmpty) {
      await store.refreshMovieList();
    } else {
      await store.refreshSearchMovieList(searchText);
    }
  }

  void onSearchChange(String value) {
    if (searchDebounce?.isActive ?? false) {
      searchDebounce!.cancel();
    }

    searchDebounce = Timer(const Duration(milliseconds: 500), () {
      value = value.trim();
      setState(() async {
        if (value.isEmpty) {
          await store.getMovies(page: 1);
        } else {
          await store.searchMovies(searchText: value, page: 1);
        }

        searchText = value;
      });
    });
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: showBackToTopButton == false
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.grey[800],
              onPressed: scrollToTop,
              child: Icon(Icons.arrow_upward, color: Colors.grey[600]),
            ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ScopedBuilder(
          store: store,
          onLoading: (context) =>
              const Center(child: CircularProgressIndicator()),
          onError: (context, error) => Center(
            child: Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white70),
            ),
          ),
          onState: (context, HomeViewModel state) {
            MoviePagination moviePagination = state.moviePagination;
            List<GenreEntity> genres = state.genres;

            return ScrollConfiguration(
                behavior: const ScrollBehavior(
                    androidOverscrollIndicator:
                        AndroidOverscrollIndicator.stretch),
                child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: backgroundColor,
                    child: RefreshIndicator(
                      backgroundColor: backgroundColor,
                      color: Colors.white,
                      strokeWidth: 2,
                      onRefresh: () async => onPullToRefresh(),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            if (moviePagination.list.isNotEmpty &&
                                !isKeyboardOpen)
                              MovieBanner(
                                backgroundColor,
                                imageUrl: moviePagination.list[0].backdropImage,
                              ),
                            if (isKeyboardOpen || moviePagination.list.isEmpty)
                              const SizedBox(height: 30),
                            Center(
                                child: Container(
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: TextField(
                                controller: searchInputController,
                                autofocus: false,
                                style: const TextStyle(color: Colors.white),
                                onChanged: onSearchChange,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Search for a movie',
                                  hintStyle: TextStyle(color: Colors.grey[50]),
                                  fillColor: Colors.grey[900],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      searchInputController.clear();
                                      setState(() {
                                        searchText = '';
                                      });
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                                autocorrect: false,
                              ),
                            )),
                            if (searchText.isEmpty) const SizedBox(height: 15),
                            if (searchText.isEmpty)
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: [
                                      for (GetMovieType type
                                          in GetMovieType.values)
                                        GestureDetector(
                                          onTap: () =>
                                              store.changeMovieType(type),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[800]!,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                border: Border.all(
                                                    width: 2,
                                                    color: type ==
                                                            state.selectedType
                                                        ? Colors.white
                                                        : Colors.grey[700]!)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3,
                                                  bottom: 3,
                                                  left: 8,
                                                  right: 8),
                                              child: Text(
                                                type
                                                    .toShortString()
                                                    .toCapitalized(),
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: Colors.white70,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            if (searchText.isNotEmpty &&
                                moviePagination.list.isEmpty)
                              Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Center(
                                      child: Text(
                                    'Nothing found =/',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.white70),
                                  ))),
                            Stack(
                              children: [
                                ListView.builder(
                                  itemCount: moviePagination.list.length,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                        width: 250,
                                        margin: const EdgeInsets.only(
                                          bottom: 20,
                                          top: 20,
                                        ),
                                        constraints: BoxConstraints.expand(
                                          height: 400,
                                          width: size.width * 0.7,
                                        ),
                                        child: Center(
                                          child: MovieCard(
                                              movie:
                                                  moviePagination.list[index],
                                              genres: genres),
                                        )),
                                  ),
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
                      ),
                    )));
          },
        ),
      ),
    );
  }
}
