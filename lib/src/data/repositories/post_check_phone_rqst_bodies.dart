/// phone : "0776506112"

class PostCheckPhoneRqstBodies {
  PostCheckPhoneRqstBodies({
      String? phone,}){
    _phone = phone;
}

  PostCheckPhoneRqstBodies.fromJson(dynamic json) {
    _phone = json['phone'];
  }
  String? _phone;
PostCheckPhoneRqstBodies copyWith({  String? phone,
}) => PostCheckPhoneRqstBodies(  phone: phone ?? _phone,
);
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    return map;
  }

}