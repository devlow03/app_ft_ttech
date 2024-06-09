/// phone : "0776506112"
/// password : "123456789"

class PostSigninRqst {
  PostSigninRqst({
      String? phone, 
      String? password,
      String? deviceId
    }){
    _phone = phone;
    _password = password;
    _deviceId = deviceId;
}

  PostSigninRqst.fromJson(dynamic json) {
    _phone = json['phone'];
    _password = json['password'];
    _deviceId = json['device_id'];
  }
  String? _phone;
  String? _password;
  String? _deviceId;
PostSigninRqst copyWith({  String? phone,
  String? password,
}) => PostSigninRqst(  phone: phone ?? _phone,
  password: password ?? _password,
  deviceId: deviceId ?? _deviceId
);
  String? get phone => _phone;
  String? get password => _password;
  String? get deviceId =>_deviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['password'] = _password;
    map ['device_id'] = _deviceId;
    return map;
  }

}