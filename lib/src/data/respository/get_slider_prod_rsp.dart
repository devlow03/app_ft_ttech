/// slider : [{"id_slider":1,"link_img":"https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-1-1.jpg","id":1},{"id_slider":3,"link_img":"https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-do-10.jpg","id":1},{"id_slider":4,"link_img":"https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-do-5.jpg","id":1},{"id_slider":5,"link_img":"https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-do-6.jpg","id":1},{"id_slider":6,"link_img":"https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-do-11.jpg","id":1},{"id_slider":7,"link_img":"https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-do-12.jpg","id":1},{"id_slider":8,"link_img":"https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-do-13.jpg","id":1}]

class GetSliderProdRsp {
  GetSliderProdRsp({
      List<Slider>? slider,}){
    _slider = slider;
}

  GetSliderProdRsp.fromJson(dynamic json) {
    if (json['slider'] != null) {
      _slider = [];
      json['slider'].forEach((v) {
        _slider?.add(Slider.fromJson(v));
      });
    }
  }
  List<Slider>? _slider;
GetSliderProdRsp copyWith({  List<Slider>? slider,
}) => GetSliderProdRsp(  slider: slider ?? _slider,
);
  List<Slider>? get slider => _slider;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_slider != null) {
      map['slider'] = _slider?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id_slider : 1
/// link_img : "https://cdn.tgdd.vn/Products/Images/42/235838/samsung-galaxy-s22-ultra-1-1.jpg"
/// id : 1

class Slider {
  Slider({
      num? idSlider, 
      String? linkImg, 
      num? id,}){
    _idSlider = idSlider;
    _linkImg = linkImg;
    _id = id;
}

  Slider.fromJson(dynamic json) {
    _idSlider = json['id_slider'];
    _linkImg = json['link_img'];
    _id = json['id'];
  }
  num? _idSlider;
  String? _linkImg;
  num? _id;
Slider copyWith({  num? idSlider,
  String? linkImg,
  num? id,
}) => Slider(  idSlider: idSlider ?? _idSlider,
  linkImg: linkImg ?? _linkImg,
  id: id ?? _id,
);
  num? get idSlider => _idSlider;
  String? get linkImg => _linkImg;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_slider'] = _idSlider;
    map['link_img'] = _linkImg;
    map['id'] = _id;
    return map;
  }

}