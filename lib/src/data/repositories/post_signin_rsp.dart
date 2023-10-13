/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3RtYXJ0LnR1YW50aGFuaGRldi5pZC52bi9hdXRoL2xvZ2luIiwiaWF0IjoxNjk1OTcwMzY5LCJleHAiOjE3Mjc1MDYzNjksIm5iZiI6MTY5NTk3MDM2OSwianRpIjoibFp2UlM4Q1BhME1RYTQ2eiIsInN1YiI6IjEiLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.6HftYy8oi7YC4UynwRbxjXq_qX2SN8EOUCBQpYyRCJI"

class PostSigninRsp {
  PostSigninRsp({
      String? token,}){
    _token = token;
}

  PostSigninRsp.fromJson(dynamic json) {
    _token = json['token'];
  }
  String? _token;
PostSigninRsp copyWith({  String? token,
}) => PostSigninRsp(  token: token ?? _token,
);
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    return map;
  }

}