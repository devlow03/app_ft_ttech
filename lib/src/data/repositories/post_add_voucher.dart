/// cart_id : 30
/// voucher_code : "GiAMGIADIENTHOAI"

class PostAddVoucher {
  PostAddVoucher({
      int? cartId, 
      String? voucherCode,}){
    _cartId = cartId;
    _voucherCode = voucherCode;
}

  PostAddVoucher.fromJson(dynamic json) {
    _cartId = json['cart_id'];
    _voucherCode = json['voucher_code'];
  }
  int? _cartId;
  String? _voucherCode;
PostAddVoucher copyWith({  int? cartId,
  String? voucherCode,
}) => PostAddVoucher(  cartId: cartId ?? _cartId,
  voucherCode: voucherCode ?? _voucherCode,
);
  int? get cartId => _cartId;
  String? get voucherCode => _voucherCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_id'] = _cartId;
    map['voucher_code'] = _voucherCode;
    return map;
  }

}