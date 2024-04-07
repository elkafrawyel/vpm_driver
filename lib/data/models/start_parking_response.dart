import 'parking_model.dart';

class StartParkingResponse {
  StartParkingResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  StartParkingResponse.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? ParkingModel.fromJson(json['data']) : null;
  }

  num? statusCode;
  String? message;
  ParkingModel? data;
}
