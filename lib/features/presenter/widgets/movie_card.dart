import 'package:flutter/material.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Image(
                image: NetworkImage(movie.image),
                height: double.infinity,
              )
            ],
          ),
        ));
  }
}
