/// action : "p"

class PostCreateShippingOrder {
  PostCreateShippingOrder({
      String? action,}){
    _action = action;
}

  PostCreateShippingOrder.fromJson(dynamic json) {
    _action = json['action'];
  }
  String? _action;
PostCreateShippingOrder copyWith({  String? action,
}) => PostCreateShippingOrder(  action: action ?? _action,
);
  String? get action => _action;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = _action;
    return map;
  }

}