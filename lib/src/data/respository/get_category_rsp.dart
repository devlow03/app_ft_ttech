/// category : [{"id_category":1,"name_type":"Điện thoại","image":"https://smartstore.khanhnhat.top/images/category/phone.png"},{"id_category":2,"name_type":"Laptop","image":"https://smartstore.khanhnhat.top/images/category/laptop.png"},{"id_category":3,"name_type":"Tablet","image":"https://smartstore.khanhnhat.top/images/category/tablet.webp"},{"id_category":4,"name_type":"Đồng hồ","image":"https://smartstore.khanhnhat.top/images/category/smartwatch.webp"},{"id_category":5,"name_type":"Phụ kiện","image":"https://smartstore.khanhnhat.top/images/category/accessories.webp"},{"id_category":6,"name_type":"Màn hình","image":"https://smartstore.khanhnhat.top/images/category/monitor.png"},{"id_category":7,"name_type":"Bàn phím","image":"https://smartstore.khanhnhat.top/images/category/banphim.png"},{"id_category":8,"name_type":"Tivi","image":"https://smartstore.khanhnhat.top/images/category/tv.png"}]

class GetCategoryRsp {
  GetCategoryRsp({
      List<Category>? category,}){
    _category = category;
}

  GetCategoryRsp.fromJson(dynamic json) {
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
  }
  List<Category>? _category;
GetCategoryRsp copyWith({  List<Category>? category,
}) => GetCategoryRsp(  category: category ?? _category,
);
  List<Category>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id_category : 1
/// name_type : "Điện thoại"
/// image : "https://smartstore.khanhnhat.top/images/category/phone.png"

class Category {
  Category({
      num? idCategory, 
      String? nameType, 
      String? image,}){
    _idCategory = idCategory;
    _nameType = nameType;
    _image = image;
}

  Category.fromJson(dynamic json) {
    _idCategory = json['id_category'];
    _nameType = json['name_type'];
    _image = json['image'];
  }
  num? _idCategory;
  String? _nameType;
  String? _image;
Category copyWith({  num? idCategory,
  String? nameType,
  String? image,
}) => Category(  idCategory: idCategory ?? _idCategory,
  nameType: nameType ?? _nameType,
  image: image ?? _image,
);
  num? get idCategory => _idCategory;
  String? get nameType => _nameType;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_category'] = _idCategory;
    map['name_type'] = _nameType;
    map['image'] = _image;
    return map;
  }

}