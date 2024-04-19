class PostUploadFileRsp {
  PostUploadFileRsp({
      String? name, 
      String? bucket, 
      String? generation, 
      String? metageneration, 
      String? contentType, 
      String? timeCreated, 
      String? updated, 
      String? storageClass, 
      String? size, 
      String? md5Hash, 
      String? contentEncoding, 
      String? contentDisposition, 
      String? crc32c, 
      String? etag, 
      String? downloadTokens,}){
    _name = name;
    _bucket = bucket;
    _generation = generation;
    _metageneration = metageneration;
    _contentType = contentType;
    _timeCreated = timeCreated;
    _updated = updated;
    _storageClass = storageClass;
    _size = size;
    _md5Hash = md5Hash;
    _contentEncoding = contentEncoding;
    _contentDisposition = contentDisposition;
    _crc32c = crc32c;
    _etag = etag;
    _downloadTokens = downloadTokens;
}

  PostUploadFileRsp.fromJson(dynamic json) {
    _name = json['name'];
    _bucket = json['bucket'];
    _generation = json['generation'];
    _metageneration = json['metageneration'];
    _contentType = json['contentType'];
    _timeCreated = json['timeCreated'];
    _updated = json['updated'];
    _storageClass = json['storageClass'];
    _size = json['size'];
    _md5Hash = json['md5Hash'];
    _contentEncoding = json['contentEncoding'];
    _contentDisposition = json['contentDisposition'];
    _crc32c = json['crc32c'];
    _etag = json['etag'];
    _downloadTokens = json['downloadTokens'];
  }
  String? _name;
  String? _bucket;
  String? _generation;
  String? _metageneration;
  String? _contentType;
  String? _timeCreated;
  String? _updated;
  String? _storageClass;
  String? _size;
  String? _md5Hash;
  String? _contentEncoding;
  String? _contentDisposition;
  String? _crc32c;
  String? _etag;
  String? _downloadTokens;
PostUploadFileRsp copyWith({  String? name,
  String? bucket,
  String? generation,
  String? metageneration,
  String? contentType,
  String? timeCreated,
  String? updated,
  String? storageClass,
  String? size,
  String? md5Hash,
  String? contentEncoding,
  String? contentDisposition,
  String? crc32c,
  String? etag,
  String? downloadTokens,
}) => PostUploadFileRsp(  name: name ?? _name,
  bucket: bucket ?? _bucket,
  generation: generation ?? _generation,
  metageneration: metageneration ?? _metageneration,
  contentType: contentType ?? _contentType,
  timeCreated: timeCreated ?? _timeCreated,
  updated: updated ?? _updated,
  storageClass: storageClass ?? _storageClass,
  size: size ?? _size,
  md5Hash: md5Hash ?? _md5Hash,
  contentEncoding: contentEncoding ?? _contentEncoding,
  contentDisposition: contentDisposition ?? _contentDisposition,
  crc32c: crc32c ?? _crc32c,
  etag: etag ?? _etag,
  downloadTokens: downloadTokens ?? _downloadTokens,
);
  String? get name => _name;
  String? get bucket => _bucket;
  String? get generation => _generation;
  String? get metageneration => _metageneration;
  String? get contentType => _contentType;
  String? get timeCreated => _timeCreated;
  String? get updated => _updated;
  String? get storageClass => _storageClass;
  String? get size => _size;
  String? get md5Hash => _md5Hash;
  String? get contentEncoding => _contentEncoding;
  String? get contentDisposition => _contentDisposition;
  String? get crc32c => _crc32c;
  String? get etag => _etag;
  String? get downloadTokens => _downloadTokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['bucket'] = _bucket;
    map['generation'] = _generation;
    map['metageneration'] = _metageneration;
    map['contentType'] = _contentType;
    map['timeCreated'] = _timeCreated;
    map['updated'] = _updated;
    map['storageClass'] = _storageClass;
    map['size'] = _size;
    map['md5Hash'] = _md5Hash;
    map['contentEncoding'] = _contentEncoding;
    map['contentDisposition'] = _contentDisposition;
    map['crc32c'] = _crc32c;
    map['etag'] = _etag;
    map['downloadTokens'] = _downloadTokens;
    return map;
  }

}