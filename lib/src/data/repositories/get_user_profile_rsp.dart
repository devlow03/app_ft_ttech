/// data : {"id":9,"code":"0776506114","phone":"0776506114","email":null,"username":"0776506114","first_name":"Quang","last_name":"think","full_name":"Quang think","address":null,"birthday":null,"genre":"O","genre_name":"Other","avatar":null,"id_number":null,"is_active":1,"role_id":2,"created_at":"07/11/2023 21:59","updated_at":"07/11/2023 21:59","created_by":null,"updated_by":null}

class GetUserProfileRsp {
  GetUserProfileRsp({
      Data? data,}){
    _data = data;
}

  GetUserProfileRsp.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
GetUserProfileRsp copyWith({  Data? data,
}) => GetUserProfileRsp(  data: data ?? _data,
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

/// id : 9
/// code : "0776506114"
/// phone : "0776506114"
/// email : null
/// username : "0776506114"
/// first_name : "Quang"
/// last_name : "think"
/// full_name : "Quang think"
/// address : null
/// birthday : null
/// genre : "O"
/// genre_name : "Other"
/// avatar : null
/// id_number : null
/// is_active : 1
/// role_id : 2
/// created_at : "07/11/2023 21:59"
/// updated_at : "07/11/2023 21:59"
/// created_by : null
/// updated_by : null

class Data {
  Data({
      num? id, 
      String? code, 
      String? phone, 
      dynamic email, 
      String? username, 
      String? firstName, 
      String? lastName, 
      String? fullName, 
      dynamic address, 
      dynamic birthday, 
      String? genre, 
      String? genreName, 
      dynamic avatar, 
      dynamic idNumber, 
      num? isActive, 
      num? roleId, 
      String? createdAt, 
      String? updatedAt, 
      dynamic createdBy, 
      dynamic updatedBy,}){
    _id = id;
    _code = code;
    _phone = phone;
    _email = email;
    _username = username;
    _firstName = firstName;
    _lastName = lastName;
    _fullName = fullName;
    _address = address;
    _birthday = birthday;
    _genre = genre;
    _genreName = genreName;
    _avatar = avatar;
    _idNumber = idNumber;
    _isActive = isActive;
    _roleId = roleId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _phone = json['phone'];
    _email = json['email'];
    _username = json['username'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _fullName = json['full_name'];
    _address = json['address'];
    _birthday = json['birthday'];
    _genre = json['genre'];
    _genreName = json['genre_name'];
    _avatar = json['avatar'];
    _idNumber = json['id_number'];
    _isActive = json['is_active'];
    _roleId = json['role_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
  }
  num? _id;
  String? _code;
  String? _phone;
  dynamic _email;
  String? _username;
  String? _firstName;
  String? _lastName;
  String? _fullName;
  dynamic _address;
  dynamic _birthday;
  String? _genre;
  String? _genreName;
  dynamic _avatar;
  dynamic _idNumber;
  num? _isActive;
  num? _roleId;
  String? _createdAt;
  String? _updatedAt;
  dynamic _createdBy;
  dynamic _updatedBy;
Data copyWith({  num? id,
  String? code,
  String? phone,
  dynamic email,
  String? username,
  String? firstName,
  String? lastName,
  String? fullName,
  dynamic address,
  dynamic birthday,
  String? genre,
  String? genreName,
  dynamic avatar,
  dynamic idNumber,
  num? isActive,
  num? roleId,
  String? createdAt,
  String? updatedAt,
  dynamic createdBy,
  dynamic updatedBy,
}) => Data(  id: id ?? _id,
  code: code ?? _code,
  phone: phone ?? _phone,
  email: email ?? _email,
  username: username ?? _username,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  fullName: fullName ?? _fullName,
  address: address ?? _address,
  birthday: birthday ?? _birthday,
  genre: genre ?? _genre,
  genreName: genreName ?? _genreName,
  avatar: avatar ?? _avatar,
  idNumber: idNumber ?? _idNumber,
  isActive: isActive ?? _isActive,
  roleId: roleId ?? _roleId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
);
  num? get id => _id;
  String? get code => _code;
  String? get phone => _phone;
  dynamic get email => _email;
  String? get username => _username;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get fullName => _fullName;
  dynamic get address => _address;
  dynamic get birthday => _birthday;
  String? get genre => _genre;
  String? get genreName => _genreName;
  dynamic get avatar => _avatar;
  dynamic get idNumber => _idNumber;
  num? get isActive => _isActive;
  num? get roleId => _roleId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['phone'] = _phone;
    map['email'] = _email;
    map['username'] = _username;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['full_name'] = _fullName;
    map['address'] = _address;
    map['birthday'] = _birthday;
    map['genre'] = _genre;
    map['genre_name'] = _genreName;
    map['avatar'] = _avatar;
    map['id_number'] = _idNumber;
    map['is_active'] = _isActive;
    map['role_id'] = _roleId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    return map;
  }

}