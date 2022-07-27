import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_searcher_flutter/features/domain/entities/cast_entity.dart';

class MovieCastCard extends StatelessWidget {
  final CastEntity castEntity;
  final double? height;

  const MovieCastCard({required this.castEntity, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black
      ),
      height: height ?? size.height,      
      child: Stack(
        alignment: Alignment.center,        
        children: [        
          Center(
            child: Image(
              image: NetworkImage(castEntity.profilePath),
              fit: BoxFit.fitHeight,
              height: height ?? size.height,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, url, error) => const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Icon(Icons.error, color: Colors.red, size: 45)
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: 100,
                  width: size.width,
                  color: Colors.black.withOpacity(0.9),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Flexible(
                            child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    castEntity.name,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    castEntity.character,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  ),
                                )),
                          ),
                        ],
                      ))))
        ],
      ),
    );
  }
}
