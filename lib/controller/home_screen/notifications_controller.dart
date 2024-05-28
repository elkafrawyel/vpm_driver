import 'dart:convert';

import 'package:driver/app/res/res.dart';
import 'package:driver/app/util/operation_reply.dart';
import 'package:driver/data/models/notifications_model.dart';
import 'package:driver/data/models/notifications_response.dart';
import 'package:driver/data/providers/network/api_provider.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationsController extends GetxController {
  List<NotificationsModel> notifications = [];

  num page = 1;

  num totalPages = 1;

  bool loadingMore = false, loadingMoreEnd = false;

  OperationReply operationReply = OperationReply.init();

  NotificationsResponse? notificationsResponse;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    operationReply = OperationReply.loading();
    update();

    operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiNotifications}?page=$page',
      fromJson: NotificationsResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      notificationsResponse = operationReply.result;

      notifications = notificationsResponse?.data ?? [];
      if (notifications.isEmpty) {
        operationReply =
            OperationReply.empty(message: 'empty_notifications'.tr);
        update();
      } else {
        totalPages = notificationsResponse?.meta?.total ?? 1;
        operationReply = OperationReply.success();
        update();
      }
    }
  }

  void loadMoreNotifications() async {
    if (loadingMoreEnd || loadingMore) {
      return;
    }
    page++;
    if (page > totalPages) {
      loadingMoreEnd = true;
      update();
      return;
    }
    loadingMore = true;
    update();
    operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiNotifications}?page=$page',
      fromJson: NotificationsResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      notificationsResponse = operationReply.result;

      notifications.addAll(notificationsResponse?.data ?? []);
      if (notifications.isEmpty) {
        operationReply = OperationReply.empty();
        update();
      } else {
        totalPages = notificationsResponse?.meta?.lastPage ?? 1;
        operationReply = OperationReply.success();
        update();
      }
    }
    loadingMore = false;
    update();
  }

  Future<void> refreshApi() async {
    page = 1;
    totalPages = 1;
    loadingMoreEnd = false;
    loadingMore = false;
    await _loadNotifications();
  }

  convertDate(String? dateString) => dateString == null
      ? ''
      : DateFormat('EE, dd MMMM', Get.locale.toString()).format(
          DateTime.parse(dateString),
        );

  void addNewNotification(RemoteMessage notification) {
    print('adding new notification');
    notifications.insert(
        0,
        NotificationsModel.fromJson(
            jsonDecode(notification.data['notification_model'].toString())));
    operationReply = OperationReply.success();
    update();
  }
}
