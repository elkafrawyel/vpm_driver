import 'dart:convert';

import 'package:driver/app/util/operation_reply.dart';
import 'package:driver/controller/pagination_controller/pagination_controller.dart';
import 'package:driver/data/models/notifications_model.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationsController extends PaginationController<NotificationsModel> {
  NotificationsController(super.configData);

  convertDate(String? dateString) => dateString == null
      ? ''
      : DateFormat('EE, dd MMMM', Get.locale.toString()).format(
          DateTime.parse(dateString),
        );

  void addNewNotification(RemoteMessage notification) {
    paginationList.insert(
      0,
      NotificationsModel.fromJson(
        jsonDecode(
          notification.data['notification_model'].toString(),
        ),
      ),
    );
    operationReply = OperationReply.success();
  }
}
