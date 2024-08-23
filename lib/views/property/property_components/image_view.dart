import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

// ignore: must_be_immutable
class ImageView extends StatelessWidget {
  ImageView({
    super.key,
    required this.imageURL,
  });
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log("Navigating to detail screen with imageURL: $imageURL");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imageURL,
              cacheKey: UniqueKey().toString(),
              height: size.height * 0.4,
              width: size.width,
              placeholder: (context, url) => const Center(
                child: const CircularProgressIndicator(
                  color: themeredcolor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          ],
        ),
      ),
    );
  }
}
