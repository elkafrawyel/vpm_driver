import 'package:get/get.dart';

import '../../app/util/operation_reply.dart';

abstract class GeneralController extends GetxController {
  OperationReply _operationReply = OperationReply.init();

  OperationReply get operationReply => _operationReply;

  set operationReply(OperationReply value) {
    _operationReply = value;
    update();
  }

  Future<void> refreshApiCall();
}
