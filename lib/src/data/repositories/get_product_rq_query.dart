class GetProductRqQuery {
  GetProductRqQuery({
      List<String>? categoryId, 
      String? productName, 
      List<String>? price, 
      List<String>? manufacturerId, 
      bool? latest, 
      String? views, 
      String? arrangePrice, 
      int? averageRating, 
      String? perPage,}){
    _categoryId = categoryId;
    _productName = productName;
    _price = price;
    _manufacturerId = manufacturerId;
    _latest = latest;
    _views = views;
    _arrangePrice = arrangePrice;
    _averageRating = averageRating;
    _perPage = perPage;
}

  GetProductRqQuery.fromJson(dynamic json) {
    _categoryId = json['category_id'] != null ? json['category_id'].cast<String>() : [];
    _productName = json['product_name'];
    _price = json['price'] != null ? json['price'].cast<String>() : [];
    _manufacturerId = json['manufacturer_id'] != null ? json['manufacturer_id'].cast<String>() : [];
    _latest = json['latest'];
    _views = json['views'];
    _arrangePrice = json['arrange_price'];
    _averageRating = json['average_rating'];
    _perPage = json['perPage'];
  }
  List<String>? _categoryId;
  String? _productName;
  List<String>? _price;
  List<String>? _manufacturerId;
  bool? _latest;
  String? _views;
  String? _arrangePrice;
  int? _averageRating;
  String? _perPage;
GetProductRqQuery copyWith({  List<String>? categoryId,
  String? productName,
  List<String>? price,
  List<String>? manufacturerId,
  bool? latest,
  String? views,
  String? arrangePrice,
  int? averageRating,
  String? perPage,
}) => GetProductRqQuery(  categoryId: categoryId ?? _categoryId,
  productName: productName ?? _productName,
  price: price ?? _price,
  manufacturerId: manufacturerId ?? _manufacturerId,
  latest: latest ?? _latest,
  views: views ?? _views,
  arrangePrice: arrangePrice ?? _arrangePrice,
  averageRating: averageRating ?? _averageRating,
  perPage: perPage ?? _perPage,
);
  List<String>? get categoryId => _categoryId;
  String? get productName => _productName;
  List<String>? get price => _price;
  List<String>? get manufacturerId => _manufacturerId;
  bool? get latest => _latest;
  String? get views => _views;
  String? get arrangePrice => _arrangePrice;
  int? get averageRating => _averageRating;
  String? get perPage => _perPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['product_name'] = _productName;
    map['price'] = _price;
    map['manufacturer_id'] = _manufacturerId;
    map['latest'] = _latest;
    map['views'] = _views;
    map['arrange_price'] = _arrangePrice;
    map['average_rating'] = _averageRating;
    map['perPage'] = _perPage;
    return map;
  }

}