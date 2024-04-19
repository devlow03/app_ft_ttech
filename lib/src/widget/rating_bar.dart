import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarView extends StatelessWidget {
  const RatingBarView({super.key,  this.onRatingUpdate, this.initialRating, this.minRating, this.disableRatingChange, this.itemCount, this.itemSize, this.allowHalfRating});
  final void Function(double)? onRatingUpdate;
  final double? initialRating;
  final double? minRating;
  final bool? disableRatingChange;
  final int? itemCount;
  final double? itemSize;
  final bool? allowHalfRating;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: itemSize??18,
      initialRating: initialRating??0,
      minRating: minRating??0,
      direction: Axis.horizontal,
      allowHalfRating: allowHalfRating??true,

      itemCount: itemCount??5,
      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
        size: 12,
      ),
      onRatingUpdate: onRatingUpdate??(value){},
        ignoreGestures: disableRatingChange??true
    );
  }
}
