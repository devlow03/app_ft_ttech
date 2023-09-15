/// data : "64FF13BAE942B1694438330"

class GetSessionRsp {
  GetSessionRsp({
      String? data,}){
    _data = data;
}

  GetSessionRsp.fromJson(dynamic json) {
    if (json['data'] is String) {
      _data = json['data'];
    } else {
      // Xử lý khi 'data' không phải là chuỗi
      // Ví dụ: Gán giá trị mặc định hoặc xử lý khác tùy thuộc vào logic ứng dụng của bạn
    }
  }

  String? _data;
GetSessionRsp copyWith({  String? data,
}) => GetSessionRsp(  data: data ?? _data,
);
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    return map;
  }

}