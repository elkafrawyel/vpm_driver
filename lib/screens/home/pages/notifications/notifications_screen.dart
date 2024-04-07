import 'package:driver/controller/home_screen/notifications_controller.dart';
import 'package:driver/widgets/api_state_views/handel_api_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../widgets/api_state_views/pagination_view.dart';
import '../../../../widgets/app_widgets/app_text.dart';
import 'components/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
            child: PaginationView(
              loadMoreData: notificationsController.loadMoreNotifications,
              showLoadMoreWidget: notificationsController.loadingMore,
              showLoadMoreEndWidget: notificationsController.loadingMoreEnd,
              child: RefreshIndicator(
                color: const Color(0xff3D6AA5),
                backgroundColor: Colors.white,
                onRefresh: notificationsController.refreshApi,
                child: GroupedListView<NotificationModel, DateTime>(
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
                  groupBy: (NotificationModel notification) {
                    DateTime date = DateTime.parse(notification.dateTime!);
                    return DateTime(
                      date.year,
                      date.month,
                      date.day,
                    );
                  },
                  groupHeaderBuilder: (NotificationModel notificationModel) {
                    String date = notificationsController
                        .convertDate(notificationModel.dateTime);
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
                            ? "Yesterday".tr
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
                  itemBuilder: (context, NotificationModel notification) {
                    return NotificationCard(
                      notificationModel: notification,
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
}
