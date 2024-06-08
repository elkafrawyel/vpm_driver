import 'package:driver/data/models/garage_model.dart';

import 'user_model.dart';

class ParkingModel {
  ParkingModel({
    this.id,
    this.startsAt,
    this.startConfirmedAt,
    this.endsAt,
    this.totalCost,
    this.hourCost,
    this.freeHours,
    this.startLongitude,
    this.startLatitude,
    this.endLongitude,
    this.endLatitude,
    this.user,
    this.startDriver,
    this.endDriver,
    this.garage,
    this.hasRequestEnd,
  });

  ParkingModel.fromJson(dynamic json) {
    id = json['id'];
    startsAt = json['starts_at'];
    startConfirmedAt = json['start_confirmed_at'];
    endsAt = json['ends_at'];
    totalCost = json['total_cost'];
    hourCost = json['hour_cost'];
    freeHours = json['free_hours'];
    startLongitude = json['start_longitude'];
    startLatitude = json['start_latitude'];
    endLongitude = json['end_longitude'];
    endLatitude = json['end_latitude'];
    hasRequestEnd = json['has_end_request'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    startDriver = json['start_driver'] != null ? UserModel.fromJson(json['start_driver']) : null;

    endDriver = json['end_driver'] != null ? UserModel.fromJson(json['end_driver']) : null;
    garage = json['garage'] != null ? GarageModel.fromJson(json['garage']) : null;
  }

  String? id;
  String? startsAt;
  String? startConfirmedAt;
  String? endsAt;
  num? totalCost;
  num? hourCost;
  num? freeHours;
  dynamic startLongitude;
  dynamic startLatitude;
  dynamic endLongitude;
  dynamic endLatitude;
  UserModel? user;
  UserModel? startDriver;
  UserModel? endDriver;
  GarageModel? garage;
  bool? hasRequestEnd;
}
