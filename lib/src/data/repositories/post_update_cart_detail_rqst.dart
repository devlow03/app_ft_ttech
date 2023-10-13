/// quantity : 4

class PostUpdateCartDetailRqst {
  PostUpdateCartDetailRqst({
      num? quantity,}){
    _quantity = quantity;
}

  PostUpdateCartDetailRqst.fromJson(dynamic json) {
    _quantity = json['quantity'];
  }
  num? _quantity;
PostUpdateCartDetailRqst copyWith({  num? quantity,
}) => PostUpdateCartDetailRqst(  quantity: quantity ?? _quantity,
);
  num? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = _quantity;
    return map;
  }

}