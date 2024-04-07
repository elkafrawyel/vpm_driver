class GarageModel {
  GarageModel({
    this.id,
    this.name,
    this.siteNumber,
    this.hourCost,
    this.maxCarCount,
    this.availableCarCount,
    this.reservedCarCount,
    this.longitude,
    this.latitude,
    this.openAt,
    this.closeAt,
    this.isAvailable = false,
    this.type,
  });

  GarageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    siteNumber = json['site_number'];
    hourCost = json['hour_cost'];
    maxCarCount = json['max_car_count'];
    availableCarCount = json['available_car_count'];
    reservedCarCount = json['reserved_car_count'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    openAt = json['open_at'];
    closeAt = json['close_at'];
    isAvailable = json['is_available'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }

  String? id;
  String? name;
  num? siteNumber;
  num? hourCost;
  num? maxCarCount;
  num? availableCarCount;
  num? reservedCarCount;
  String? longitude;
  String? latitude;
  String? openAt;
  String? closeAt;
  bool isAvailable = false;
  Type? type;

  GarageModel copyWith({
    String? id,
    String? name,
    num? siteNumber,
    num? hourCost,
    num? maxCarCount,
    num? availableCarCount,
    num? reservedCarCount,
    String? longitude,
    String? latitude,
    String? openAt,
    String? closeAt,
    bool? isAvailable,
    Type? type,
  }) =>
      GarageModel(
        id: id ?? this.id,
        name: name ?? this.name,
        siteNumber: siteNumber ?? this.siteNumber,
        hourCost: hourCost ?? this.hourCost,
        maxCarCount: maxCarCount ?? this.maxCarCount,
        availableCarCount: availableCarCount ?? this.availableCarCount,
        reservedCarCount: reservedCarCount ?? this.reservedCarCount,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        openAt: openAt ?? this.openAt,
        closeAt: closeAt ?? this.closeAt,
        isAvailable: isAvailable ?? this.isAvailable,
        type: type ?? this.type,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['site_number'] = siteNumber;
    map['hour_cost'] = hourCost;
    map['max_car_count'] = maxCarCount;
    map['available_car_count'] = availableCarCount;
    map['reserved_car_count'] = reservedCarCount;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['open_at'] = openAt;
    map['close_at'] = closeAt;
    map['is_available'] = isAvailable;
    if (type != null) {
      map['type'] = type?.toJson();
    }
    return map;
  }
}

class Type {
  Type({
    this.id,
    this.type,
    this.code,
    this.key,
    this.prefix,
    this.name,
    this.nameAr,
  });

  Type.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    key = json['key'];
    prefix = json['prefix'];
    name = json['name'];
    nameAr = json['name_ar'];
  }

  String? id;
  String? type;
  num? code;
  String? key;
  String? prefix;
  String? name;
  String? nameAr;

  Type copyWith({
    String? id,
    String? type,
    num? code,
    String? key,
    String? prefix,
    String? name,
    String? nameAr,
  }) =>
      Type(
        id: id ?? this.id,
        type: type ?? this.type,
        code: code ?? this.code,
        key: key ?? this.key,
        prefix: prefix ?? this.prefix,
        name: name ?? this.name,
        nameAr: nameAr ?? this.nameAr,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['code'] = code;
    map['key'] = key;
    map['prefix'] = prefix;
    map['name'] = name;
    map['name_ar'] = nameAr;
    return map;
  }
}
