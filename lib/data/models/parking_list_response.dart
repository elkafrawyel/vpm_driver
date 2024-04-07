import 'package:driver/data/models/parking_model.dart';

import 'meta.dart';

class ParkingListResponse {
  ParkingListResponse({
    this.data,
    this.meta,
  });

  ParkingListResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ParkingModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<ParkingModel>? data;
  Meta? meta;
}
