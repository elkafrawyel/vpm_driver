import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../data/providers/storage/local_provider.dart';
import 'operation_reply.dart';

class NetworkHelper {
  static const int noInternetConnectionCode = 415;

  static bool isSuccess(Response response) {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  static Future<bool> isConnected() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.first == ConnectivityResult.wifi;
  }

  ///Don't forget to cast it to function return type using [as] method
  static OperationReply handleCommonNetworkCases(Response response) {
    bool isAr = Get.locale?.languageCode == 'ar';
    Map? body;
    try {
      body = response.data;

      if (body != null && body['errors'] != null) {
        // handle api errors
        String errorMessage = '';
        Map<String, dynamic> errorMap = body['errors'];
        errorMap.forEach((key, value) {
          List errors = value;
          errorMessage = errorMessage + errors.first.toString();
        });
        return OperationReply(OperationStatus.failed, message: errorMessage);
      } else if (body != null &&
          body['message'] != null &&
          body['message'].length < 255) {
        if (body['message'].toString().contains('Unauthenticated')) {
          LocalProvider().signOut();
          return OperationReply(
            OperationStatus.failed,
            message: 'Unauthenticated',
          );
        }
        String errorMessage = '';
        if (body['message'].toString().isNotEmpty) {
          errorMessage = body['message'].toString();
        } else if (body['exception'] != null &&
            body['exception'].toString().isNotEmpty) {
          errorMessage = body['exception'].toString();
        }
        return OperationReply.failed(message: errorMessage);
      } else if (body != null && body['error'] != null) {
        String errorMessage = '';
        if (body['error'] is String) {
          errorMessage = body['error'];
          return OperationReply(OperationStatus.failed, message: errorMessage);
        } else {
          Map<String, dynamic> errorMap = body['error'];
          errorMap.forEach(
              (key, value) => errorMessage = errorMessage + value.toString());
          return OperationReply(OperationStatus.failed, message: errorMessage);
        }
      } else {
        return OperationReply.failed(
            message: isAr ? 'حدث خطأ ما' : 'General Error');
      }
    } catch (e) {
      return OperationReply.failed(
          message: isAr ? 'حدث خطأ ما' : 'General Error');
    }
  }
}
