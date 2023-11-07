/// guest_session : "64FEA81A1036B1694410778"
/// product_id : "203"
/// quantity : "2"

class PostCartRqst {
  PostCartRqst({
      String? guestSession, 
      String? productId, 
      String? quantity,}){
    // _guestSession = guestSession;
    _productId = productId;
    _quantity = quantity;
}

  PostCartRqst.fromJson(dynamic json) {
    // _guestSession = json['guest_session'];
    _productId = json['product_id'];
    _quantity = json['quantity'];
  }
  // String? _guestSession;
  String? _productId;
  String? _quantity;
PostCartRqst copyWith({
  // String? guestSession,
  String? productId,
  String? quantity,
}) => PostCartRqst(
  // guestSession: guestSession ?? _guestSession,
  productId: productId ?? _productId,
  quantity: quantity ?? _quantity,
);
  // String? get guestSession => _guestSession;
  String? get productId => _productId;
  String? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['guest_session'] = _guestSession;
    map['product_id'] = _productId;
    map['quantity'] = _quantity;
    return map;
  }

}