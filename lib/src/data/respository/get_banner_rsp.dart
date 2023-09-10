// To parse this JSON data, do
//
//     final getBannerRsp = getBannerRspFromJson(jsonString);

import 'dart:convert';

GetBannerRsp getBannerRspFromJson(String str) => GetBannerRsp.fromJson(json.decode(str));

String getBannerRspToJson(GetBannerRsp data) => json.encode(data.toJson());

class GetBannerRsp {
  List<Datum>? data;
  Response? response;
  Links? links;
  Meta? meta;

  GetBannerRsp({
    this.data,
    this.response,
    this.links,
    this.meta,
  });

  GetBannerRsp copyWith({
    List<Datum>? data,
    Response? response,
    Links? links,
    Meta? meta,
  }) =>
      GetBannerRsp(
        data: data ?? this.data,
        response: response ?? this.response,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory GetBannerRsp.fromJson(Map<String, dynamic> json) => GetBannerRsp(
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
  String? code;
  String? name;
  String? slug;
  int? isActive;
  List<Detail>? details;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.code,
    this.name,
    this.slug,
    this.isActive,
    this.details,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    int? id,
    String? code,
    String? name,
    String? slug,
    int? isActive,
    List<Detail>? details,
    String? createdAt,
    String? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        isActive: isActive ?? this.isActive,
        details: details ?? this.details,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    slug: json["slug"],
    isActive: json["is_active"],
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "slug": slug,
    "is_active": isActive,
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Detail {
  int? id;
  int? bannerId;
  String? image;
  String? link;
  String? createdAt;
  String? updatedAt;

  Detail({
    this.id,
    this.bannerId,
    this.image,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  Detail copyWith({
    int? id,
    int? bannerId,
    String? image,
    String? link,
    String? createdAt,
    String? updatedAt,
  }) =>
      Detail(
        id: id ?? this.id,
        bannerId: bannerId ?? this.bannerId,
        image: image ?? this.image,
        link: link ?? this.link,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    bannerId: json["banner_id"],
    image: json["image"],
    link: json["link"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banner_id": bannerId,
    "image": image,
    "link": link,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
