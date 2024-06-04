class PostCreateShippingOrderRsp {
  PostCreateShippingOrderRsp({
      Data? data,}){
    _data = data;
}

  PostCreateShippingOrderRsp.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
PostCreateShippingOrderRsp copyWith({  Data? data,
}) => PostCreateShippingOrderRsp(  data: data ?? _data,
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

class Data {
  Data({
      bool? success, 
      String? message, 
      Order? order, 
      String? warningMessage, 
      num? id, 
      int? totalFee,}){
    _success = success;
    _message = message;
    _order = order;
    _warningMessage = warningMessage;
    _id = id;
    _totalFee = totalFee;
}

  Data.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _order = json['order'] != null ? Order.fromJson(json['order']) : null;
    _warningMessage = json['warning_message'];
    _id = json['id'];
    _totalFee = json['total_fee'];
  }
  bool? _success;
  String? _message;
  Order? _order;
  String? _warningMessage;
  num? _id;
  int? _totalFee;
Data copyWith({  bool? success,
  String? message,
  Order? order,
  String? warningMessage,
  num? id,
  int? totalFee,
}) => Data(  success: success ?? _success,
  message: message ?? _message,
  order: order ?? _order,
  warningMessage: warningMessage ?? _warningMessage,
  id: id ?? _id,
  totalFee: totalFee ?? _totalFee,
);
  bool? get success => _success;
  String? get message => _message;
  Order? get order => _order;
  String? get warningMessage => _warningMessage;
  num? get id => _id;
  int? get totalFee => _totalFee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_order != null) {
      map['order'] = _order?.toJson();
    }
    map['warning_message'] = _warningMessage;
    map['id'] = _id;
    map['total_fee'] = _totalFee;
    return map;
  }

}

class Order {
  Order({
      String? partnerId, 
      String? label, 
      num? area, 
      num? fee, 
      num? insuranceFee, 
      String? estimatedPickTime, 
      String? estimatedDeliverTime, 
      List<dynamic>? products, 
      num? statusId, 
      num? trackingId, 
      String? sortingCode, 
      String? dateToDelayPick, 
      num? pickWorkShift, 
      String? dateToDelayDeliver, 
      num? deliverWorkShift, 
      num? pkgDraftId, 
      num? isXfast,}){
    _partnerId = partnerId;
    _label = label;
    _area = area;
    _fee = fee;
    _insuranceFee = insuranceFee;
    _estimatedPickTime = estimatedPickTime;
    _estimatedDeliverTime = estimatedDeliverTime;
    _products = products;
    _statusId = statusId;
    _trackingId = trackingId;
    _sortingCode = sortingCode;
    _dateToDelayPick = dateToDelayPick;
    _pickWorkShift = pickWorkShift;
    _dateToDelayDeliver = dateToDelayDeliver;
    _deliverWorkShift = deliverWorkShift;
    _pkgDraftId = pkgDraftId;
    _isXfast = isXfast;
}

  Order.fromJson(dynamic json) {
    _partnerId = json['partner_id'];
    _label = json['label'];
    _area = json['area'];
    _fee = json['fee'];
    _insuranceFee = json['insurance_fee'];
    _estimatedPickTime = json['estimated_pick_time'];
    _estimatedDeliverTime = json['estimated_deliver_time'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(v);
      });
    }
    _statusId = json['status_id'];
    _trackingId = json['tracking_id'];
    _sortingCode = json['sorting_code'];
    _dateToDelayPick = json['date_to_delay_pick'];
    _pickWorkShift = json['pick_work_shift'];
    _dateToDelayDeliver = json['date_to_delay_deliver'];
    _deliverWorkShift = json['deliver_work_shift'];
    _pkgDraftId = json['pkg_draft_id'];
    _isXfast = json['is_xfast'];
  }
  String? _partnerId;
  String? _label;
  num? _area;
  num? _fee;
  num? _insuranceFee;
  String? _estimatedPickTime;
  String? _estimatedDeliverTime;
  List<dynamic>? _products;
  num? _statusId;
  num? _trackingId;
  String? _sortingCode;
  String? _dateToDelayPick;
  num? _pickWorkShift;
  String? _dateToDelayDeliver;
  num? _deliverWorkShift;
  num? _pkgDraftId;
  num? _isXfast;
Order copyWith({  String? partnerId,
  String? label,
  num? area,
  num? fee,
  num? insuranceFee,
  String? estimatedPickTime,
  String? estimatedDeliverTime,
  List<dynamic>? products,
  num? statusId,
  num? trackingId,
  String? sortingCode,
  String? dateToDelayPick,
  num? pickWorkShift,
  String? dateToDelayDeliver,
  num? deliverWorkShift,
  num? pkgDraftId,
  num? isXfast,
}) => Order(  partnerId: partnerId ?? _partnerId,
  label: label ?? _label,
  area: area ?? _area,
  fee: fee ?? _fee,
  insuranceFee: insuranceFee ?? _insuranceFee,
  estimatedPickTime: estimatedPickTime ?? _estimatedPickTime,
  estimatedDeliverTime: estimatedDeliverTime ?? _estimatedDeliverTime,
  products: products ?? _products,
  statusId: statusId ?? _statusId,
  trackingId: trackingId ?? _trackingId,
  sortingCode: sortingCode ?? _sortingCode,
  dateToDelayPick: dateToDelayPick ?? _dateToDelayPick,
  pickWorkShift: pickWorkShift ?? _pickWorkShift,
  dateToDelayDeliver: dateToDelayDeliver ?? _dateToDelayDeliver,
  deliverWorkShift: deliverWorkShift ?? _deliverWorkShift,
  pkgDraftId: pkgDraftId ?? _pkgDraftId,
  isXfast: isXfast ?? _isXfast,
);
  String? get partnerId => _partnerId;
  String? get label => _label;
  num? get area => _area;
  num? get fee => _fee;
  num? get insuranceFee => _insuranceFee;
  String? get estimatedPickTime => _estimatedPickTime;
  String? get estimatedDeliverTime => _estimatedDeliverTime;
  List<dynamic>? get products => _products;
  num? get statusId => _statusId;
  num? get trackingId => _trackingId;
  String? get sortingCode => _sortingCode;
  String? get dateToDelayPick => _dateToDelayPick;
  num? get pickWorkShift => _pickWorkShift;
  String? get dateToDelayDeliver => _dateToDelayDeliver;
  num? get deliverWorkShift => _deliverWorkShift;
  num? get pkgDraftId => _pkgDraftId;
  num? get isXfast => _isXfast;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['partner_id'] = _partnerId;
    map['label'] = _label;
    map['area'] = _area;
    map['fee'] = _fee;
    map['insurance_fee'] = _insuranceFee;
    map['estimated_pick_time'] = _estimatedPickTime;
    map['estimated_deliver_time'] = _estimatedDeliverTime;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['status_id'] = _statusId;
    map['tracking_id'] = _trackingId;
    map['sorting_code'] = _sortingCode;
    map['date_to_delay_pick'] = _dateToDelayPick;
    map['pick_work_shift'] = _pickWorkShift;
    map['date_to_delay_deliver'] = _dateToDelayDeliver;
    map['deliver_work_shift'] = _deliverWorkShift;
    map['pkg_draft_id'] = _pkgDraftId;
    map['is_xfast'] = _isXfast;
    return map;
  }

}