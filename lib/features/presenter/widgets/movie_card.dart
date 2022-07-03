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
                    height: 120,
                    width: size.width,
                    color: Colors.black.withOpacity(0.9),
                    child: Column(   
                      children: [
                          Text(                                                    
                          movie.title,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Colors.white70,
                                overflow: TextOverflow.ellipsis,                                
                              ),
                        )
                      ],
                    )))
          ],
        ));
  }
}
