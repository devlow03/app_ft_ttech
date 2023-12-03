// To parse this JSON data, do
//
//     final getProductByIdRsp = getProductByIdRspFromJson(jsonString);

import 'dart:convert';

GetProductByIdRsp getProductByIdRspFromJson(String str) => GetProductByIdRsp.fromJson(json.decode(str));

String getProductByIdRspToJson(GetProductByIdRsp data) => json.encode(data.toJson());

class GetProductByIdRsp {
    Data? data;

    GetProductByIdRsp({
        this.data,
    });

    GetProductByIdRsp copyWith({
        Data? data,
    }) => 
        GetProductByIdRsp(
            data: data ?? this.data,
        );

    factory GetProductByIdRsp.fromJson(Map<String, dynamic> json) => GetProductByIdRsp(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    dynamic code;
    String? productName;
    int? defaultPrice;
    int? price;
    String? slug;
    dynamic sku;
    String? desctiption;
    String? detail;
    bool? favorite;
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
        this.defaultPrice,
        this.price,
        this.slug,
        this.sku,
        this.desctiption,
        this.detail,
        this.favorite,
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
        int? defaultPrice,
        int? price,
        String? slug,
        dynamic sku,
        String? desctiption,
        String? detail,
        bool? favorite,
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
            defaultPrice: defaultPrice ?? this.defaultPrice,
            price: price ?? this.price,
            slug: slug ?? this.slug,
            sku: sku ?? this.sku,
            desctiption: desctiption ?? this.desctiption,
            detail: detail ?? this.detail,
            favorite: favorite ?? this.favorite,
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
        defaultPrice: json["default_price"],
        price: json["price"],
        slug: json["slug"],
        sku: json["sku"],
        desctiption: json["desctiption"],
        detail: json["detail"],
        favorite: json["favorite"],
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
        "default_price": defaultPrice,
        "price": price,
        "slug": slug,
        "sku": sku,
        "desctiption": desctiption,
        "detail": detail,
        "favorite": favorite,
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
