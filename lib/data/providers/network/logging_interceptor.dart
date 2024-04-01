import 'package:dio/dio.dart';

import '../../../app/util/util.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Utils.logMessage("<------------------ HTTP ----------------->");

    Utils.logMessage("<----------- REQUEST INFORMATION --------->");
    Utils.logMessage("HEADERS----> ${response.requestOptions.headers.toString()}");
    Utils.logMessage("METHOD ----> ${response.requestOptions.method}");
    Utils.logMessage("URL    ----> ${response.requestOptions.uri}");
    Utils.logMessage("CODE:[${response.statusCode}]");
    Utils.logMessage("<------- RESPONSE INFORMATION ------>");
    Utils.logMessage("==================================== DATA =====================================");
    Utils.logMessage("${response.data}");
    Utils.logMessage("===============================================================================");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Utils.logMessage("<---- Interceptor Error ---->", isError: true);
    Utils.logMessage("-->${err.error}", isError: true);
    Utils.logMessage("-->${err.message}", isError: true);
    Utils.logMessage("<---- End Error ---->", isError: true);

    super.onError(err, handler);
  }
}
