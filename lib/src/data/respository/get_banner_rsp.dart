/// message : "success"
/// data : [{"id_banner":23,"url_bannerImg":"https://cdn.hoanghamobile.com/i/home/Uploads/2023/07/03/s20-fe-1200x382.png"},{"id_banner":26,"url_bannerImg":"https://images.fpt.shop/unsafe/fit-in/800x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/4/638240654776538068_F-H1_800x300.png"},{"id_banner":27,"url_bannerImg":"https://images.fpt.shop/unsafe/fit-in/800x300/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2023/7/1/638237691192351614_F-H1_800x300.png"},{"id_banner":30,"url_bannerImg":"https://cdn.hoanghamobile.com/i/home/Uploads/2023/08/11/reno-10-1200x375.jpg"},{"id_banner":31,"url_bannerImg":"https://cdn.hoanghamobile.com/i/home/Uploads/2023/08/13/1200x375-xiaomitv-130823.png"},{"id_banner":32,"url_bannerImg":"https://cdn.hoanghamobile.com/i/home/Uploads/2023/08/10/web-tab9-1200.png"},{"id_banner":33,"url_bannerImg":"https://cdn.hoanghamobile.com/i/home/Uploads/2023/08/04/1200x375-infinixhot30i-0130823.jpg"}]

class GetBannerRsp {
  GetBannerRsp({
      String? message, 
      List<Data>? data,}){
    _message = message;
    _data = data;
}

  GetBannerRsp.fromJson(dynamic json) {
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _message;
  List<Data>? _data;
GetBannerRsp copyWith({  String? message,
  List<Data>? data,
}) => GetBannerRsp(  message: message ?? _message,
  data: data ?? _data,
);
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id_banner : 23
/// url_bannerImg : "https://cdn.hoanghamobile.com/i/home/Uploads/2023/07/03/s20-fe-1200x382.png"

class Data {
  Data({
      num? idBanner, 
      String? urlBannerImg,}){
    _idBanner = idBanner;
    _urlBannerImg = urlBannerImg;
}

  Data.fromJson(dynamic json) {
    _idBanner = json['id_banner'];
    _urlBannerImg = json['url_bannerImg'];
  }
  num? _idBanner;
  String? _urlBannerImg;
Data copyWith({  num? idBanner,
  String? urlBannerImg,
}) => Data(  idBanner: idBanner ?? _idBanner,
  urlBannerImg: urlBannerImg ?? _urlBannerImg,
);
  num? get idBanner => _idBanner;
  String? get urlBannerImg => _urlBannerImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_banner'] = _idBanner;
    map['url_bannerImg'] = _urlBannerImg;
    return map;
  }

}