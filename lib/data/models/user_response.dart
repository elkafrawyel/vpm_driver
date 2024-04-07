import 'package:driver/data/models/user_model.dart';


class UserResponse {
  UserResponse({
    this.statusCode,
    this.message,
    this.userModel,
  });

  UserResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  num? statusCode;
  String? message;
  UserModel? userModel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['message'] = message;
    if (userModel != null) {
      map['data'] = userModel?.toJson();
    }
    return map;
  }
}

