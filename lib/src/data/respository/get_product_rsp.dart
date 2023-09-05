// To parse this JSON data, do
//
//     final getProductRsp = getProductRspFromJson(jsonString);

import 'dart:convert';

GetProductRsp getProductRspFromJson(String str) => GetProductRsp.fromJson(json.decode(str));

String getProductRspToJson(GetProductRsp data) => json.encode(data.toJson());

class GetProductRsp {
  List<Data>? data;
  Response? response;
  Links? links;
  Meta? meta;

  GetProductRsp({
    this.data,
    this.response,
    this.links,
    this.meta,
  });

  GetProductRsp copyWith({
    List<Data>? data,
    Response? response,
    Links? links,
    Meta? meta,
  }) =>
      GetProductRsp(
        data: data ?? this.data,
        response: response ?? this.response,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory GetProductRsp.fromJson(Map<String, dynamic> json) => GetProductRsp(
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
  dynamic code;
  String? productName;
  int? price;
  String? slug;
  dynamic sku;
  String? desctiption;
  String? detail;
  int? categoryId;
  String? categoryName;
  dynamic stockQuantity;
  int? manufacturerId;
  String? manufacturerName;
  dynamic unitIt;
  dynamic packagingId;
  String? thumpnailUrl;
  List<GalleryImagesUrl>? galleryImagesUrl;
  dynamic views;
  dynamic tags;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic metaKeywork;
  dynamic metaRobot;
  dynamic type;
  dynamic isFeatured;
  dynamic relatedIds;

  Data({
    this.id,
    this.code,
    this.productName,
    this.price,
    this.slug,
    this.sku,
    this.desctiption,
    this.detail,
    this.categoryId,
    this.categoryName,
    this.stockQuantity,
    this.manufacturerId,
    this.manufacturerName,
    this.unitIt,
    this.packagingId,
    this.thumpnailUrl,
    this.galleryImagesUrl,
    this.views,
    this.tags,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywork,
    this.metaRobot,
    this.type,
    this.isFeatured,
    this.relatedIds,
  });

  Data copyWith({
    int? id,
    dynamic code,
    String? productName,
    int? price,
    String? slug,
    dynamic sku,
    String? desctiption,
    String? detail,
    int? categoryId,
    String? categoryName,
    dynamic stockQuantity,
    int? manufacturerId,
    String? manufacturerName,
    dynamic unitIt,
    dynamic packagingId,
    String? thumpnailUrl,
    List<GalleryImagesUrl>? galleryImagesUrl,
    dynamic views,
    dynamic tags,
    dynamic metaTitle,
    dynamic metaDescription,
    dynamic metaKeywork,
    dynamic metaRobot,
    dynamic type,
    dynamic isFeatured,
    dynamic relatedIds,
  }) =>
      Data(
        id: id ?? this.id,
        code: code ?? this.code,
        productName: productName ?? this.productName,
        price: price ?? this.price,
        slug: slug ?? this.slug,
        sku: sku ?? this.sku,
        desctiption: desctiption ?? this.desctiption,
        detail: detail ?? this.detail,
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        manufacturerId: manufacturerId ?? this.manufacturerId,
        manufacturerName: manufacturerName ?? this.manufacturerName,
        unitIt: unitIt ?? this.unitIt,
        packagingId: packagingId ?? this.packagingId,
        thumpnailUrl: thumpnailUrl ?? this.thumpnailUrl,
        galleryImagesUrl: galleryImagesUrl ?? this.galleryImagesUrl,
        views: views ?? this.views,
        tags: tags ?? this.tags,
        metaTitle: metaTitle ?? this.metaTitle,
        metaDescription: metaDescription ?? this.metaDescription,
        metaKeywork: metaKeywork ?? this.metaKeywork,
        metaRobot: metaRobot ?? this.metaRobot,
        type: type ?? this.type,
        isFeatured: isFeatured ?? this.isFeatured,
        relatedIds: relatedIds ?? this.relatedIds,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    code: json["code"],
    productName: json["product_name"],
    price: json["price"],
    slug: json["slug"],
    sku: json["sku"],
    desctiption: json["desctiption"],
    detail: json["detail"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    stockQuantity: json["stock_quantity"],
    manufacturerId: json["manufacturer_id"],
    manufacturerName: json["manufacturer_name"],
    unitIt: json["unit_it"],
    packagingId: json["packaging_id"],
    thumpnailUrl: json["thumpnail_url"],
    galleryImagesUrl: json["gallery_images_url"] == null ? [] : List<GalleryImagesUrl>.from(json["gallery_images_url"]!.map((x) => GalleryImagesUrl.fromJson(x))),
    views: json["views"],
    tags: json["tags"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaKeywork: json["meta_keywork"],
    metaRobot: json["meta_robot"],
    type: json["type"],
    isFeatured: json["is_featured"],
    relatedIds: json["related_ids"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "product_name": productName,
    "price": price,
    "slug": slug,
    "sku": sku,
    "desctiption": desctiption,
    "detail": detail,
    "category_id": categoryId,
    "category_name": categoryName,
    "stock_quantity": stockQuantity,
    "manufacturer_id": manufacturerId,
    "manufacturer_name": manufacturerName,
    "unit_it": unitIt,
    "packaging_id": packagingId,
    "thumpnail_url": thumpnailUrl,
    "gallery_images_url": galleryImagesUrl == null ? [] : List<dynamic>.from(galleryImagesUrl!.map((x) => x.toJson())),
    "views": views,
    "tags": tags,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keywork": metaKeywork,
    "meta_robot": metaRobot,
    "type": type,
    "is_featured": isFeatured,
    "related_ids": relatedIds,
  };
}

class GalleryImagesUrl {
  String? largeUrl;
  String? smallUrl;

  GalleryImagesUrl({
    this.largeUrl,
    this.smallUrl,
  });

  GalleryImagesUrl copyWith({
    String? largeUrl,
    String? smallUrl,
  }) =>
      GalleryImagesUrl(
        largeUrl: largeUrl ?? this.largeUrl,
        smallUrl: smallUrl ?? this.smallUrl,
      );

  factory GalleryImagesUrl.fromJson(Map<String, dynamic> json) => GalleryImagesUrl(
    largeUrl: json["large_url"],
    smallUrl: json["small_url"],
  );

  Map<String, dynamic> toJson() => {
    "large_url": largeUrl,
    "small_url": smallUrl,
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
