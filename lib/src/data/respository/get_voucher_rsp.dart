/// data : [{"voucher_code":"GIAMGIADIENTHOAI","voucher_value":"20","voucher_type":"T","title":"Voucher Điện thoại","voucher_date_start":null,"voucher_date_end":null,"created_at":null,"updated_at":null,"deleted_at":null},{"voucher_code":"VOUCHERCODE","voucher_value":"100","voucher_type":"T","title":"Voucher sinh nhật","voucher_date_start":"2023-08-08 11:51:54","voucher_date_end":"2023-09-08 13:51:55","created_at":"2023-08-08T06:51:59.000000Z","updated_at":"2023-08-08T06:51:59.000000Z","deleted_at":null},{"voucher_code":"VOUCHERCODE20","voucher_value":null,"voucher_type":null,"title":"Voucher Tết Việt","voucher_date_start":"2023-09-09 14:47:45","voucher_date_end":"2023-10-09 14:47:52","created_at":null,"updated_at":null,"deleted_at":null}]

class GetVoucherRsp {
  GetVoucherRsp({
      List<Data>? data,}){
    _data = data;
}

  GetVoucherRsp.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
GetVoucherRsp copyWith({  List<Data>? data,
}) => GetVoucherRsp(  data: data ?? _data,
);
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// voucher_code : "GIAMGIADIENTHOAI"
/// voucher_value : "20"
/// voucher_type : "T"
/// title : "Voucher Điện thoại"
/// voucher_date_start : null
/// voucher_date_end : null
/// created_at : null
/// updated_at : null
/// deleted_at : null

class Data {
  Data({
      String? voucherCode, 
      String? voucherValue, 
      String? voucherType, 
      String? title, 
      dynamic voucherDateStart, 
      dynamic voucherDateEnd, 
      dynamic createdAt, 
      dynamic updatedAt, 
      dynamic deletedAt,}){
    _voucherCode = voucherCode;
    _voucherValue = voucherValue;
    _voucherType = voucherType;
    _title = title;
    _voucherDateStart = voucherDateStart;
    _voucherDateEnd = voucherDateEnd;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Data.fromJson(dynamic json) {
    _voucherCode = json['voucher_code'];
    _voucherValue = json['voucher_value'];
    _voucherType = json['voucher_type'];
    _title = json['title'];
    _voucherDateStart = json['voucher_date_start'];
    _voucherDateEnd = json['voucher_date_end'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  String? _voucherCode;
  String? _voucherValue;
  String? _voucherType;
  String? _title;
  dynamic _voucherDateStart;
  dynamic _voucherDateEnd;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
Data copyWith({  String? voucherCode,
  String? voucherValue,
  String? voucherType,
  String? title,
  dynamic voucherDateStart,
  dynamic voucherDateEnd,
  dynamic createdAt,
  dynamic updatedAt,
  dynamic deletedAt,
}) => Data(  voucherCode: voucherCode ?? _voucherCode,
  voucherValue: voucherValue ?? _voucherValue,
  voucherType: voucherType ?? _voucherType,
  title: title ?? _title,
  voucherDateStart: voucherDateStart ?? _voucherDateStart,
  voucherDateEnd: voucherDateEnd ?? _voucherDateEnd,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  String? get voucherCode => _voucherCode;
  String? get voucherValue => _voucherValue;
  String? get voucherType => _voucherType;
  String? get title => _title;
  dynamic get voucherDateStart => _voucherDateStart;
  dynamic get voucherDateEnd => _voucherDateEnd;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['voucher_code'] = _voucherCode;
    map['voucher_value'] = _voucherValue;
    map['voucher_type'] = _voucherType;
    map['title'] = _title;
    map['voucher_date_start'] = _voucherDateStart;
    map['voucher_date_end'] = _voucherDateEnd;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}