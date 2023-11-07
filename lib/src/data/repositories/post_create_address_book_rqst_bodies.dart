/// user_id : 1
/// full_name : "ABC"
/// phone : "0379086872"
/// ward_id : "1"
/// ward_name : "test"
/// district_id : 2
/// district_name : "test"
/// city_id : 3
/// city_name : "test"
/// full_address : "test"

class PostCreateAddressBookRqstBodies {
  PostCreateAddressBookRqstBodies({
      num? userId, 
      String? fullName, 
      String? phone, 
      String? wardId, 
      String? wardName, 
      num? districtId, 
      String? districtName, 
      num? cityId, 
      String? cityName, 
      String? fullAddress,}){
    _userId = userId;
    _fullName = fullName;
    _phone = phone;
    _wardId = wardId;
    _wardName = wardName;
    _districtId = districtId;
    _districtName = districtName;
    _cityId = cityId;
    _cityName = cityName;
    _fullAddress = fullAddress;
}

  PostCreateAddressBookRqstBodies.fromJson(dynamic json) {
    _userId = json['user_id'];
    _fullName = json['full_name'];
    _phone = json['phone'];
    _wardId = json['ward_id'];
    _wardName = json['ward_name'];
    _districtId = json['district_id'];
    _districtName = json['district_name'];
    _cityId = json['city_id'];
    _cityName = json['city_name'];
    _fullAddress = json['full_address'];
  }
  num? _userId;
  String? _fullName;
  String? _phone;
  String? _wardId;
  String? _wardName;
  num? _districtId;
  String? _districtName;
  num? _cityId;
  String? _cityName;
  String? _fullAddress;
PostCreateAddressBookRqstBodies copyWith({  num? userId,
  String? fullName,
  String? phone,
  String? wardId,
  String? wardName,
  num? districtId,
  String? districtName,
  num? cityId,
  String? cityName,
  String? fullAddress,
}) => PostCreateAddressBookRqstBodies(  userId: userId ?? _userId,
  fullName: fullName ?? _fullName,
  phone: phone ?? _phone,
  wardId: wardId ?? _wardId,
  wardName: wardName ?? _wardName,
  districtId: districtId ?? _districtId,
  districtName: districtName ?? _districtName,
  cityId: cityId ?? _cityId,
  cityName: cityName ?? _cityName,
  fullAddress: fullAddress ?? _fullAddress,
);
  num? get userId => _userId;
  String? get fullName => _fullName;
  String? get phone => _phone;
  String? get wardId => _wardId;
  String? get wardName => _wardName;
  num? get districtId => _districtId;
  String? get districtName => _districtName;
  num? get cityId => _cityId;
  String? get cityName => _cityName;
  String? get fullAddress => _fullAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['full_name'] = _fullName;
    map['phone'] = _phone;
    map['ward_id'] = _wardId;
    map['ward_name'] = _wardName;
    map['district_id'] = _districtId;
    map['district_name'] = _districtName;
    map['city_id'] = _cityId;
    map['city_name'] = _cityName;
    map['full_address'] = _fullAddress;
    return map;
  }

}