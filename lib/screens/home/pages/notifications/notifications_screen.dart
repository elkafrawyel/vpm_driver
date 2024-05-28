import 'package:driver/app/extensions/space.dart';
import 'package:driver/controller/home_screen/notifications_controller.dart';
import 'package:driver/widgets/api_state_views/handel_api_state.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../data/models/notifications_model.dart';
import '../../../../widgets/api_state_views/pagination_view.dart';
import '../../../../widgets/app_widgets/app_text.dart';
import 'components/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with FCMNotificationMixin {
  final NotificationsController notificationsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
      ),
      body: GetBuilder<NotificationsController>(
        builder: (_) {
          return HandleApiState.operation(
            operationReply: notificationsController.operationReply,
            emptyView: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications,
                    size: 200,
                    color: Colors.black45,
                  ),
                  20.ph,
                  AppText('empty_notifications'.tr),
                  40.ph,
                  ElevatedButton(
                    onPressed: () {
                      notificationsController.refreshApi();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: AppText(
                        'refresh'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            child: PaginationView(
              loadMoreData: notificationsController.loadMoreNotifications,
              showLoadMoreWidget: notificationsController.loadingMore,
              showLoadMoreEndWidget: notificationsController.loadingMoreEnd,
              child: RefreshIndicator(
                color: const Color(0xff3D6AA5),
                backgroundColor: Colors.white,
                onRefresh: notificationsController.refreshApi,
                child: GroupedListView<NotificationsModel, DateTime>(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  reverse: false,
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: false,
                  floatingHeader: false,
                  padding: const EdgeInsets.all(8),
                  elements:
                      notificationsController.notifications.reversed.toList(),
                  groupBy: (NotificationsModel notification) {
                    DateTime date = DateTime.parse(notification.createdAt!);
                    return DateTime(
                      date.year,
                      date.month,
                      date.day,
                    );
                  },
                  groupHeaderBuilder: (NotificationsModel notificationModel) {
                    String date = notificationsController
                        .convertDate(notificationModel.createdAt);
                    String todayDate = notificationsController
                        .convertDate(DateTime.now().toString());
                    String yesterdayDate = notificationsController.convertDate(
                      DateTime.now()
                          .subtract(const Duration(days: 1))
                          .toString(),
                    );

                    String title = date == todayDate
                        ? "today".tr
                        : date == yesterdayDate
                            ? "yesterday".tr
                            : date;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Card(
                          elevation: 1.0,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: AppText(
                              title,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, NotificationsModel notification) {
                    return NotificationCard(
                      notificationsModel: notification,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {
    print('Notification Model====>${notification.data['notification_model']}');
    notificationsController.addNewNotification(notification);
  }
}
