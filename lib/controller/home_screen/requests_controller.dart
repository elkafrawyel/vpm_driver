import 'package:driver/app/util/operation_reply.dart';
import 'package:driver/controller/general_controller.dart';
import 'package:driver/data/models/requests_response.dart';

import '../../app/res/res.dart';
import '../../data/providers/network/api_provider.dart';

class RequestsController extends GeneralController {
  List<RequestModel> requests = [];

  @override
  void onInit() {
    super.onInit();

    _loadRequests();
  }

  void _loadRequests({bool loading = true}) async {
    operationReply = OperationReply.success();
    if (loading) {
      operationReply = OperationReply.loading();
    }

    operationReply = await APIProvider.instance.get(
      endPoint: Res.apiRequests,
      fromJson: RequestsResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      RequestsResponse requestsResponse = operationReply.result;
      requests = requestsResponse.data ?? [];
      if (requests.isEmpty) {
        operationReply = OperationReply.empty();
      }
    }

  }

  @override
  Future<void> refreshApiCall()async {
    _loadRequests();
  }
}
