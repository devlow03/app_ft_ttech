// To parse this JSON data, do
//
//     final postCreateShippingOrderRsp = postCreateShippingOrderRspFromJson(jsonString);

import 'dart:convert';

PostCreateShippingOrderRsp postCreateShippingOrderRspFromJson(String str) => PostCreateShippingOrderRsp.fromJson(json.decode(str));

String postCreateShippingOrderRspToJson(PostCreateShippingOrderRsp data) => json.encode(data.toJson());

class PostCreateShippingOrderRsp {
    int? code;
    String? codeMessageValue;
    Data? data;
    String? message;
    String? messageDisplay;

    PostCreateShippingOrderRsp({
        this.code,
        this.codeMessageValue,
        this.data,
        this.message,
        this.messageDisplay,
    });

    PostCreateShippingOrderRsp copyWith({
        int? code,
        String? codeMessageValue,
        Data? data,
        String? message,
        String? messageDisplay,
    }) => 
        PostCreateShippingOrderRsp(
            code: code ?? this.code,
            codeMessageValue: codeMessageValue ?? this.codeMessageValue,
            data: data ?? this.data,
            message: message ?? this.message,
            messageDisplay: messageDisplay ?? this.messageDisplay,
        );

    factory PostCreateShippingOrderRsp.fromJson(Map<String, dynamic> json) => PostCreateShippingOrderRsp(
        code: json["code"],
        codeMessageValue: json["code_message_value"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        messageDisplay: json["message_display"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "code_message_value": codeMessageValue,
        "data": data?.toJson(),
        "message": message,
        "message_display": messageDisplay,
    };
}

class Data {
    String? orderCode;
    String? sortCode;
    String? transType;
    String? wardEncode;
    String? districtEncode;
    Fee? fee;
    int? totalFee;
    String? expectedDeliveryTime;
    int? id;

    Data({
        this.orderCode,
        this.sortCode,
        this.transType,
        this.wardEncode,
        this.districtEncode,
        this.fee,
        this.totalFee,
        this.expectedDeliveryTime,
        this.id,
    });

    Data copyWith({
        String? orderCode,
        String? sortCode,
        String? transType,
        String? wardEncode,
        String? districtEncode,
        Fee? fee,
        int? totalFee,
        String? expectedDeliveryTime,
        int? id,
    }) => 
        Data(
            orderCode: orderCode ?? this.orderCode,
            sortCode: sortCode ?? this.sortCode,
            transType: transType ?? this.transType,
            wardEncode: wardEncode ?? this.wardEncode,
            districtEncode: districtEncode ?? this.districtEncode,
            fee: fee ?? this.fee,
            totalFee: totalFee ?? this.totalFee,
            expectedDeliveryTime: expectedDeliveryTime ?? this.expectedDeliveryTime,
            id: id ?? this.id,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderCode: json["order_code"],
        sortCode: json["sort_code"],
        transType: json["trans_type"],
        wardEncode: json["ward_encode"],
        districtEncode: json["district_encode"],
        fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]),
        totalFee: json["total_fee"],
        expectedDeliveryTime: json["expected_delivery_time"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "order_code": orderCode,
        "sort_code": sortCode,
        "trans_type": transType,
        "ward_encode": wardEncode,
        "district_encode": districtEncode,
        "fee": fee?.toJson(),
        "total_fee": totalFee,
        "expected_delivery_time": expectedDeliveryTime,
        "id": id,
    };
}

class Fee {
    int? mainService;
    int? insurance;
    int? codFee;
    int? stationDo;
    int? stationPu;
    int? feeReturn;
    int? r2S;
    int? returnAgain;
    int? coupon;
    int? documentReturn;
    int? doubleCheck;
    int? doubleCheckDeliver;
    int? pickRemoteAreasFee;
    int? deliverRemoteAreasFee;
    int? pickRemoteAreasFeeReturn;
    int? deliverRemoteAreasFeeReturn;
    int? codFailedFee;

    Fee({
        this.mainService,
        this.insurance,
        this.codFee,
        this.stationDo,
        this.stationPu,
        this.feeReturn,
        this.r2S,
        this.returnAgain,
        this.coupon,
        this.documentReturn,
        this.doubleCheck,
        this.doubleCheckDeliver,
        this.pickRemoteAreasFee,
        this.deliverRemoteAreasFee,
        this.pickRemoteAreasFeeReturn,
        this.deliverRemoteAreasFeeReturn,
        this.codFailedFee,
    });

    Fee copyWith({
        int? mainService,
        int? insurance,
        int? codFee,
        int? stationDo,
        int? stationPu,
        int? feeReturn,
        int? r2S,
        int? returnAgain,
        int? coupon,
        int? documentReturn,
        int? doubleCheck,
        int? doubleCheckDeliver,
        int? pickRemoteAreasFee,
        int? deliverRemoteAreasFee,
        int? pickRemoteAreasFeeReturn,
        int? deliverRemoteAreasFeeReturn,
        int? codFailedFee,
    }) => 
        Fee(
            mainService: mainService ?? this.mainService,
            insurance: insurance ?? this.insurance,
            codFee: codFee ?? this.codFee,
            stationDo: stationDo ?? this.stationDo,
            stationPu: stationPu ?? this.stationPu,
            feeReturn: feeReturn ?? this.feeReturn,
            r2S: r2S ?? this.r2S,
            returnAgain: returnAgain ?? this.returnAgain,
            coupon: coupon ?? this.coupon,
            documentReturn: documentReturn ?? this.documentReturn,
            doubleCheck: doubleCheck ?? this.doubleCheck,
            doubleCheckDeliver: doubleCheckDeliver ?? this.doubleCheckDeliver,
            pickRemoteAreasFee: pickRemoteAreasFee ?? this.pickRemoteAreasFee,
            deliverRemoteAreasFee: deliverRemoteAreasFee ?? this.deliverRemoteAreasFee,
            pickRemoteAreasFeeReturn: pickRemoteAreasFeeReturn ?? this.pickRemoteAreasFeeReturn,
            deliverRemoteAreasFeeReturn: deliverRemoteAreasFeeReturn ?? this.deliverRemoteAreasFeeReturn,
            codFailedFee: codFailedFee ?? this.codFailedFee,
        );

    factory Fee.fromJson(Map<String, dynamic> json) => Fee(
        mainService: json["main_service"],
        insurance: json["insurance"],
        codFee: json["cod_fee"],
        stationDo: json["station_do"],
        stationPu: json["station_pu"],
        feeReturn: json["return"],
        r2S: json["r2s"],
        returnAgain: json["return_again"],
        coupon: json["coupon"],
        documentReturn: json["document_return"],
        doubleCheck: json["double_check"],
        doubleCheckDeliver: json["double_check_deliver"],
        pickRemoteAreasFee: json["pick_remote_areas_fee"],
        deliverRemoteAreasFee: json["deliver_remote_areas_fee"],
        pickRemoteAreasFeeReturn: json["pick_remote_areas_fee_return"],
        deliverRemoteAreasFeeReturn: json["deliver_remote_areas_fee_return"],
        codFailedFee: json["cod_failed_fee"],
    );

    Map<String, dynamic> toJson() => {
        "main_service": mainService,
        "insurance": insurance,
        "cod_fee": codFee,
        "station_do": stationDo,
        "station_pu": stationPu,
        "return": feeReturn,
        "r2s": r2S,
        "return_again": returnAgain,
        "coupon": coupon,
        "document_return": documentReturn,
        "double_check": doubleCheck,
        "double_check_deliver": doubleCheckDeliver,
        "pick_remote_areas_fee": pickRemoteAreasFee,
        "deliver_remote_areas_fee": deliverRemoteAreasFee,
        "pick_remote_areas_fee_return": pickRemoteAreasFeeReturn,
        "deliver_remote_areas_fee_return": deliverRemoteAreasFeeReturn,
        "cod_failed_fee": codFailedFee,
    };
}
