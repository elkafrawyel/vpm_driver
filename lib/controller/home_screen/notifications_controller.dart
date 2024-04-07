import 'package:driver/app/util/operation_reply.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationModel {
  String? name;

  String? dateTime;

  NotificationModel(this.name, this.dateTime);
}

class NotificationsController extends GetxController {
  List<NotificationModel> notifications = [];

  int page = 1;

  int totalPages = 10;

  bool loadingMore = false, loadingMoreEnd = false;

  OperationReply operationReply = OperationReply.init();

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    operationReply = OperationReply.loading();
    update();

    DateTime dateTime = DateTime.now();
    List.generate(
      10,
      (index) {
        dateTime = dateTime.subtract(
          const Duration(hours: 1),
        );
        notifications.add(
          NotificationModel(
            'Notification $index',
            dateTime.toIso8601String(),
          ),
        );
      },
    );

    // totalPages = parkingListResponse.meta?.lastPage?.toInt() ?? 1;
    operationReply = OperationReply.success();
    update();
  }

  void loadMoreNotifications() async {
    if (loadingMoreEnd) {
      return;
    }
    page++;
    if (page > totalPages) {
      loadingMoreEnd = true;
      update();
      return;
    }

    print('Page========>$page');
    loadingMore = true;
    update();
    DateTime dateTime = DateTime.parse(notifications.last.dateTime!);
    List.generate(
      10,
      (index) {
        dateTime = dateTime.subtract(
          const Duration(hours: 4),
        );
        notifications.add(
          NotificationModel(
            'Notification $index',
            dateTime.toIso8601String(),
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    loadingMore = false;
    update();
  }

  Future<void> refreshApi() async {
    notifications.clear();
    page = 1;
    totalPages = 10;
    loadingMoreEnd =false;
    loadingMore=false;
    await _loadNotifications();
  }

  convertDate(String? dateString) => dateString == null
      ? ''
      : DateFormat('EE, dd MMMM', Get.locale.toString()).format(
          DateTime.parse(dateString),
        );
}
