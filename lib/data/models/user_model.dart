import 'image_model.dart';

class UserModel {
  UserModel({
    this.id,
    this.client,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.birthday,
    this.isVerified,
    this.isCompleted,
    this.token,
    this.avatar,
    this.createdAt,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    client = json['client'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    birthday = json['birthday'];
    isVerified = json['is_verified'];
    isCompleted = json['is_completed'];
    token = json['token'];
    avatar = json['avatar'] != null ? ImageModel.fromJson(json['avatar']) : null;
    createdAt = json['created_at'];
  }

  String? id;
  dynamic client;
  String? name;
  String? email;
  String? phone;
  dynamic gender;
  dynamic birthday;
  bool? isVerified;
  bool? isCompleted;
  String? token;
  ImageModel? avatar;
  String? createdAt;

  UserModel copyWith({
    String? id,
    dynamic client,
    String? name,
    String? email,
    String? phone,
    dynamic gender,
    dynamic birthday,
    bool? isVerified,
    bool? isCompleted,
    String? token,
    ImageModel? avatar,
    String? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        client: client ?? this.client,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        isVerified: isVerified ?? this.isVerified,
        isCompleted: isCompleted ?? this.isCompleted,
        token: token ?? this.token,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['client'] = client;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['gender'] = gender;
    map['birthday'] = birthday;
    map['is_verified'] = isVerified;
    map['is_completed'] = isCompleted;
    map['token'] = token;
    if (avatar != null) {
      map['avatar'] = avatar?.toJson();
    }
    map['created_at'] = createdAt;
    return map;
  }
}
