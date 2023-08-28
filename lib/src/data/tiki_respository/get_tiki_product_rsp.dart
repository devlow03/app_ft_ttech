// To parse this JSON data, do
//
//     final getTikiProductRsp = getTikiProductRspFromJson(jsonString);

import 'dart:convert';

GetTikiProductRsp getTikiProductRspFromJson(String str) => GetTikiProductRsp.fromJson(json.decode(str));

String getTikiProductRspToJson(GetTikiProductRsp data) => json.encode(data.toJson());

class GetTikiProductRsp {
  num? id;
  num? masterId;
  String? sku;
  String? name;
  String? urlKey;
  String? urlPath;
  String? shortUrl;
  String? type;
  dynamic bookCover;
  String? shortDescription;
  num? price;
  num? listPrice;
  num? originalPrice;
  List<Badge>? badges;
  List<dynamic>? badgesNew;
  num? discount;
  num? discountRate;
  num? ratingAverage;
  num? reviewCount;
  String? reviewText;
  num? favouriteCount;
  String? thumbnailUrl;
  bool? hasEbook;
  String? inventoryStatus;
  String? inventoryType;
  String? productsetGroupName;
  bool? isFresh;
  dynamic seller;
  bool? isFlower;
  bool? hasBuynow;
  bool? isGiftCard;
  dynamic salableType;
  num? dataVersion;
  num? dayAgoCreated;
  num? allTimeQuantitySold;
  String? metaTitle;
  String? metaDescription;
  String? metaKeywords;
  bool? isBabyMilk;
  bool? isAcoholicDrink;
  String? description;
  List<GetTikiProductRspImage>? images;
  dynamic warrantyPolicy;
  Brand? brand;
  CurrentSeller? currentSeller;
  List<dynamic>? otherSellers;
  List<SellerSpecification>? sellerSpecifications;
  List<Specification>? specifications;
  List<dynamic>? productLinks;
  String? giftItemTitle;
  List<ConfigurableOption>? configurableOptions;
  List<ConfigurableProduct>? configurableProducts;
  List<dynamic>? servicesAndPromotions;
  List<dynamic>? promitions;
  StockItem? stockItem;
  String? addOnTitle;
  List<AddOn>? addOn;
  QuantitySold? quantitySold;
  Categories? categories;
  List<Breadcrumb>? breadcrumbs;
  InstallmentInfoV2? installmentInfoV2;
  bool? isSellerInChatWhitelist;
  Inventory? inventory;
  List<WarrantyInfo>? warrantyInfo;
  String? returnAndExchangePolicy;
  bool? isTierPricingAvailable;
  bool? isTierPricingEligible;
  List<Benefit>? benefits;

  GetTikiProductRsp({
    this.id,
    this.masterId,
    this.sku,
    this.name,
    this.urlKey,
    this.urlPath,
    this.shortUrl,
    this.type,
    this.bookCover,
    this.shortDescription,
    this.price,
    this.listPrice,
    this.originalPrice,
    this.badges,
    this.badgesNew,
    this.discount,
    this.discountRate,
    this.ratingAverage,
    this.reviewCount,
    this.reviewText,
    this.favouriteCount,
    this.thumbnailUrl,
    this.hasEbook,
    this.inventoryStatus,
    this.inventoryType,
    this.productsetGroupName,
    this.isFresh,
    this.seller,
    this.isFlower,
    this.hasBuynow,
    this.isGiftCard,
    this.salableType,
    this.dataVersion,
    this.dayAgoCreated,
    this.allTimeQuantitySold,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.isBabyMilk,
    this.isAcoholicDrink,
    this.description,
    this.images,
    this.warrantyPolicy,
    this.brand,
    this.currentSeller,
    this.otherSellers,
    this.sellerSpecifications,
    this.specifications,
    this.productLinks,
    this.giftItemTitle,
    this.configurableOptions,
    this.configurableProducts,
    this.servicesAndPromotions,
    this.promitions,
    this.stockItem,
    this.addOnTitle,
    this.addOn,
    this.quantitySold,
    this.categories,
    this.breadcrumbs,
    this.installmentInfoV2,
    this.isSellerInChatWhitelist,
    this.inventory,
    this.warrantyInfo,
    this.returnAndExchangePolicy,
    this.isTierPricingAvailable,
    this.isTierPricingEligible,
    this.benefits,
  });

  factory GetTikiProductRsp.fromJson(Map<String, dynamic> json) => GetTikiProductRsp(
    id: json["id"],
    masterId: json["master_id"],
    sku: json["sku"],
    name: json["name"],
    urlKey: json["url_key"],
    urlPath: json["url_path"],
    shortUrl: json["short_url"],
    type: json["type"],
    bookCover: json["book_cover"],
    shortDescription: json["short_description"],
    price: json["price"],
    listPrice: json["list_price"],
    originalPrice: json["original_price"],
    badges: json["badges"] == null ? [] : List<Badge>.from(json["badges"]!.map((x) => Badge.fromJson(x))),
    badgesNew: json["badges_new"] == null ? [] : List<dynamic>.from(json["badges_new"]!.map((x) => x)),
    discount: json["discount"],
    discountRate: json["discount_rate"],
    ratingAverage: json["rating_average"],
    reviewCount: json["review_count"],
    reviewText: json["review_text"],
    favouriteCount: json["favourite_count"],
    thumbnailUrl: json["thumbnail_url"],
    hasEbook: json["has_ebook"],
    inventoryStatus: json["inventory_status"],
    inventoryType: json["inventory_type"],
    productsetGroupName: json["productset_group_name"],
    isFresh: json["is_fresh"],
    seller: json["seller"],
    isFlower: json["is_flower"],
    hasBuynow: json["has_buynow"],
    isGiftCard: json["is_gift_card"],
    salableType: json["salable_type"],
    dataVersion: json["data_version"],
    dayAgoCreated: json["day_ago_created"],
    allTimeQuantitySold: json["all_time_quantity_sold"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    isBabyMilk: json["is_baby_milk"],
    isAcoholicDrink: json["is_acoholic_drink"],
    description: json["description"],
    images: json["images"] == null ? [] : List<GetTikiProductRspImage>.from(json["images"]!.map((x) => GetTikiProductRspImage.fromJson(x))),
    warrantyPolicy: json["warranty_policy"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    currentSeller: json["current_seller"] == null ? null : CurrentSeller.fromJson(json["current_seller"]),
    otherSellers: json["other_sellers"] == null ? [] : List<dynamic>.from(json["other_sellers"]!.map((x) => x)),
    sellerSpecifications: json["seller_specifications"] == null ? [] : List<SellerSpecification>.from(json["seller_specifications"]!.map((x) => SellerSpecification.fromJson(x))),
    specifications: json["specifications"] == null ? [] : List<Specification>.from(json["specifications"]!.map((x) => Specification.fromJson(x))),
    productLinks: json["product_links"] == null ? [] : List<dynamic>.from(json["product_links"]!.map((x) => x)),
    giftItemTitle: json["gift_item_title"],
    configurableOptions: json["configurable_options"] == null ? [] : List<ConfigurableOption>.from(json["configurable_options"]!.map((x) => ConfigurableOption.fromJson(x))),
    configurableProducts: json["configurable_products"] == null ? [] : List<ConfigurableProduct>.from(json["configurable_products"]!.map((x) => ConfigurableProduct.fromJson(x))),
    servicesAndPromotions: json["services_and_promotions"] == null ? [] : List<dynamic>.from(json["services_and_promotions"]!.map((x) => x)),
    promitions: json["promitions"] == null ? [] : List<dynamic>.from(json["promitions"]!.map((x) => x)),
    stockItem: json["stock_item"] == null ? null : StockItem.fromJson(json["stock_item"]),
    addOnTitle: json["add_on_title"],
    addOn: json["add_on"] == null ? [] : List<AddOn>.from(json["add_on"]!.map((x) => AddOn.fromJson(x))),
    quantitySold: json["quantity_sold"] == null ? null : QuantitySold.fromJson(json["quantity_sold"]),
    categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
    breadcrumbs: json["breadcrumbs"] == null ? [] : List<Breadcrumb>.from(json["breadcrumbs"]!.map((x) => Breadcrumb.fromJson(x))),
    installmentInfoV2: json["installment_info_v2"] == null ? null : InstallmentInfoV2.fromJson(json["installment_info_v2"]),
    isSellerInChatWhitelist: json["is_seller_in_chat_whitelist"],
    inventory: json["inventory"] == null ? null : Inventory.fromJson(json["inventory"]),
    warrantyInfo: json["warranty_info"] == null ? [] : List<WarrantyInfo>.from(json["warranty_info"]!.map((x) => WarrantyInfo.fromJson(x))),
    returnAndExchangePolicy: json["return_and_exchange_policy"],
    isTierPricingAvailable: json["is_tier_pricing_available"],
    isTierPricingEligible: json["is_tier_pricing_eligible"],
    benefits: json["benefits"] == null ? [] : List<Benefit>.from(json["benefits"]!.map((x) => Benefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "master_id": masterId,
    "sku": sku,
    "name": name,
    "url_key": urlKey,
    "url_path": urlPath,
    "short_url": shortUrl,
    "type": type,
    "book_cover": bookCover,
    "short_description": shortDescription,
    "price": price,
    "list_price": listPrice,
    "original_price": originalPrice,
    "badges": badges == null ? [] : List<dynamic>.from(badges!.map((x) => x.toJson())),
    "badges_new": badgesNew == null ? [] : List<dynamic>.from(badgesNew!.map((x) => x)),
    "discount": discount,
    "discount_rate": discountRate,
    "rating_average": ratingAverage,
    "review_count": reviewCount,
    "review_text": reviewText,
    "favourite_count": favouriteCount,
    "thumbnail_url": thumbnailUrl,
    "has_ebook": hasEbook,
    "inventory_status": inventoryStatus,
    "inventory_type": inventoryType,
    "productset_group_name": productsetGroupName,
    "is_fresh": isFresh,
    "seller": seller,
    "is_flower": isFlower,
    "has_buynow": hasBuynow,
    "is_gift_card": isGiftCard,
    "salable_type": salableType,
    "data_version": dataVersion,
    "day_ago_created": dayAgoCreated,
    "all_time_quantity_sold": allTimeQuantitySold,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "is_baby_milk": isBabyMilk,
    "is_acoholic_drink": isAcoholicDrink,
    "description": description,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "warranty_policy": warrantyPolicy,
    "brand": brand?.toJson(),
    "current_seller": currentSeller?.toJson(),
    "other_sellers": otherSellers == null ? [] : List<dynamic>.from(otherSellers!.map((x) => x)),
    "seller_specifications": sellerSpecifications == null ? [] : List<dynamic>.from(sellerSpecifications!.map((x) => x.toJson())),
    "specifications": specifications == null ? [] : List<dynamic>.from(specifications!.map((x) => x.toJson())),
    "product_links": productLinks == null ? [] : List<dynamic>.from(productLinks!.map((x) => x)),
    "gift_item_title": giftItemTitle,
    "configurable_options": configurableOptions == null ? [] : List<dynamic>.from(configurableOptions!.map((x) => x.toJson())),
    "configurable_products": configurableProducts == null ? [] : List<dynamic>.from(configurableProducts!.map((x) => x.toJson())),
    "services_and_promotions": servicesAndPromotions == null ? [] : List<dynamic>.from(servicesAndPromotions!.map((x) => x)),
    "promitions": promitions == null ? [] : List<dynamic>.from(promitions!.map((x) => x)),
    "stock_item": stockItem?.toJson(),
    "add_on_title": addOnTitle,
    "add_on": addOn == null ? [] : List<dynamic>.from(addOn!.map((x) => x.toJson())),
    "quantity_sold": quantitySold?.toJson(),
    "categories": categories?.toJson(),
    "breadcrumbs": breadcrumbs == null ? [] : List<dynamic>.from(breadcrumbs!.map((x) => x.toJson())),
    "installment_info_v2": installmentInfoV2?.toJson(),
    "is_seller_in_chat_whitelist": isSellerInChatWhitelist,
    "inventory": inventory?.toJson(),
    "warranty_info": warrantyInfo == null ? [] : List<dynamic>.from(warrantyInfo!.map((x) => x.toJson())),
    "return_and_exchange_policy": returnAndExchangePolicy,
    "is_tier_pricing_available": isTierPricingAvailable,
    "is_tier_pricing_eligible": isTierPricingEligible,
    "benefits": benefits == null ? [] : List<dynamic>.from(benefits!.map((x) => x.toJson())),
  };
}

class AddOn {
  num? id;
  String? name;
  String? thumbnailUrl;
  num? price;
  String? addOnDescription;
  List<String>? addOnDescriptionList;
  num? listPrice;
  bool? isVisible;
  String? url;
  String? addOnInformationTitle;
  String? addOnInformationUrl;
  num? isDefaultSelectAddon;

  AddOn({
    this.id,
    this.name,
    this.thumbnailUrl,
    this.price,
    this.addOnDescription,
    this.addOnDescriptionList,
    this.listPrice,
    this.isVisible,
    this.url,
    this.addOnInformationTitle,
    this.addOnInformationUrl,
    this.isDefaultSelectAddon,
  });

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
    id: json["id"],
    name: json["name"],
    thumbnailUrl: json["thumbnail_url"],
    price: json["price"],
    addOnDescription: json["add_on_description"],
    addOnDescriptionList: json["add_on_description_list"] == null ? [] : List<String>.from(json["add_on_description_list"]!.map((x) => x)),
    listPrice: json["list_price"],
    isVisible: json["is_visible"],
    url: json["url"],
    addOnInformationTitle: json["add_on_information_title"],
    addOnInformationUrl: json["add_on_information_url"],
    isDefaultSelectAddon: json["is_default_select_addon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_url": thumbnailUrl,
    "price": price,
    "add_on_description": addOnDescription,
    "add_on_description_list": addOnDescriptionList == null ? [] : List<dynamic>.from(addOnDescriptionList!.map((x) => x)),
    "list_price": listPrice,
    "is_visible": isVisible,
    "url": url,
    "add_on_information_title": addOnInformationTitle,
    "add_on_information_url": addOnInformationUrl,
    "is_default_select_addon": isDefaultSelectAddon,
  };
}

class Badge {
  String? code;
  String? text;

  Badge({
    this.code,
    this.text,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
    code: json["code"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "text": text,
  };
}

class Benefit {
  String? icon;
  String? text;
  String? extraText;
  String? extraHeader;
  List<WarrantyInfo>? extra;

  Benefit({
    this.icon,
    this.text,
    this.extraText,
    this.extraHeader,
    this.extra,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
    icon: json["icon"],
    text: json["text"],
    extraText: json["extra_text"],
    extraHeader: json["extra_header"],
    extra: json["extra"] == null ? [] : List<WarrantyInfo>.from(json["extra"]!.map((x) => WarrantyInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "text": text,
    "extra_text": extraText,
    "extra_header": extraHeader,
    "extra": extra == null ? [] : List<dynamic>.from(extra!.map((x) => x.toJson())),
  };
}

class WarrantyInfo {
  String? name;
  String? value;
  String? url;

  WarrantyInfo({
    this.name,
    this.value,
    this.url,
  });

  factory WarrantyInfo.fromJson(Map<String, dynamic> json) => WarrantyInfo(
    name: json["name"],
    value: json["value"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
    "url": url,
  };
}

class Brand {
  num? id;
  String? name;
  String? slug;

  Brand({
    this.id,
    this.name,
    this.slug,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}

class Breadcrumb {
  String? url;
  String? name;
  num? categoryId;

  Breadcrumb({
    this.url,
    this.name,
    this.categoryId,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
    url: json["url"],
    name: json["name"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "name": name,
    "category_id": categoryId,
  };
}

class Categories {
  num? id;
  String? name;
  bool? isLeaf;

  Categories({
    this.id,
    this.name,
    this.isLeaf,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    name: json["name"],
    isLeaf: json["is_leaf"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_leaf": isLeaf,
  };
}

class ConfigurableOption {
  String? code;
  String? name;
  num? position;
  bool? showPreviewImage;
  List<Value>? values;

  ConfigurableOption({
    this.code,
    this.name,
    this.position,
    this.showPreviewImage,
    this.values,
  });

  factory ConfigurableOption.fromJson(Map<String, dynamic> json) => ConfigurableOption(
    code: json["code"],
    name: json["name"],
    position: json["position"],
    showPreviewImage: json["show_preview_image"],
    values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "position": position,
    "show_preview_image": showPreviewImage,
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class Value {
  String? label;

  Value({
    this.label,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
  };
}

class ConfigurableProduct {
  num? childId;
  num? id;
  List<ConfigurableProductImage>? images;
  String? inventoryStatus;
  String? name;
  String? option1;
  String? option2;
  num? price;
  bool? selected;
  Seller? seller;
  String? sku;
  String? thumbnailUrl;

  ConfigurableProduct({
    this.childId,
    this.id,
    this.images,
    this.inventoryStatus,
    this.name,
    this.option1,
    this.option2,
    this.price,
    this.selected,
    this.seller,
    this.sku,
    this.thumbnailUrl,
  });

  factory ConfigurableProduct.fromJson(Map<String, dynamic> json) => ConfigurableProduct(
    childId: json["child_id"],
    id: json["id"],
    images: json["images"] == null ? [] : List<ConfigurableProductImage>.from(json["images"]!.map((x) => ConfigurableProductImage.fromJson(x))),
    inventoryStatus: json["inventory_status"],
    name: json["name"],
    option1: json["option1"],
    option2: json["option2"],
    price: json["price"],
    selected: json["selected"],
    seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    sku: json["sku"],
    thumbnailUrl: json["thumbnail_url"],
  );

  Map<String, dynamic> toJson() => {
    "child_id": childId,
    "id": id,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "inventory_status": inventoryStatus,
    "name": name,
    "option1": option1,
    "option2": option2,
    "price": price,
    "selected": selected,
    "seller": seller?.toJson(),
    "sku": sku,
    "thumbnail_url": thumbnailUrl,
  };
}

class ConfigurableProductImage {
  String? largeUrl;
  String? mediumUrl;
  String? smallUrl;

  ConfigurableProductImage({
    this.largeUrl,
    this.mediumUrl,
    this.smallUrl,
  });

  factory ConfigurableProductImage.fromJson(Map<String, dynamic> json) => ConfigurableProductImage(
    largeUrl: json["large_url"],
    mediumUrl: json["medium_url"],
    smallUrl: json["small_url"],
  );

  Map<String, dynamic> toJson() => {
    "large_url": largeUrl,
    "medium_url": mediumUrl,
    "small_url": smallUrl,
  };
}

class Seller {
  num? id;
  String? name;

  Seller({
    this.id,
    this.name,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class CurrentSeller {
  num? id;
  String? sku;
  String? name;
  String? link;
  String? logo;
  num? price;
  String? productId;
  num? storeId;
  bool? isBestStore;
  dynamic isOfflineInstallmentSupported;

  CurrentSeller({
    this.id,
    this.sku,
    this.name,
    this.link,
    this.logo,
    this.price,
    this.productId,
    this.storeId,
    this.isBestStore,
    this.isOfflineInstallmentSupported,
  });

  factory CurrentSeller.fromJson(Map<String, dynamic> json) => CurrentSeller(
    id: json["id"],
    sku: json["sku"],
    name: json["name"],
    link: json["link"],
    logo: json["logo"],
    price: json["price"],
    productId: json["product_id"],
    storeId: json["store_id"],
    isBestStore: json["is_best_store"],
    isOfflineInstallmentSupported: json["is_offline_installment_supported"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sku": sku,
    "name": name,
    "link": link,
    "logo": logo,
    "price": price,
    "product_id": productId,
    "store_id": storeId,
    "is_best_store": isBestStore,
    "is_offline_installment_supported": isOfflineInstallmentSupported,
  };
}

class GetTikiProductRspImage {
  String? baseUrl;
  bool? isGallery;
  dynamic label;
  String? largeUrl;
  String? mediumUrl;
  dynamic position;
  String? smallUrl;
  String? thumbnailUrl;

  GetTikiProductRspImage({
    this.baseUrl,
    this.isGallery,
    this.label,
    this.largeUrl,
    this.mediumUrl,
    this.position,
    this.smallUrl,
    this.thumbnailUrl,
  });

  factory GetTikiProductRspImage.fromJson(Map<String, dynamic> json) => GetTikiProductRspImage(
    baseUrl: json["base_url"],
    isGallery: json["is_gallery"],
    label: json["label"],
    largeUrl: json["large_url"],
    mediumUrl: json["medium_url"],
    position: json["position"],
    smallUrl: json["small_url"],
    thumbnailUrl: json["thumbnail_url"],
  );

  Map<String, dynamic> toJson() => {
    "base_url": baseUrl,
    "is_gallery": isGallery,
    "label": label,
    "large_url": largeUrl,
    "medium_url": mediumUrl,
    "position": position,
    "small_url": smallUrl,
    "thumbnail_url": thumbnailUrl,
  };
}

class InstallmentInfoV2 {
  String? title;
  String? summary;
  String? redirectUrl;
  dynamic details;

  InstallmentInfoV2({
    this.title,
    this.summary,
    this.redirectUrl,
    this.details,
  });

  factory InstallmentInfoV2.fromJson(Map<String, dynamic> json) => InstallmentInfoV2(
    title: json["title"],
    summary: json["summary"],
    redirectUrl: json["redirect_url"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "summary": summary,
    "redirect_url": redirectUrl,
    "details": details,
  };
}

class Inventory {
  dynamic productVirtualType;
  String? fulfillmentType;

  Inventory({
    this.productVirtualType,
    this.fulfillmentType,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
    productVirtualType: json["product_virtual_type"],
    fulfillmentType: json["fulfillment_type"],
  );

  Map<String, dynamic> toJson() => {
    "product_virtual_type": productVirtualType,
    "fulfillment_type": fulfillmentType,
  };
}

class QuantitySold {
  String? text;
  num? value;

  QuantitySold({
    this.text,
    this.value,
  });

  factory QuantitySold.fromJson(Map<String, dynamic> json) => QuantitySold(
    text: json["text"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "value": value,
  };
}

class SellerSpecification {
  String? name;
  dynamic url;
  dynamic value;

  SellerSpecification({
    this.name,
    this.url,
    this.value,
  });

  factory SellerSpecification.fromJson(Map<String, dynamic> json) => SellerSpecification(
    name: json["name"],
    url: json["url"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
    "value": value,
  };
}

class Specification {
  String? name;
  List<Attribute>? attributes;

  Specification({
    this.name,
    this.attributes,
  });

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
    name: json["name"],
    attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class Attribute {
  String? code;
  String? name;
  String? value;

  Attribute({
    this.code,
    this.name,
    this.value,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    code: json["code"],
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "value": value,
  };
}

class StockItem {
  num? maxSaleQty;
  num? minSaleQty;
  dynamic preorderDate;
  num? qty;

  StockItem({
    this.maxSaleQty,
    this.minSaleQty,
    this.preorderDate,
    this.qty,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) => StockItem(
    maxSaleQty: json["max_sale_qty"],
    minSaleQty: json["min_sale_qty"],
    preorderDate: json["preorder_date"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "max_sale_qty": maxSaleQty,
    "min_sale_qty": minSaleQty,
    "preorder_date": preorderDate,
    "qty": qty,
  };
}
