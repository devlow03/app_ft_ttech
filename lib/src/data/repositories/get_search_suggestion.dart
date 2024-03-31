class GetSearchSuggestion {
  GetSearchSuggestion({
      Amplitude? amplitude, 
      List<Data>? data,}){
    _amplitude = amplitude;
    _data = data;
}

  GetSearchSuggestion.fromJson(dynamic json) {
    _amplitude = json['amplitude'] != null ? Amplitude.fromJson(json['amplitude']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  Amplitude? _amplitude;
  List<Data>? _data;
GetSearchSuggestion copyWith({  Amplitude? amplitude,
  List<Data>? data,
}) => GetSearchSuggestion(  amplitude: amplitude ?? _amplitude,
  data: data ?? _data,
);
  Amplitude? get amplitude => _amplitude;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_amplitude != null) {
      map['amplitude'] = _amplitude?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      String? keyword, 
      String? type, 
      String? url,}){
    _keyword = keyword;
    _type = type;
    _url = url;
}

  Data.fromJson(dynamic json) {
    _keyword = json['keyword'];
    _type = json['type'];
    _url = json['url'];
  }
  String? _keyword;
  String? _type;
  String? _url;
Data copyWith({  String? keyword,
  String? type,
  String? url,
}) => Data(  keyword: keyword ?? _keyword,
  type: type ?? _type,
  url: url ?? _url,
);
  String? get keyword => _keyword;
  String? get type => _type;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['keyword'] = _keyword;
    map['type'] = _type;
    map['url'] = _url;
    return map;
  }

}

class Amplitude {
  Amplitude({
      String? suggestionState,}){
    _suggestionState = suggestionState;
}

  Amplitude.fromJson(dynamic json) {
    _suggestionState = json['suggestion_state'];
  }
  String? _suggestionState;
Amplitude copyWith({  String? suggestionState,
}) => Amplitude(  suggestionState: suggestionState ?? _suggestionState,
);
  String? get suggestionState => _suggestionState;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['suggestion_state'] = _suggestionState;
    return map;
  }

}