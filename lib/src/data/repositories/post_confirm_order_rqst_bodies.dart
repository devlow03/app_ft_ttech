/// cart_id : 36
/// shipping_company_id : "1"
/// billing_address : "149 Nguyễn Đệ, Phường An Hòa, Quận Ninh Kiều, Cần Thơ"
/// payment_uid : "1"

class PostConfirmOrderRqstBodies {
  PostConfirmOrderRqstBodies({
      num? cartId, 
      String? shippingCompanyId, 
      String? billingAddress, 
      String? paymentUid,}){
    _cartId = cartId;
    _shippingCompanyId = shippingCompanyId;
    _billingAddress = billingAddress;
    _paymentUid = paymentUid;
}

  PostConfirmOrderRqstBodies.fromJson(dynamic json) {
    _cartId = json['cart_id'];
    _shippingCompanyId = json['shipping_company_id'];
    _billingAddress = json['billing_address'];
    _paymentUid = json['payment_uid'];
  }
  num? _cartId;
  String? _shippingCompanyId;
  String? _billingAddress;
  String? _paymentUid;
PostConfirmOrderRqstBodies copyWith({  num? cartId,
  String? shippingCompanyId,
  String? billingAddress,
  String? paymentUid,
}) => PostConfirmOrderRqstBodies(  cartId: cartId ?? _cartId,
  shippingCompanyId: shippingCompanyId ?? _shippingCompanyId,
  billingAddress: billingAddress ?? _billingAddress,
  paymentUid: paymentUid ?? _paymentUid,
);
  num? get cartId => _cartId;
  String? get shippingCompanyId => _shippingCompanyId;
  String? get billingAddress => _billingAddress;
  String? get paymentUid => _paymentUid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_id'] = _cartId;
    map['shipping_company_id'] = _shippingCompanyId;
    map['billing_address'] = _billingAddress;
    map['payment_uid'] = _paymentUid;
    return map;
  }

}