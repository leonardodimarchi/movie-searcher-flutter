import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final List<GenreEntity> genres;

  const MovieCard({
    Key? key,
    required this.movie,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<String> genreNames = [];

    genreNames = genres
        .where((genre) => movie.genreIds.contains(genre.id))
        .map((genre) => genre.name)
        .toList();

    return GestureDetector(
        onTap: () => Modular.to.pushNamed('/movie/' + movie.id.toString()),
        child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ]),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 145),
                  child: Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Image(
                  image: NetworkImage(movie.image),
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: size.width,
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: 145,
                        width: size.width,
                        color: Colors.black.withOpacity(0.9),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          movie.title,
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
                                          movie.average.toStringAsFixed(1),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: movie.average >= 5
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                )
                              ],
                            ))))
              ],
            )));
  }
}
