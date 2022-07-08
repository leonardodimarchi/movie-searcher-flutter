import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieBanner extends StatelessWidget {
  final String? imageUrl;
  final Color backgroundColor;

  const MovieBanner(this.backgroundColor, {this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (imageUrl != null)
            Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.fitHeight,
                height: 300,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          Positioned(
              top: 255,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops: const [
                  0.1,
                  0.2,
                  0.3,
                  0.4,
                  0.5,
                  0.6,
                  0.9
                ], colors: [
                  backgroundColor.withOpacity(0.1),
                  backgroundColor.withOpacity(0.2),
                  backgroundColor.withOpacity(0.3),
                  backgroundColor.withOpacity(0.4),
                  backgroundColor.withOpacity(0.5),
                  backgroundColor.withOpacity(0.7),
                  backgroundColor,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ))
        ],
      ),
    );
  }
}
