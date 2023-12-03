// To parse this JSON data, do
//
//     final getOrderRqst = getOrderRqstFromJson(jsonString);

import 'dart:convert';

GetOrderRqst getOrderRqstFromJson(String str) => GetOrderRqst.fromJson(json.decode(str));

String getOrderRqstToJson(GetOrderRqst data) => json.encode(data.toJson());

class GetOrderRqst {
    String? perPage;
    String? statusCode;

    GetOrderRqst({
        this.perPage,
        this.statusCode,
    });

    GetOrderRqst copyWith({
        String? perPage,
        String? statusCode,
    }) => 
        GetOrderRqst(
            perPage: perPage ?? this.perPage,
            statusCode: statusCode ?? this.statusCode,
        );

    factory GetOrderRqst.fromJson(Map<String, dynamic> json) => GetOrderRqst(
        perPage: json["perPage"],
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "perPage": perPage,
        "status_code": statusCode,
    };
}
