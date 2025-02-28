import 'package:cached_network_image/cached_network_image.dart';
import'package:flutter/material.dart';
class GlobalImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Color? color;
  final BlendMode? colorBlendMode;
  const GlobalImage({super.key, this.imageUrl, this.width, this.height, this.boxFit, this.color, this.colorBlendMode});

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
        color: color, // Màu tối lại
  colorBlendMode: colorBlendMode, 
        // placeholder: (context, url) => Container(
        //   width: width,
        //   height: height,
        //   color: Colors.white,
        //   child:Image.asset("assets/images/placeholder.png",
        //   width: width,
        //     height: height,
        //     // fit: BoxFit.contain,
        //   )
        // ),
        placeholder: (context, url) {
          return Container(
            width: width,
            height: height,
            color: Colors.white,
          );
        },
        errorWidget: (context, url, error) {
        //   return Container(
        //   width: width,
        //   height:height,
        //   color: Colors.white,
        //   child:Image.asset("assets/images/placeholder.png",
        //     width: width,
        //     height: height,
        //     // fit: BoxFit.contain,
        //   )
        // );
          return Container(
            width: width,
            height: height,
            color: Colors.white,
          );
        }
      ),
    );
  }
}
