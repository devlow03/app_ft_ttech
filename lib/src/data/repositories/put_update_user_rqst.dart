// To parse this JSON data, do
//
//     final putUpdateUserRqst = putUpdateUserRqstFromJson(jsonString);

import 'dart:convert';

PutUpdateUserRqst putUpdateUserRqstFromJson(String str) => PutUpdateUserRqst.fromJson(json.decode(str));

String putUpdateUserRqstToJson(PutUpdateUserRqst data) => json.encode(data.toJson());

class PutUpdateUserRqst {
    String? phone;
    String? username;
    String? fullName;
    String? birthday;
    String? email;

    PutUpdateUserRqst({
        this.phone,
        this.username,
        this.fullName,
        this.birthday,
        this.email,
    });

    PutUpdateUserRqst copyWith({
        String? phone,
        String? username,
        String? fullName,
        String? birthday,
        String? email,
    }) => 
        PutUpdateUserRqst(
            phone: phone ?? this.phone,
            username: username ?? this.username,
            fullName: fullName ?? this.fullName,
            birthday: birthday ?? this.birthday,
            email: email ?? this.email,
        );

    factory PutUpdateUserRqst.fromJson(Map<String, dynamic> json) => PutUpdateUserRqst(
        phone: json["phone"],
        username: json["username"],
        fullName: json["full_name"],
        birthday: json["birthday"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "username": username,
        "full_name": fullName,
        "birthday": birthday,
        "email": email,
    };
}
