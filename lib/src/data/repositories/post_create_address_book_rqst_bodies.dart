// To parse this JSON data, do
//
//     final postCreateAddressBookRqstBodies = postCreateAddressBookRqstBodiesFromJson(jsonString);

import 'dart:convert';

PostCreateAddressBookRqstBodies postCreateAddressBookRqstBodiesFromJson(String str) => PostCreateAddressBookRqstBodies.fromJson(json.decode(str));

String postCreateAddressBookRqstBodiesToJson(PostCreateAddressBookRqstBodies data) => json.encode(data.toJson());

class PostCreateAddressBookRqstBodies {
    dynamic userId;
    String? fullName;
    String? phone;
    String? wardId;
    String? wardName;
    int? districtId;
    String? districtName;
    int? cityId;
    String? cityName;
    String? street;

    PostCreateAddressBookRqstBodies({
        this.userId,
        this.fullName,
        this.phone,
        this.wardId,
        this.wardName,
        this.districtId,
        this.districtName,
        this.cityId,
        this.cityName,
        this.street,
    });

    PostCreateAddressBookRqstBodies copyWith({
        dynamic userId,
        String? fullName,
        String? phone,
        String? wardId,
        String? wardName,
        int? districtId,
        String? districtName,
        int? cityId,
        String? cityName,
        String? street,
    }) => 
        PostCreateAddressBookRqstBodies(
            userId: userId ?? this.userId,
            fullName: fullName ?? this.fullName,
            phone: phone ?? this.phone,
            wardId: wardId ?? this.wardId,
            wardName: wardName ?? this.wardName,
            districtId: districtId ?? this.districtId,
            districtName: districtName ?? this.districtName,
            cityId: cityId ?? this.cityId,
            cityName: cityName ?? this.cityName,
            street: street ?? this.street,
        );

    factory PostCreateAddressBookRqstBodies.fromJson(Map<String, dynamic> json) => PostCreateAddressBookRqstBodies(
        userId: json["user_id"],
        fullName: json["full_name"],
        phone: json["phone"],
        wardId: json["ward_id"],
        wardName: json["ward_name"],
        districtId: json["district_id"],
        districtName: json["district_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        street: json["street"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "phone": phone,
        "ward_id": wardId,
        "ward_name": wardName,
        "district_id": districtId,
        "district_name": districtName,
        "city_id": cityId,
        "city_name": cityName,
        "street": street,
    };
}
