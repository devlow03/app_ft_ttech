// To parse this JSON data, do
//
//     final getAddressBookRsp = getAddressBookRspFromJson(jsonString);

import 'dart:convert';

GetAddressBookRsp getAddressBookRspFromJson(String str) => GetAddressBookRsp.fromJson(json.decode(str));

String getAddressBookRspToJson(GetAddressBookRsp data) => json.encode(data.toJson());

class GetAddressBookRsp {
  List<Data>? data;
  Response? response;
  Links? links;
  Meta? meta;

  GetAddressBookRsp({
    this.data,
    this.response,
    this.links,
    this.meta,
  });

  GetAddressBookRsp copyWith({
    List<Data>? data,
    Response? response,
    Links? links,
    Meta? meta,
  }) =>
      GetAddressBookRsp(
        data: data ?? this.data,
        response: response ?? this.response,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory GetAddressBookRsp.fromJson(Map<String, dynamic> json) => GetAddressBookRsp(
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "response": response?.toJson(),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Data {
  int? id;
  int? userId;
  String? fullName;
  String? phone;
  int? wardId;
  String? wardName;
  int? districtId;
  String? districtName;
  int? cityId;
  String? cityName;
  String? fullAddress;

  Data({
    this.id,
    this.userId,
    this.fullName,
    this.phone,
    this.wardId,
    this.wardName,
    this.districtId,
    this.districtName,
    this.cityId,
    this.cityName,
    this.fullAddress,
  });

  Data copyWith({
    int? id,
    int? userId,
    String? fullName,
    String? phone,
    int? wardId,
    String? wardName,
    int? districtId,
    String? districtName,
    int? cityId,
    String? cityName,
    String? fullAddress,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        wardId: wardId ?? this.wardId,
        wardName: wardName ?? this.wardName,
        districtId: districtId ?? this.districtId,
        districtName: districtName ?? this.districtName,
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
        fullAddress: fullAddress ?? this.fullAddress,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    fullName: json["full_name"],
    phone: json["phone"],
    wardId: json["ward_id"],
    wardName: json["ward_name"],
    districtId: json["district_id"],
    districtName: json["district_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "full_name": fullName,
    "phone": phone,
    "ward_id": wardId,
    "ward_name": wardName,
    "district_id": districtId,
    "district_name": districtName,
    "city_id": cityId,
    "city_name": cityName,
    "full_address": fullAddress,
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  Links copyWith({
    String? first,
    String? last,
    dynamic prev,
    dynamic next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Link>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      Meta(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class Response {
  String? status;
  int? code;
  int? count;

  Response({
    this.status,
    this.code,
    this.count,
  });

  Response copyWith({
    String? status,
    int? code,
    int? count,
  }) =>
      Response(
        status: status ?? this.status,
        code: code ?? this.code,
        count: count ?? this.count,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    status: json["status"],
    code: json["code"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "count": count,
  };
}
