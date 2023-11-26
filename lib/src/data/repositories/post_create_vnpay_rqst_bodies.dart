// To parse this JSON data, do
//
//     final postCreateVnpayRqstBodies = postCreateVnpayRqstBodiesFromJson(jsonString);

import 'dart:convert';

PostCreateVnpayRqstBodies postCreateVnpayRqstBodiesFromJson(String str) => PostCreateVnpayRqstBodies.fromJson(json.decode(str));

String postCreateVnpayRqstBodiesToJson(PostCreateVnpayRqstBodies data) => json.encode(data.toJson());

class PostCreateVnpayRqstBodies {
    int? orderId;

    PostCreateVnpayRqstBodies({
        this.orderId,
    });

    PostCreateVnpayRqstBodies copyWith({
        int? orderId,
    }) => 
        PostCreateVnpayRqstBodies(
            orderId: orderId ?? this.orderId,
        );

    factory PostCreateVnpayRqstBodies.fromJson(Map<String, dynamic> json) => PostCreateVnpayRqstBodies(
        orderId: json["order_id"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
    };
}
