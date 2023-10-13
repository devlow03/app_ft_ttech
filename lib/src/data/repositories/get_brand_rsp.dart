// To parse this JSON data, do
//
//     final getBrandRsp = getBrandRspFromJson(jsonString);

import 'dart:convert';

GetBrandRsp getBrandRspFromJson(String str) => GetBrandRsp.fromJson(json.decode(str));

String getBrandRspToJson(GetBrandRsp data) => json.encode(data.toJson());

class GetBrandRsp {
  List<Datum>? data;
  Response? response;
  Links? links;
  Meta? meta;

  GetBrandRsp({
    this.data,
    this.response,
    this.links,
    this.meta,
  });

  GetBrandRsp copyWith({
    List<Datum>? data,
    Response? response,
    Links? links,
    Meta? meta,
  }) =>
      GetBrandRsp(
        data: data ?? this.data,
        response: response ?? this.response,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory GetBrandRsp.fromJson(Map<String, dynamic> json) => GetBrandRsp(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  String? name;
  dynamic address;
  dynamic phone;
  dynamic email;
  dynamic website;
  String? field;
  dynamic yearEstablished;
  dynamic productInfomation;

  Datum({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.field,
    this.yearEstablished,
    this.productInfomation,
  });

  Datum copyWith({
    int? id,
    String? name,
    dynamic address,
    dynamic phone,
    dynamic email,
    dynamic website,
    String? field,
    dynamic yearEstablished,
    dynamic productInfomation,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        website: website ?? this.website,
        field: field ?? this.field,
        yearEstablished: yearEstablished ?? this.yearEstablished,
        productInfomation: productInfomation ?? this.productInfomation,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    website: json["website"],
    field: json["field"],
    yearEstablished: json["year_established"],
    productInfomation: json["product_infomation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone": phone,
    "email": email,
    "website": website,
    "field": field,
    "year_established": yearEstablished,
    "product_infomation": productInfomation,
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

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
    String? next,
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
