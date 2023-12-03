// To parse this JSON data, do
//
//     final getOrderByIdRsp = getOrderByIdRspFromJson(jsonString);

import 'dart:convert';

GetOrderByIdRsp getOrderByIdRspFromJson(String str) => GetOrderByIdRsp.fromJson(json.decode(str));

String getOrderByIdRspToJson(GetOrderByIdRsp data) => json.encode(data.toJson());

class GetOrderByIdRsp {
    Data? data;

    GetOrderByIdRsp({
        this.data,
    });

    GetOrderByIdRsp copyWith({
        Data? data,
    }) => 
        GetOrderByIdRsp(
            data: data ?? this.data,
        );

    factory GetOrderByIdRsp.fromJson(Map<String, dynamic> json) => GetOrderByIdRsp(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    int? userId;
    List<OrderDetail>? orderDetails;
    String? orderNumber;
    List<InfoTotalAmount>? infoTotalAmount;
    String? statusCode;
    String? statusName;
    dynamic shippingCompanyId;
    String? name;
    String? phone;
    dynamic paymentUid;
    Payment? payment;
    dynamic couponCode;
    dynamic voucherCode;
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
        this.statusName,
        this.shippingCompanyId,
        this.name,
        this.phone,
        this.paymentUid,
        this.payment,
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
        String? statusName,
        dynamic shippingCompanyId,
        String? name,
        String? phone,
        dynamic paymentUid,
        Payment? payment,
        dynamic couponCode,
        dynamic voucherCode,
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
            statusName: statusName ?? this.statusName,
            shippingCompanyId: shippingCompanyId ?? this.shippingCompanyId,
            name: name ?? this.name,
            phone: phone ?? this.phone,
            paymentUid: paymentUid ?? this.paymentUid,
            payment: payment ?? this.payment,
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
        statusName: json["status_name"],
        shippingCompanyId: json["shipping_company_id"],
        name: json["name"],
        phone: json["phone"],
        paymentUid: json["payment_uid"],
        payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
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
        "status_name": statusName,
        "shipping_company_id": shippingCompanyId,
        "name": name,
        "phone": phone,
        "payment_uid": paymentUid,
        "payment": payment?.toJson(),
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
    String? subtotalFormated;

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
        this.subtotalFormated,
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
        String? subtotalFormated,
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
            subtotalFormated: subtotalFormated ?? this.subtotalFormated,
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
        subtotalFormated: json["subtotal_formated"],
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
        "subtotal_formated": subtotalFormated,
    };
}

class Payment {
    int? id;
    int? orderId;
    String? paymentMethod;
    String? paymentStatus;
    int? amount;
    dynamic paydate;
    dynamic bankCode;
    dynamic bankTranNo;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    Payment({
        this.id,
        this.orderId,
        this.paymentMethod,
        this.paymentStatus,
        this.amount,
        this.paydate,
        this.bankCode,
        this.bankTranNo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    Payment copyWith({
        int? id,
        int? orderId,
        String? paymentMethod,
        String? paymentStatus,
        int? amount,
        dynamic paydate,
        dynamic bankCode,
        dynamic bankTranNo,
        String? createdAt,
        String? updatedAt,
        dynamic deletedAt,
    }) => 
        Payment(
            id: id ?? this.id,
            orderId: orderId ?? this.orderId,
            paymentMethod: paymentMethod ?? this.paymentMethod,
            paymentStatus: paymentStatus ?? this.paymentStatus,
            amount: amount ?? this.amount,
            paydate: paydate ?? this.paydate,
            bankCode: bankCode ?? this.bankCode,
            bankTranNo: bankTranNo ?? this.bankTranNo,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
        );

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        orderId: json["order_id"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        amount: json["amount"],
        paydate: json["paydate"],
        bankCode: json["bank_code"],
        bankTranNo: json["bank_tran_no"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "amount": amount,
        "paydate": paydate,
        "bank_code": bankCode,
        "bank_tran_no": bankTranNo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
    };
}
