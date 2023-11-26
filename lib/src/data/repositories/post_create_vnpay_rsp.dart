// To parse this JSON data, do
//
//     final postCreateVnpayRsp = postCreateVnpayRspFromJson(jsonString);

import 'dart:convert';

PostCreateVnpayRsp postCreateVnpayRspFromJson(String str) => PostCreateVnpayRsp.fromJson(json.decode(str));

String postCreateVnpayRspToJson(PostCreateVnpayRsp data) => json.encode(data.toJson());

class PostCreateVnpayRsp {
    String? code;
    String? message;
    String? data;

    PostCreateVnpayRsp({
        this.code,
        this.message,
        this.data,
    });

    PostCreateVnpayRsp copyWith({
        String? code,
        String? message,
        String? data,
    }) => 
        PostCreateVnpayRsp(
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostCreateVnpayRsp.fromJson(Map<String, dynamic> json) => PostCreateVnpayRsp(
        code: json["code"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
    };
}
