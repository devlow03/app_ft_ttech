// To parse this JSON data, do
//
//     final getCommentQueries = getCommentQueriesFromJson(jsonString);

import 'dart:convert';

GetCommentQueries getCommentQueriesFromJson(String str) => GetCommentQueries.fromJson(json.decode(str));

String getCommentQueriesToJson(GetCommentQueries data) => json.encode(data.toJson());

class GetCommentQueries {
    String productId;
    String perPage;

    GetCommentQueries({
        required this.productId,
        required this.perPage,
    });

    factory GetCommentQueries.fromJson(Map<String, dynamic> json) => GetCommentQueries(
        productId: json["product_id"],
        perPage: json["perPage"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "perPage": perPage,
    };
}
