import 'package:driver/data/models/user_model.dart';

class NotificationsModel {
  NotificationsModel({
    this.id,
    this.eventId,
    this.moduleCode,
    this.modulePrefix,
    this.moduleName,
    this.moduleNameAr,
    this.eventAction,
    this.eventTableName,
    this.eventCode,
    this.eventPrefix,
    this.eventName,
    this.eventNameAr,
    this.eventContent,
    this.eventContentAr,
    this.eventReferenceCode,
    this.watched,
    this.occurredAt,
    this.watchedAt,
    this.createdAt,
    this.customer,
    this.driver,
  });

  NotificationsModel.fromJson(dynamic json) {
    id = json['id'];
    eventId = json['event_id'];
    moduleCode = json['module_code'];
    modulePrefix = json['module_prefix'];
    moduleName = json['module_name'];
    moduleNameAr = json['module_name_ar'];
    eventAction = json['event_action'];
    eventTableName = json['event_table_name'];
    eventCode = json['event_code'];
    eventPrefix = json['event_prefix'];
    eventName = json['event_name'];
    eventNameAr = json['event_name_ar'];
    eventContent = json['event_content'];
    eventContentAr = json['event_content_ar'];
    eventReferenceCode = json['event_reference_code'];
    watched = json['watched'];
    occurredAt = json['occurred_at'];
    watchedAt = json['watched_at'];
    createdAt = json['created_at'];
    customer =
        json['customer'] != null ? UserModel.fromJson(json['customer']) : null;
    driver = json['driver'] != null ? UserModel.fromJson(json['driver']) : null;
  }

  String? id;
  dynamic eventId;
  dynamic moduleCode;
  String? modulePrefix;
  String? moduleName;
  String? moduleNameAr;
  String? eventAction;
  String? eventTableName;
  dynamic eventCode;
  String? eventPrefix;
  String? eventName;
  String? eventNameAr;
  String? eventContent;
  String? eventContentAr;
  String? eventReferenceCode;
  bool? watched;
  String? occurredAt;
  String? watchedAt;
  String? createdAt;
  UserModel? customer;
  UserModel? driver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event_id'] = eventId;
    map['module_code'] = moduleCode;
    map['module_prefix'] = modulePrefix;
    map['module_name'] = moduleName;
    map['module_name_ar'] = moduleNameAr;
    map['event_action'] = eventAction;
    map['event_table_name'] = eventTableName;
    map['event_code'] = eventCode;
    map['event_prefix'] = eventPrefix;
    map['event_name'] = eventName;
    map['event_name_ar'] = eventNameAr;
    map['event_content'] = eventContent;
    map['event_content_ar'] = eventContentAr;
    map['event_reference_code'] = eventReferenceCode;
    map['watched'] = watched;
    map['occurred_at'] = occurredAt;
    map['watched_at'] = watchedAt;
    map['created_at'] = createdAt;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    map['driver'] = driver;
    return map;
  }
}
