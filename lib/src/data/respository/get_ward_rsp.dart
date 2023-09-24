/// status : "Success"
/// message : ""
/// results : [{"code":"27037","name":"Phường Hiệp Tân","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27034","name":"Phường Hòa Thạnh","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27028","name":"Phường Phú Thạnh","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27025","name":"Phường Phú Thọ Hòa","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27031","name":"Phường Phú Trung","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27016","name":"Phường Sơn Kỳ","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27019","name":"Phường Tân Quý","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27010","name":"Phường Tân Sơn Nhì","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27022","name":"Phường Tân Thành","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27040","name":"Phường Tân Thới Hòa","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"},{"code":"27013","name":"Phường Tây Thạnh","district":"Quận Tân Phú","province":"Thành phố Hồ Chí Minh"}]

class GetWardRsp {
  GetWardRsp({
      String? status,
      String? message,
      List<Results>? results,}){
    _status = status;
    _message = message;
    _results = results;
}

  GetWardRsp.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Results>? _results;
GetWardRsp copyWith({  String? status,
  String? message,
  List<Results>? results,
}) => GetWardRsp(  status: status ?? _status,
  message: message ?? _message,
  results: results ?? _results,
);
  String? get status => _status;
  String? get message => _message;
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// code : "27037"
/// name : "Phường Hiệp Tân"
/// district : "Quận Tân Phú"
/// province : "Thành phố Hồ Chí Minh"

class Results {
  Results({
      String? code,
      String? name,
      String? district,
      String? province,}){
    _code = code;
    _name = name;
    _district = district;
    _province = province;
}

  Results.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
    _district = json['district'];
    _province = json['province'];
  }
  String? _code;
  String? _name;
  String? _district;
  String? _province;
Results copyWith({  String? code,
  String? name,
  String? district,
  String? province,
}) => Results(  code: code ?? _code,
  name: name ?? _name,
  district: district ?? _district,
  province: province ?? _province,
);
  String? get code => _code;
  String? get name => _name;
  String? get district => _district;
  String? get province => _province;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    map['district'] = _district;
    map['province'] = _province;
    return map;
  }

}