// To parse this JSON data, do
//
//     final postSetDefaultAddressRqst = postSetDefaultAddressRqstFromJson(jsonString);

import 'dart:convert';

PostSetDefaultAddressRqst postSetDefaultAddressRqstFromJson(String str) => PostSetDefaultAddressRqst.fromJson(json.decode(str));

String postSetDefaultAddressRqstToJson(PostSetDefaultAddressRqst data) => json.encode(data.toJson());

class PostSetDefaultAddressRqst {
    int? id;

    PostSetDefaultAddressRqst({
        this.id,
    });

    PostSetDefaultAddressRqst copyWith({
        int? id,
    }) => 
        PostSetDefaultAddressRqst(
            id: id ?? this.id,
        );

    factory PostSetDefaultAddressRqst.fromJson(Map<String, dynamic> json) => PostSetDefaultAddressRqst(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
