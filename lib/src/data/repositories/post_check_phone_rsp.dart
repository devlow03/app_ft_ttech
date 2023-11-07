/// data : {"status":true}

class PostCheckPhoneRsp {
  PostCheckPhoneRsp({
      Data? data,}){
    _data = data;
}

  PostCheckPhoneRsp.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
PostCheckPhoneRsp copyWith({  Data? data,
}) => PostCheckPhoneRsp(  data: data ?? _data,
);
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// status : true

class Data {
  Data({
      bool? status,}){
    _status = status;
}

  Data.fromJson(dynamic json) {
    _status = json['status'];
  }
  bool? _status;
Data copyWith({  bool? status,
}) => Data(  status: status ?? _status,
);
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    return map;
  }

}