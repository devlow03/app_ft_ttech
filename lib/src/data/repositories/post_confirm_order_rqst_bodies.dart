/// cart_id : 36
/// shipping_company_id : "1"
/// billing_address : "149 Nguyễn Đệ, Phường An Hòa, Quận Ninh Kiều, Cần Thơ"
/// payment : "1"

class PostConfirmOrderRqstBodies {
  PostConfirmOrderRqstBodies({
      num? cartId, 
      String? shippingCompanyId, 
      String? billingAddress, 
      String? payment,}){
    _cartId = cartId;
    _shippingCompanyId = shippingCompanyId;
    _billingAddress = billingAddress;
    _payment = payment;
}

  PostConfirmOrderRqstBodies.fromJson(dynamic json) {
    _cartId = json['cart_id'];
    _shippingCompanyId = json['shipping_company_id'];
    _billingAddress = json['billing_address'];
    _payment = json['payment'];
  }
  num? _cartId;
  String? _shippingCompanyId;
  String? _billingAddress;
  String? _payment;
PostConfirmOrderRqstBodies copyWith({  num? cartId,
  String? shippingCompanyId,
  String? billingAddress,
  String? payment,
}) => PostConfirmOrderRqstBodies(  cartId: cartId ?? _cartId,
  shippingCompanyId: shippingCompanyId ?? _shippingCompanyId,
  billingAddress: billingAddress ?? _billingAddress,
  payment: payment ?? _payment,
);
  num? get cartId => _cartId;
  String? get shippingCompanyId => _shippingCompanyId;
  String? get billingAddress => _billingAddress;
  String? get payment => _payment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_id'] = _cartId;
    map['shipping_company_id'] = _shippingCompanyId;
    map['billing_address'] = _billingAddress;
    map['payment'] = _payment;
    return map;
  }

}