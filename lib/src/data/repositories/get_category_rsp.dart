// To parse this JSON data, do
//
//     final getCategoryRsp = getCategoryRspFromJson(jsonString);

import 'dart:convert';

GetCategoryRsp getCategoryRspFromJson(String str) => GetCategoryRsp.fromJson(json.decode(str));

String getCategoryRspToJson(GetCategoryRsp data) => json.encode(data.toJson());

class GetCategoryRsp {
  List<Data>? data;
  Response? response;
  Links? links;
  Meta? meta;

  GetCategoryRsp({
    this.data,
    this.response,
    this.links,
    this.meta,
  });

  GetCategoryRsp copyWith({
    List<Data>? data,
    Response? response,
    Links? links,
    Meta? meta,
  }) =>
      GetCategoryRsp(
        data: data ?? this.data,
        response: response ?? this.response,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory GetCategoryRsp.fromJson(Map<String, dynamic> json) => GetCategoryRsp(
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
  String? code;
  String? name;
  String? slug;
  dynamic parentId;
  int? countChild;
  List<dynamic>? child;
  dynamic createdAt;
  dynamic updatedAt;

  Data({
    this.id,
    this.code,
    this.name,
    this.slug,
    this.parentId,
    this.countChild,
    this.child,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    int? id,
    String? code,
    String? name,
    String? slug,
    dynamic parentId,
    int? countChild,
    List<dynamic>? child,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        parentId: parentId ?? this.parentId,
        countChild: countChild ?? this.countChild,
        child: child ?? this.child,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    slug: json["slug"],
    parentId: json["parent_id"],
    countChild: json["count_child"],
    child: json["child"] == null ? [] : List<dynamic>.from(json["child"]!.map((x) => x)),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "slug": slug,
    "parent_id": parentId,
    "count_child": countChild,
    "child": child == null ? [] : List<dynamic>.from(child!.map((x) => x)),
    "created_at": createdAt,
    "updated_at": updatedAt,
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
