// To parse this JSON data, do
//
//     final postRepurchaseRqst = postRepurchaseRqstFromJson(jsonString);

import 'dart:convert';

PostRepurchaseRqst postRepurchaseRqstFromJson(String str) => PostRepurchaseRqst.fromJson(json.decode(str));

String postRepurchaseRqstToJson(PostRepurchaseRqst data) => json.encode(data.toJson());

class PostRepurchaseRqst {
    List<String>? productId;
    List<String>? quantity;

    PostRepurchaseRqst({
        this.productId,
        this.quantity,
    });

    PostRepurchaseRqst copyWith({
        List<String>? productId,
        List<String>? quantity,
    }) => 
        PostRepurchaseRqst(
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
        );

    factory PostRepurchaseRqst.fromJson(Map<String, dynamic> json) => PostRepurchaseRqst(
        productId: json["product_id"] == null ? [] : List<String>.from(json["product_id"]!.map((x) => x)),
        quantity: json["quantity"] == null ? [] : List<String>.from(json["quantity"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId == null ? [] : List<dynamic>.from(productId!.map((x) => x)),
        "quantity": quantity == null ? [] : List<dynamic>.from(quantity!.map((x) => x)),
    };
}
