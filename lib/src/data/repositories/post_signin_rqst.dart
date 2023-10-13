/// email : "admin@gmail.com"
/// password : "12345678"

class PostSigninRqst {
  PostSigninRqst({
      String? email, 
      String? password,}){
    _email = email;
    _password = password;
}

  PostSigninRqst.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
  }
  String? _email;
  String? _password;
PostSigninRqst copyWith({  String? email,
  String? password,
}) => PostSigninRqst(  email: email ?? _email,
  password: password ?? _password,
);
  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }

}