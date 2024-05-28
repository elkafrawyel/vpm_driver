import 'meta.dart';
import 'notifications_model.dart';

class NotificationsResponse {
  NotificationsResponse({
    this.data,
    this.meta,
  });

  NotificationsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationsModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<NotificationsModel>? data;
  Meta? meta;
}
