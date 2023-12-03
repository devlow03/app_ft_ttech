// To parse this JSON data, do
//
//     final postAddFavoriteRqst = postAddFavoriteRqstFromJson(jsonString);

import 'dart:convert';

PostAddFavoriteRqst postAddFavoriteRqstFromJson(String str) => PostAddFavoriteRqst.fromJson(json.decode(str));

String postAddFavoriteRqstToJson(PostAddFavoriteRqst data) => json.encode(data.toJson());

class PostAddFavoriteRqst {
    int? productId;

    PostAddFavoriteRqst({
        this.productId,
    });

    PostAddFavoriteRqst copyWith({
        int? productId,
    }) => 
        PostAddFavoriteRqst(
            productId: productId ?? this.productId,
        );

    factory PostAddFavoriteRqst.fromJson(Map<String, dynamic> json) => PostAddFavoriteRqst(
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
    };
}
