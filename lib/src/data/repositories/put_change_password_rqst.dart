// To parse this JSON data, do
//
//     final putChangePasswordRqst = putChangePasswordRqstFromJson(jsonString);

import 'dart:convert';

PutChangePasswordRqst putChangePasswordRqstFromJson(String str) => PutChangePasswordRqst.fromJson(json.decode(str));

String putChangePasswordRqstToJson(PutChangePasswordRqst data) => json.encode(data.toJson());

class PutChangePasswordRqst {
    String? password;
    String? newPassword;
    String? passwordNewConfirmation;

    PutChangePasswordRqst({
        this.password,
        this.newPassword,
        this.passwordNewConfirmation,
    });

    PutChangePasswordRqst copyWith({
        String? password,
        String? newPassword,
        String? passwordNewConfirmation,
    }) => 
        PutChangePasswordRqst(
            password: password ?? this.password,
            newPassword: newPassword ?? this.newPassword,
            passwordNewConfirmation: passwordNewConfirmation ?? this.passwordNewConfirmation,
        );

    factory PutChangePasswordRqst.fromJson(Map<String, dynamic> json) => PutChangePasswordRqst(
        password: json["password"],
        newPassword: json["new_password"],
        passwordNewConfirmation: json["password_new_confirmation"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "new_password": newPassword,
        "password_new_confirmation": passwordNewConfirmation,
    };
}
