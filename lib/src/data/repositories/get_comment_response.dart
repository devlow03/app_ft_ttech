class GetCommentResponse {
  GetCommentResponse({
      List<Data>? data, 
      Response? response, 
      Links? links, 
      Meta? meta,}){
    _data = data;
    _response = response;
    _links = links;
    _meta = meta;
}

  GetCommentResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<Data>? _data;
  Response? _response;
  Links? _links;
  Meta? _meta;
GetCommentResponse copyWith({  List<Data>? data,
  Response? response,
  Links? links,
  Meta? meta,
}) => GetCommentResponse(  data: data ?? _data,
  response: response ?? _response,
  links: links ?? _links,
  meta: meta ?? _meta,
);
  List<Data>? get data => _data;
  Response? get response => _response;
  Links? get links => _links;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }

}

class Meta {
  Meta({
      num? currentPage, 
      num? from, 
      num? lastPage, 
      List<Links>? links, 
      String? path, 
      num? perPage, 
      num? to, 
      num? total,}){
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
}

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }
  num? _currentPage;
  num? _from;
  num? _lastPage;
  List<Links>? _links;
  String? _path;
  num? _perPage;
  num? _to;
  num? _total;
Meta copyWith({  num? currentPage,
  num? from,
  num? lastPage,
  List<Links>? links,
  String? path,
  num? perPage,
  num? to,
  num? total,
}) => Meta(  currentPage: currentPage ?? _currentPage,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  links: links ?? _links,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  to: to ?? _to,
  total: total ?? _total,
);
  num? get currentPage => _currentPage;
  num? get from => _from;
  num? get lastPage => _lastPage;
  List<Links>? get links => _links;
  String? get path => _path;
  num? get perPage => _perPage;
  num? get to => _to;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? _url,
  label: label ?? _label,
  active: active ?? _active,
);
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}



class Response {
  Response({
      String? status, 
      num? code, 
      num? count,}){
    _status = status;
    _code = code;
    _count = count;
}

  Response.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _count = json['count'];
  }
  String? _status;
  num? _code;
  num? _count;
Response copyWith({  String? status,
  num? code,
  num? count,
}) => Response(  status: status ?? _status,
  code: code ?? _code,
  count: count ?? _count,
);
  String? get status => _status;
  num? get code => _code;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['count'] = _count;
    return map;
  }

}

class Data {
  Data({
      num? id, 
      num? productId, 
      num? userId, 
      String? user, 
      String? userAvatar, 
      String? text, 
      List<String>? imageUrl, 
      num? rating, 
      dynamic child, 
      dynamic parentId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _productId = productId;
    _userId = userId;
    _user = user;
    _userAvatar = userAvatar;
    _text = text;
    _imageUrl = imageUrl;
    _rating = rating;
    _child = child;
    _parentId = parentId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _productId = json['product_id'];
    _userId = json['user_id'];
    _user = json['user'];
    _userAvatar = json['user_avatar'];
    _text = json['text'];
    _imageUrl = json['image_url'] != null ? json['image_url'].cast<String>() : [];
    _rating = json['rating'];
    _child = json['child'];
    _parentId = json['parent_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _productId;
  num? _userId;
  String? _user;
  String? _userAvatar;
  String? _text;
  List<String>? _imageUrl;
  num? _rating;
  dynamic _child;
  dynamic _parentId;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  num? productId,
  num? userId,
  String? user,
  String? userAvatar,
  String? text,
  List<String>? imageUrl,
  num? rating,
  dynamic child,
  dynamic parentId,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  productId: productId ?? _productId,
  userId: userId ?? _userId,
  user: user ?? _user,
  userAvatar: userAvatar ?? _userAvatar,
  text: text ?? _text,
  imageUrl: imageUrl ?? _imageUrl,
  rating: rating ?? _rating,
  child: child ?? _child,
  parentId: parentId ?? _parentId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get productId => _productId;
  num? get userId => _userId;
  String? get user => _user;
  String? get userAvatar => _userAvatar;
  String? get text => _text;
  List<String>? get imageUrl => _imageUrl;
  num? get rating => _rating;
  dynamic get child => _child;
  dynamic get parentId => _parentId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product_id'] = _productId;
    map['user_id'] = _userId;
    map['user'] = _user;
    map['user_avatar'] = _userAvatar;
    map['text'] = _text;
    map['image_url'] = _imageUrl;
    map['rating'] = _rating;
    map['child'] = _child;
    map['parent_id'] = _parentId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}