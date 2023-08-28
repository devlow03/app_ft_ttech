import 'package:cached_network_image/cached_network_image.dart';
import'package:flutter/material.dart';
class GlobalImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  const GlobalImage({super.key, this.imageUrl, this.width, this.height, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:imageUrl?.length!=null,
      replacement: Container(
        width: width,
        height:height,
        color: Colors.grey.shade200,
        child: Icon(
          Icons.image,
          // size: 150,

        ),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl??"",
        height: height??0,
        width: width??0,
        fit:boxFit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: Icon(
            Icons.image,
            color: Colors.grey,
            // size: 100,

          ),
        ),
        errorWidget: (context, url, error) =>Container(
          width: width,
          height:height,
          color: Colors.grey.shade200,
          child: Icon(
            Icons.image,
            color: Colors.grey,
            // size: 100,

          ),
        ),
      ),
    );
  }
}
