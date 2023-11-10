/// full_name : "Hua  Thien"
/// phone : "0776506113"
/// ward_id : 31177
/// ward_name : "Phường An Thới"
/// district_id : 918
/// district_name : "Quận Bình Thuỷ"
/// city_id : 92
/// city_name : "Thành phố Cần Thơ"
/// full_address : "117 Nguyen De, Phường An Thới, Quận Bình Thuỷ, Thành phố Cần Thơ"

class PutUpdateAddressBookRqst {
  PutUpdateAddressBookRqst({
      String? fullName, 
      String? phone, 
      num? wardId, 
      String? wardName, 
      num? districtId, 
      String? districtName, 
      num? cityId, 
      String? cityName, 
      String? fullAddress,}){
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

  PutUpdateAddressBookRqst.fromJson(dynamic json) {
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
  String? _fullName;
  String? _phone;
  num? _wardId;
  String? _wardName;
  num? _districtId;
  String? _districtName;
  num? _cityId;
  String? _cityName;
  String? _fullAddress;
PutUpdateAddressBookRqst copyWith({  String? fullName,
  String? phone,
  num? wardId,
  String? wardName,
  num? districtId,
  String? districtName,
  num? cityId,
  String? cityName,
  String? fullAddress,
}) => PutUpdateAddressBookRqst(  fullName: fullName ?? _fullName,
  phone: phone ?? _phone,
  wardId: wardId ?? _wardId,
  wardName: wardName ?? _wardName,
  districtId: districtId ?? _districtId,
  districtName: districtName ?? _districtName,
  cityId: cityId ?? _cityId,
  cityName: cityName ?? _cityName,
  fullAddress: fullAddress ?? _fullAddress,
);
  String? get fullName => _fullName;
  String? get phone => _phone;
  num? get wardId => _wardId;
  String? get wardName => _wardName;
  num? get districtId => _districtId;
  String? get districtName => _districtName;
  num? get cityId => _cityId;
  String? get cityName => _cityName;
  String? get fullAddress => _fullAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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