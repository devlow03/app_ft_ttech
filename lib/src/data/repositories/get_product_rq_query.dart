/// category_id : ["6","4"]
/// product_name : ""
/// price : ["13","20"]
/// manufacturer_id : ["4","5"]
/// perPage : "10"

class GetProductRqQuery {
  GetProductRqQuery({
      List<String>? categoryId, 
      String? productName, 
      List<String>? price, 
      List<String>? manufacturerId, 
      String? perPage,}){
    _categoryId = categoryId;
    _productName = productName;
    _price = price;
    _manufacturerId = manufacturerId;
    _perPage = perPage;
}

  GetProductRqQuery.fromJson(dynamic json) {
    _categoryId = json['category_id'] != null ? json['category_id'].cast<String>() : [];
    _productName = json['product_name'];
    _price = json['price'] != null ? json['price'].cast<String>() : [];
    _manufacturerId = json['manufacturer_id'] != null ? json['manufacturer_id'].cast<String>() : [];
    _perPage = json['perPage'];
  }
  List<String>? _categoryId;
  String? _productName;
  List<String>? _price;
  List<String>? _manufacturerId;
  String? _perPage;
GetProductRqQuery copyWith({  List<String>? categoryId,
  String? productName,
  List<String>? price,
  List<String>? manufacturerId,
  String? perPage,
}) => GetProductRqQuery(  categoryId: categoryId ?? _categoryId,
  productName: productName ?? _productName,
  price: price ?? _price,
  manufacturerId: manufacturerId ?? _manufacturerId,
  perPage: perPage ?? _perPage,
);
  List<String>? get categoryId => _categoryId;
  String? get productName => _productName;
  List<String>? get price => _price;
  List<String>? get manufacturerId => _manufacturerId;
  String? get perPage => _perPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['product_name'] = _productName;
    map['price'] = _price;
    map['manufacturer_id'] = _manufacturerId;
    map['perPage'] = _perPage;
    return map;
  }

}