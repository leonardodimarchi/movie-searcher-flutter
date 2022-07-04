import 'package:flutter/material.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
        ]),
        child: Stack(
          alignment: Alignment.center,
          children: [
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
                    height: 70,
                    width: size.width,
                    color: Colors.black.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
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
                                    width: 2, color: Colors.grey[700]!)),
                            child: Center(
                              child: Text(
                                movie.average.toString(),
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
                    )))
          ],
        ));
  }
}
