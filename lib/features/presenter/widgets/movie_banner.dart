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
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,                  
                    alignment: Alignment.topCenter,
                  )),
            ),
          if (imageUrl == null)
            const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          Positioned(
              top: 255,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: const [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.9],
                      colors: [
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
