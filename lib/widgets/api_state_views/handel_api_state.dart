import 'package:flutter/material.dart';

import '../../../app/util/operation_reply.dart';
import '../../controller/general_controller.dart';
import 'api_connection_error_view.dart';
import 'api_empty_view.dart';
import 'api_error_view.dart';
import 'api_loading_view.dart';

class HandleApiState extends StatelessWidget {
  final GeneralController? generalController;
  final OperationReply? operationReply;
  final Widget child;
  final Widget? shimmerLoader;
  final Widget? emptyView;

  const HandleApiState.controller({
    Key? key,
    required this.generalController,
    required this.child,
    this.operationReply,
    this.shimmerLoader,
    this.emptyView,
  }) : super(key: key);

  const HandleApiState.operation({
    Key? key,
    required this.operationReply,
    required this.child,
    this.generalController,
    this.shimmerLoader,
    this.emptyView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (generalController != null) {
      switch (generalController!.operationReply.status) {
        case OperationStatus.init:
          return const SizedBox();
        case OperationStatus.loading:
          return shimmerLoader ?? const ApiLoadingView();
        case OperationStatus.success:
          return child;
        case OperationStatus.failed:
          return ApiErrorView(
            errorText: generalController!.operationReply.message,
            retry: generalController!.refreshApiCall,
          );
        case OperationStatus.empty:
          return emptyView ??
              ApiEmptyView(
                emptyText: generalController!.operationReply.message,
              );
        case OperationStatus.disConnected:
          return const ApiConnectionErrorView();
        default:
          return const SizedBox();
      }
    } else if (operationReply != null) {
      switch (operationReply!.status) {
        case OperationStatus.init:
          return const SizedBox();
        case OperationStatus.loading:
          return shimmerLoader ?? const ApiLoadingView();
        case OperationStatus.success:
          return child;
        case OperationStatus.failed:
          return ApiErrorView(
            errorText: operationReply!.message,
          );
        case OperationStatus.disConnected:
          return const ApiConnectionErrorView();
        case OperationStatus.empty:
          return emptyView ??
              ApiEmptyView(
                emptyText: operationReply!.message,
              );
        default:
          return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }
}
