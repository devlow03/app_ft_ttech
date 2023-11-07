/// phone : "0776506112"
/// password : "123456789"

class PostSigninRqst {
  PostSigninRqst({
      String? phone, 
      String? password,}){
    _phone = phone;
    _password = password;
}

  PostSigninRqst.fromJson(dynamic json) {
    _phone = json['phone'];
    _password = json['password'];
  }
  String? _phone;
  String? _password;
PostSigninRqst copyWith({  String? phone,
  String? password,
}) => PostSigninRqst(  phone: phone ?? _phone,
  password: password ?? _password,
);
  String? get phone => _phone;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['password'] = _password;
    return map;
  }

}