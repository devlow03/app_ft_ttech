class GetNotificationRsp {
  GetNotificationRsp({
      List<Data>? data, 
      Response? response, 
      Links? links, 
      Meta? meta,}){
    _data = data;
    _response = response;
    _links = links;
    _meta = meta;
}

  GetNotificationRsp.fromJson(dynamic json) {
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
GetNotificationRsp copyWith({  List<Data>? data,
  Response? response,
  Links? links,
  Meta? meta,
}) => GetNotificationRsp(  data: data ?? _data,
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
      String? first, 
      String? last, 
      dynamic prev, 
      String? next,}){
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
}

  Links.fromJson(dynamic json) {
    _first = json['first'];
    _last = json['last'];
    _prev = json['prev'];
    _next = json['next'];
  }
  String? _first;
  String? _last;
  dynamic _prev;
  String? _next;
Links copyWith({  String? first,
  String? last,
  dynamic prev,
  String? next,
}) => Links(  first: first ?? _first,
  last: last ?? _last,
  prev: prev ?? _prev,
  next: next ?? _next,
);
  String? get first => _first;
  String? get last => _last;
  dynamic get prev => _prev;
  String? get next => _next;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = _first;
    map['last'] = _last;
    map['prev'] = _prev;
    map['next'] = _next;
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
      num? userId, 
      num? orderId, 
      String? title, 
      String? content, 
      String? imageUrl, 
      String? timeElapsed,}){
    _userId = userId;
    _orderId = orderId;
    _title = title;
    _content = content;
    _imageUrl = imageUrl;
    _timeElapsed = timeElapsed;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _orderId = json['order_id'];
    _title = json['title'];
    _content = json['content'];
    _imageUrl = json['image_url'];
    _timeElapsed = json['time_elapsed'];
  }
  num? _userId;
  num? _orderId;
  String? _title;
  String? _content;
  String? _imageUrl;
  String? _timeElapsed;
Data copyWith({  num? userId,
  num? orderId,
  String? title,
  String? content,
  String? imageUrl,
  String? timeElapsed,
}) => Data(  userId: userId ?? _userId,
  orderId: orderId ?? _orderId,
  title: title ?? _title,
  content: content ?? _content,
  imageUrl: imageUrl ?? _imageUrl,
  timeElapsed: timeElapsed ?? _timeElapsed,
);
  num? get userId => _userId;
  num? get orderId => _orderId;
  String? get title => _title;
  String? get content => _content;
  String? get imageUrl => _imageUrl;
  String? get timeElapsed => _timeElapsed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['order_id'] = _orderId;
    map['title'] = _title;
    map['content'] = _content;
    map['image_url'] = _imageUrl;
    map['time_elapsed'] = _timeElapsed;
    return map;
  }

}