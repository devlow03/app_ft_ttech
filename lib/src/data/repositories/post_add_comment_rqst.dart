// To parse this JSON data, do
//
//     final PostAddCommentRqst = PostAddCommentRqstFromJson(jsonString);

import 'dart:convert';

PostAddCommentRqst PostAddCommentRqstFromJson(String str) => PostAddCommentRqst.fromJson(json.decode(str));

String PostAddCommentRqstToJson(PostAddCommentRqst data) => json.encode(data.toJson());

class PostAddCommentRqst {
  int productId;
  String text;
  int rating;
  Map<String, String> imageUrl;
  dynamic parentId;
  bool test;

  PostAddCommentRqst({
    required this.productId,
    required this.text,
    required this.rating,
    required this.imageUrl,
    required this.parentId,
    required this.test,
  });

  factory PostAddCommentRqst.fromJson(Map<String, dynamic> json) => PostAddCommentRqst(
    productId: json["product_id"],
    text: json["text"],
    rating: json["rating"],
    imageUrl: Map.from(json["image_url"]).map((k, v) => MapEntry<String, String>(k, v)),
    parentId: json["parent_id"],
    test: json["test"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "text": text,
    "rating": rating,
    "image_url": Map.from(imageUrl).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "parent_id": parentId,
    "test": test,
  };
}
