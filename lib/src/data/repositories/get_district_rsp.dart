// To parse this JSON data, do
//
//     final getDistrictRsp = getDistrictRspFromJson(jsonString);

import 'dart:convert';

GetDistrictRsp getDistrictRspFromJson(String str) => GetDistrictRsp.fromJson(json.decode(str));

String getDistrictRspToJson(GetDistrictRsp data) => json.encode(data.toJson());

class GetDistrictRsp {
  String status;
  String message;
  List<Result> results;

  GetDistrictRsp({
    required this.status,
    required this.message,
    required this.results,
  });

  factory GetDistrictRsp.fromJson(Map<String, dynamic> json) => GetDistrictRsp(
    status: json["status"],
    message: json["message"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String code;
  String name;
  String province;

  Result({
    required this.code,
    required this.name,
    required this.province,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    code: json["code"],
    name: json["name"],
    province: json["province"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "province": province,
  };
}
