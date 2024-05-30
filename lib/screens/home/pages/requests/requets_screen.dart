import 'package:driver/app/extensions/space.dart';
import 'package:driver/controller/home_screen/requests_controller.dart';
import 'package:driver/screens/home/pages/requests/components/requests_card.dart';
import 'package:driver/widgets/api_state_views/handel_api_state.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen>
    with AutomaticKeepAliveClientMixin {
  final RequestsController requestsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('requests'.tr),
      ),
      body: GetBuilder<RequestsController>(
        builder: (_) {
          return HandleApiState.operation(
            operationReply: requestsController.operationReply,
            shimmerLoader: const Center(child: CircularProgressIndicator()),
            emptyView: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 200,
                    color: Colors.black54,
                  ),
                  20.ph,
                  AppText(
                    'empty_requests'.tr,
                    fontSize: 16,
                  ),
                  40.ph,
                  ElevatedButton(
                    onPressed: () {
                      requestsController.refreshApiCall();
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
            child: RefreshIndicator(
              onRefresh: requestsController.refreshApiCall,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => RequestsCard(
                    requestModel: requestsController.requests[index],
                  ),
                  separatorBuilder: (context, index) => 10.ph,
                  itemCount: requestsController.requests.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
