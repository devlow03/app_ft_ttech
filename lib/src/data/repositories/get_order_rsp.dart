// To parse this JSON data, do
//
//     final getOrderRsp = getOrderRspFromJson(jsonString);

import 'dart:convert';

GetOrderRsp getOrderRspFromJson(String str) => GetOrderRsp.fromJson(json.decode(str));

String getOrderRspToJson(GetOrderRsp data) => json.encode(data.toJson());

class GetOrderRsp {
  List<Data>? data;
  Response? response;
  Links? links;
  Meta? meta;

  GetOrderRsp({
    this.data,
    this.response,
    this.links,
    this.meta,
  });

  GetOrderRsp copyWith({
    List<Data>? data,
    Response? response,
    Links? links,
    Meta? meta,
  }) =>
      GetOrderRsp(
        data: data ?? this.data,
        response: response ?? this.response,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory GetOrderRsp.fromJson(Map<String, dynamic> json) => GetOrderRsp(
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
  List<OrderDetail>? orderDetails;
  String? orderNumber;
  List<InfoTotalAmount>? infoTotalAmount;
  String? statusCode;
  dynamic shippingCompanyId;
  String? name;
  String? phone;
  String? paymentUid;
  dynamic couponCode;
  String? voucherCode;
  dynamic note;
  String? recipientAddress;
  String? shippingAddress;
  String? billingAddress;
  dynamic freeItem;
  DateTime? orderDate;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.userId,
    this.orderDetails,
    this.orderNumber,
    this.infoTotalAmount,
    this.statusCode,
    this.shippingCompanyId,
    this.name,
    this.phone,
    this.paymentUid,
    this.couponCode,
    this.voucherCode,
    this.note,
    this.recipientAddress,
    this.shippingAddress,
    this.billingAddress,
    this.freeItem,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Data copyWith({
    int? id,
    int? userId,
    List<OrderDetail>? orderDetails,
    String? orderNumber,
    List<InfoTotalAmount>? infoTotalAmount,
    String? statusCode,
    dynamic shippingCompanyId,
    String? name,
    String? phone,
    String? paymentUid,
    dynamic couponCode,
    String? voucherCode,
    dynamic note,
    String? recipientAddress,
    String? shippingAddress,
    String? billingAddress,
    dynamic freeItem,
    DateTime? orderDate,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        orderDetails: orderDetails ?? this.orderDetails,
        orderNumber: orderNumber ?? this.orderNumber,
        infoTotalAmount: infoTotalAmount ?? this.infoTotalAmount,
        statusCode: statusCode ?? this.statusCode,
        shippingCompanyId: shippingCompanyId ?? this.shippingCompanyId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        paymentUid: paymentUid ?? this.paymentUid,
        couponCode: couponCode ?? this.couponCode,
        voucherCode: voucherCode ?? this.voucherCode,
        note: note ?? this.note,
        recipientAddress: recipientAddress ?? this.recipientAddress,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        billingAddress: billingAddress ?? this.billingAddress,
        freeItem: freeItem ?? this.freeItem,
        orderDate: orderDate ?? this.orderDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
    orderNumber: json["order_number"],
    infoTotalAmount: json["info_total_amount"] == null ? [] : List<InfoTotalAmount>.from(json["info_total_amount"]!.map((x) => InfoTotalAmount.fromJson(x))),
    statusCode: json["status_code"],
    shippingCompanyId: json["shipping_company_id"],
    name: json["name"],
    phone: json["phone"],
    paymentUid: json["payment_uid"],
    couponCode: json["coupon_code"],
    voucherCode: json["voucher_code"],
    note: json["note"],
    recipientAddress: json["recipient_address"],
    shippingAddress: json["shipping_address"],
    billingAddress: json["billing_address"],
    freeItem: json["free_item"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
    "order_number": orderNumber,
    "info_total_amount": infoTotalAmount == null ? [] : List<dynamic>.from(infoTotalAmount!.map((x) => x.toJson())),
    "status_code": statusCode,
    "shipping_company_id": shippingCompanyId,
    "name": name,
    "phone": phone,
    "payment_uid": paymentUid,
    "coupon_code": couponCode,
    "voucher_code": voucherCode,
    "note": note,
    "recipient_address": recipientAddress,
    "shipping_address": shippingAddress,
    "billing_address": billingAddress,
    "free_item": freeItem,
    "order_date": "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

class InfoTotalAmount {
  String? code;
  String? text;
  String? title;
  int? value;

  InfoTotalAmount({
    this.code,
    this.text,
    this.title,
    this.value,
  });

  InfoTotalAmount copyWith({
    String? code,
    String? text,
    String? title,
    int? value,
  }) =>
      InfoTotalAmount(
        code: code ?? this.code,
        text: text ?? this.text,
        title: title ?? this.title,
        value: value ?? this.value,
      );

  factory InfoTotalAmount.fromJson(Map<String, dynamic> json) => InfoTotalAmount(
    code: json["code"],
    text: json["text"],
    title: json["title"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "text": text,
    "title": title,
    "value": value,
  };
}

class OrderDetail {
  int? id;
  int? productId;
  String? productName;
  String? thumpnailUrl;
  int? quantity;
  int? price;
  String? priceFormated;
  dynamic option;
  int? subtotal;

  OrderDetail({
    this.id,
    this.productId,
    this.productName,
    this.thumpnailUrl,
    this.quantity,
    this.price,
    this.priceFormated,
    this.option,
    this.subtotal,
  });

  OrderDetail copyWith({
    int? id,
    int? productId,
    String? productName,
    String? thumpnailUrl,
    int? quantity,
    int? price,
    String? priceFormated,
    dynamic option,
    int? subtotal,
  }) =>
      OrderDetail(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        thumpnailUrl: thumpnailUrl ?? this.thumpnailUrl,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        priceFormated: priceFormated ?? this.priceFormated,
        option: option ?? this.option,
        subtotal: subtotal ?? this.subtotal,
      );

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    productId: json["product_id"],
    productName: json["product_name"],
    thumpnailUrl: json["thumpnail_url"],
    quantity: json["quantity"],
    price: json["price"],
    priceFormated: json["price_formated"],
    option: json["option"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "thumpnail_url": thumpnailUrl,
    "quantity": quantity,
    "price": price,
    "price_formated": priceFormated,
    "option": option,
    "subtotal": subtotal,
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
