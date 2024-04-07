import 'package:driver/data/models/user_model.dart';

class RequestsResponse {
  RequestsResponse({
    this.data,
  });

  RequestsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RequestModel.fromJson(v));
      });
    }
  }

  List<RequestModel>? data;

  RequestsResponse copyWith({
    List<RequestModel>? data,
  }) =>
      RequestsResponse(
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class RequestModel {
  RequestModel({
    this.id,
    this.createdAt,
    this.repeatedTimes,
    this.type,
    this.status,
    this.user,
  });

  RequestModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    repeatedTimes = json['repeated_times'];
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  String? id;
  String? createdAt;
  num? repeatedTimes;
  Type? type;
  Status? status;
  UserModel? user;

  RequestModel copyWith({
    String? id,
    String? createdAt,
    num? repeatedTimes,
    Type? type,
    Status? status,
    UserModel? user,
  }) =>
      RequestModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        repeatedTimes: repeatedTimes ?? this.repeatedTimes,
        type: type ?? this.type,
        status: status ?? this.status,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['repeated_times'] = repeatedTimes;
    if (type != null) {
      map['type'] = type?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class Status {
  Status({
    this.id,
    this.type,
    this.code,
    this.key,
    this.prefix,
    this.name,
    this.nameAr,
  });

  Status.fromJson(dynamic json) {
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

  Status copyWith({
    String? id,
    String? type,
    num? code,
    String? key,
    String? prefix,
    String? name,
    String? nameAr,
  }) =>
      Status(
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
