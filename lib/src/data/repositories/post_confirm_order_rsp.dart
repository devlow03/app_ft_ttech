// To parse this JSON data, do
//
//     final postConfirmOrderRsp = postConfirmOrderRspFromJson(jsonString);

import 'dart:convert';

PostConfirmOrderRsp postConfirmOrderRspFromJson(String str) => PostConfirmOrderRsp.fromJson(json.decode(str));

String postConfirmOrderRspToJson(PostConfirmOrderRsp data) => json.encode(data.toJson());

class PostConfirmOrderRsp {
    Data? data;
    String? message;

    PostConfirmOrderRsp({
        this.data,
        this.message,
    });

    PostConfirmOrderRsp copyWith({
        Data? data,
        String? message,
    }) => 
        PostConfirmOrderRsp(
            data: data ?? this.data,
            message: message ?? this.message,
        );

    factory PostConfirmOrderRsp.fromJson(Map<String, dynamic> json) => PostConfirmOrderRsp(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
    };
}

class Data {
    int? orderId;

    Data({
        this.orderId,
    });

    Data copyWith({
        int? orderId,
    }) => 
        Data(
            orderId: orderId ?? this.orderId,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
    };
}
