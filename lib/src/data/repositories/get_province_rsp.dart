// To parse this JSON data, do
//
//     final getProvinceRsp = getProvinceRspFromJson(jsonString);

import 'dart:convert';

GetProvinceRsp getProvinceRspFromJson(String str) => GetProvinceRsp.fromJson(json.decode(str));

String getProvinceRspToJson(GetProvinceRsp data) => json.encode(data.toJson());

class GetProvinceRsp {
  String status;
  String message;
  List<Result> results;

  GetProvinceRsp({
    required this.status,
    required this.message,
    required this.results,
  });

  factory GetProvinceRsp.fromJson(Map<String, dynamic> json) => GetProvinceRsp(
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

  Result({
    required this.code,
    required this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}
