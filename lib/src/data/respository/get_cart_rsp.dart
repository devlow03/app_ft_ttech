/// data : {"id":27,"user_id":null,"guest_id":"29","name":null,"phone":null,"payment_method":null,"payment_status":0,"coupon_code":null,"voucher_code":null,"street_no":null,"ward_id":null,"district_id":null,"city_id":null,"address":null,"free_item":null,"info":[{"code":"sub_total","text":"10.680.000 đ","title":"Tổng tiền hàng","value":10680000},{"code":"total","text":"10.680.000 đ","title":"Tổng thanh toán","value":10680000}],"cart_details":[{"id":74,"cart_id":27,"product_id":203,"product_name":"Nokia C21 Plus (2GB/64GB) - Chính hãng","slug":"nokia-c21-plus-2gb-64gb-chinh-hang","sku":null,"category_id":4,"category_name":"Điện thoại","short_description":null,"thumpnail_url":"https://cdn.hoanghamobile.com/i/productlist/ts/Uploads/2022/05/07/image-removebg-preview_637875529202208799.png","quantity":6,"price":1780000,"option":null,"total":10680000}]}

class GetCartRsp {
  GetCartRsp({
      Data? data,}){
    _data = data;
}

  GetCartRsp.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
GetCartRsp copyWith({  Data? data,
}) => GetCartRsp(  data: data ?? _data,
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

/// id : 27
/// user_id : null
/// guest_id : "29"
/// name : null
/// phone : null
/// payment_method : null
/// payment_status : 0
/// coupon_code : null
/// voucher_code : null
/// street_no : null
/// ward_id : null
/// district_id : null
/// city_id : null
/// address : null
/// free_item : null
/// info : [{"code":"sub_total","text":"10.680.000 đ","title":"Tổng tiền hàng","value":10680000},{"code":"total","text":"10.680.000 đ","title":"Tổng thanh toán","value":10680000}]
/// cart_details : [{"id":74,"cart_id":27,"product_id":203,"product_name":"Nokia C21 Plus (2GB/64GB) - Chính hãng","slug":"nokia-c21-plus-2gb-64gb-chinh-hang","sku":null,"category_id":4,"category_name":"Điện thoại","short_description":null,"thumpnail_url":"https://cdn.hoanghamobile.com/i/productlist/ts/Uploads/2022/05/07/image-removebg-preview_637875529202208799.png","quantity":6,"price":1780000,"option":null,"total":10680000}]

class Data {
  Data({
      num? id, 
      dynamic userId, 
      String? guestId, 
      dynamic name, 
      dynamic phone, 
      dynamic paymentMethod, 
      num? paymentStatus, 
      dynamic couponCode, 
      dynamic voucherCode, 
      dynamic streetNo, 
      dynamic wardId, 
      dynamic districtId, 
      dynamic cityId, 
      dynamic address, 
      dynamic freeItem, 
      List<Info>? info, 
      List<CartDetails>? cartDetails,}){
    _id = id;
    _userId = userId;
    _guestId = guestId;
    _name = name;
    _phone = phone;
    _paymentMethod = paymentMethod;
    _paymentStatus = paymentStatus;
    _couponCode = couponCode;
    _voucherCode = voucherCode;
    _streetNo = streetNo;
    _wardId = wardId;
    _districtId = districtId;
    _cityId = cityId;
    _address = address;
    _freeItem = freeItem;
    _info = info;
    _cartDetails = cartDetails;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _guestId = json['guest_id'];
    _name = json['name'];
    _phone = json['phone'];
    _paymentMethod = json['payment_method'];
    _paymentStatus = json['payment_status'];
    _couponCode = json['coupon_code'];
    _voucherCode = json['voucher_code'];
    _streetNo = json['street_no'];
    _wardId = json['ward_id'];
    _districtId = json['district_id'];
    _cityId = json['city_id'];
    _address = json['address'];
    _freeItem = json['free_item'];
    if (json['info'] != null) {
      _info = [];
      json['info'].forEach((v) {
        _info?.add(Info.fromJson(v));
      });
    }
    if (json['cart_details'] != null) {
      _cartDetails = [];
      json['cart_details'].forEach((v) {
        _cartDetails?.add(CartDetails.fromJson(v));
      });
    }
  }
  num? _id;
  dynamic _userId;
  String? _guestId;
  dynamic _name;
  dynamic _phone;
  dynamic _paymentMethod;
  num? _paymentStatus;
  dynamic _couponCode;
  dynamic _voucherCode;
  dynamic _streetNo;
  dynamic _wardId;
  dynamic _districtId;
  dynamic _cityId;
  dynamic _address;
  dynamic _freeItem;
  List<Info>? _info;
  List<CartDetails>? _cartDetails;
Data copyWith({  num? id,
  dynamic userId,
  String? guestId,
  dynamic name,
  dynamic phone,
  dynamic paymentMethod,
  num? paymentStatus,
  dynamic couponCode,
  dynamic voucherCode,
  dynamic streetNo,
  dynamic wardId,
  dynamic districtId,
  dynamic cityId,
  dynamic address,
  dynamic freeItem,
  List<Info>? info,
  List<CartDetails>? cartDetails,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  guestId: guestId ?? _guestId,
  name: name ?? _name,
  phone: phone ?? _phone,
  paymentMethod: paymentMethod ?? _paymentMethod,
  paymentStatus: paymentStatus ?? _paymentStatus,
  couponCode: couponCode ?? _couponCode,
  voucherCode: voucherCode ?? _voucherCode,
  streetNo: streetNo ?? _streetNo,
  wardId: wardId ?? _wardId,
  districtId: districtId ?? _districtId,
  cityId: cityId ?? _cityId,
  address: address ?? _address,
  freeItem: freeItem ?? _freeItem,
  info: info ?? _info,
  cartDetails: cartDetails ?? _cartDetails,
);
  num? get id => _id;
  dynamic get userId => _userId;
  String? get guestId => _guestId;
  dynamic get name => _name;
  dynamic get phone => _phone;
  dynamic get paymentMethod => _paymentMethod;
  num? get paymentStatus => _paymentStatus;
  dynamic get couponCode => _couponCode;
  dynamic get voucherCode => _voucherCode;
  dynamic get streetNo => _streetNo;
  dynamic get wardId => _wardId;
  dynamic get districtId => _districtId;
  dynamic get cityId => _cityId;
  dynamic get address => _address;
  dynamic get freeItem => _freeItem;
  List<Info>? get info => _info;
  List<CartDetails>? get cartDetails => _cartDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['guest_id'] = _guestId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['payment_method'] = _paymentMethod;
    map['payment_status'] = _paymentStatus;
    map['coupon_code'] = _couponCode;
    map['voucher_code'] = _voucherCode;
    map['street_no'] = _streetNo;
    map['ward_id'] = _wardId;
    map['district_id'] = _districtId;
    map['city_id'] = _cityId;
    map['address'] = _address;
    map['free_item'] = _freeItem;
    if (_info != null) {
      map['info'] = _info?.map((v) => v.toJson()).toList();
    }
    if (_cartDetails != null) {
      map['cart_details'] = _cartDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 74
/// cart_id : 27
/// product_id : 203
/// product_name : "Nokia C21 Plus (2GB/64GB) - Chính hãng"
/// slug : "nokia-c21-plus-2gb-64gb-chinh-hang"
/// sku : null
/// category_id : 4
/// category_name : "Điện thoại"
/// short_description : null
/// thumpnail_url : "https://cdn.hoanghamobile.com/i/productlist/ts/Uploads/2022/05/07/image-removebg-preview_637875529202208799.png"
/// quantity : 6
/// price : 1780000
/// option : null
/// total : 10680000

class CartDetails {
  CartDetails({
      num? id, 
      num? cartId, 
      num? productId, 
      String? productName, 
      String? slug, 
      dynamic sku, 
      num? categoryId, 
      String? categoryName, 
      dynamic shortDescription, 
      String? thumpnailUrl, 
      num? quantity, 
      num? price, 
      dynamic option, 
      num? total,}){
    _id = id;
    _cartId = cartId;
    _productId = productId;
    _productName = productName;
    _slug = slug;
    _sku = sku;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _shortDescription = shortDescription;
    _thumpnailUrl = thumpnailUrl;
    _quantity = quantity;
    _price = price;
    _option = option;
    _total = total;
}

  CartDetails.fromJson(dynamic json) {
    _id = json['id'];
    _cartId = json['cart_id'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _slug = json['slug'];
    _sku = json['sku'];
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _shortDescription = json['short_description'];
    _thumpnailUrl = json['thumpnail_url'];
    _quantity = json['quantity'];
    _price = json['price'];
    _option = json['option'];
    _total = json['total'];
  }
  num? _id;
  num? _cartId;
  num? _productId;
  String? _productName;
  String? _slug;
  dynamic _sku;
  num? _categoryId;
  String? _categoryName;
  dynamic _shortDescription;
  String? _thumpnailUrl;
  num? _quantity;
  num? _price;
  dynamic _option;
  num? _total;
CartDetails copyWith({  num? id,
  num? cartId,
  num? productId,
  String? productName,
  String? slug,
  dynamic sku,
  num? categoryId,
  String? categoryName,
  dynamic shortDescription,
  String? thumpnailUrl,
  num? quantity,
  num? price,
  dynamic option,
  num? total,
}) => CartDetails(  id: id ?? _id,
  cartId: cartId ?? _cartId,
  productId: productId ?? _productId,
  productName: productName ?? _productName,
  slug: slug ?? _slug,
  sku: sku ?? _sku,
  categoryId: categoryId ?? _categoryId,
  categoryName: categoryName ?? _categoryName,
  shortDescription: shortDescription ?? _shortDescription,
  thumpnailUrl: thumpnailUrl ?? _thumpnailUrl,
  quantity: quantity ?? _quantity,
  price: price ?? _price,
  option: option ?? _option,
  total: total ?? _total,
);
  num? get id => _id;
  num? get cartId => _cartId;
  num? get productId => _productId;
  String? get productName => _productName;
  String? get slug => _slug;
  dynamic get sku => _sku;
  num? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  dynamic get shortDescription => _shortDescription;
  String? get thumpnailUrl => _thumpnailUrl;
  num? get quantity => _quantity;
  num? get price => _price;
  dynamic get option => _option;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cart_id'] = _cartId;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['slug'] = _slug;
    map['sku'] = _sku;
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['short_description'] = _shortDescription;
    map['thumpnail_url'] = _thumpnailUrl;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['option'] = _option;
    map['total'] = _total;
    return map;
  }

}

/// code : "sub_total"
/// text : "10.680.000 đ"
/// title : "Tổng tiền hàng"
/// value : 10680000

class Info {
  Info({
      String? code, 
      String? text, 
      String? title, 
      num? value,}){
    _code = code;
    _text = text;
    _title = title;
    _value = value;
}

  Info.fromJson(dynamic json) {
    _code = json['code'];
    _text = json['text'];
    _title = json['title'];
    _value = json['value'];
  }
  String? _code;
  String? _text;
  String? _title;
  num? _value;
Info copyWith({  String? code,
  String? text,
  String? title,
  num? value,
}) => Info(  code: code ?? _code,
  text: text ?? _text,
  title: title ?? _title,
  value: value ?? _value,
);
  String? get code => _code;
  String? get text => _text;
  String? get title => _title;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['text'] = _text;
    map['title'] = _title;
    map['value'] = _value;
    return map;
  }

}