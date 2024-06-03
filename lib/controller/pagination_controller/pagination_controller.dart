import 'package:get/get.dart';

import '../../../../app/util/operation_reply.dart';
import '../../data/providers/network/api_provider.dart';
import 'data/config_data.dart';
import 'data/pagination_response.dart';

class PaginationController<T> extends GetxController {
  PaginationController(this.configData);

  num page = 1;
  num perPage = 10;
  bool isLastPage = false;
  bool _loadingMore = false, _loadingMoreEnd = false;
  bool paginate = true;

  PaginationResponse<T>? paginationResponse;
  List<T> paginationList = [];

  OperationReply _operationReply = OperationReply.init();

  OperationReply get operationReply => _operationReply;

  set operationReply(OperationReply value) {
    _operationReply = value;
    update();
  }

  ConfigData<T> configData;

  bool get loadingMore => _loadingMore;

  set loadingMore(bool value) {
    _loadingMore = value;
    update();
  }

  get loadingMoreEnd => _loadingMoreEnd;

  set loadingMoreEnd(value) {
    _loadingMoreEnd = value;
    update();
  }

  @override
  onInit() {
    super.onInit();
    callApi();
  }

  callApi() async {
    operationReply = OperationReply.loading();
    String path =
        '${configData.apiEndPoint}?paginate=$paginate&page=$page&per_page=$perPage';
    if ({configData.parameters ?? {}}.isNotEmpty) {
      configData.parameters!.forEach((key, value) {
        path += '&$key=$value';
      });
    }
    operationReply = await APIProvider.instance.get(
      endPoint: path,
      fromJson: (json) => PaginationResponse<T>.fromJson(
        json,
        fromJson: configData.fromJson,
      ),
    );

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;
      paginationList = paginationResponse?.data ?? [];
      isLastPage = paginationList.length < perPage;

      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty(
          message: configData.emptyListMessage,
        );
      } else {
        operationReply = OperationReply.success();
      }
    }
  }

  void callMoreData() async {
    if (loadingMoreEnd || loadingMore) {
      return;
    }
    page++;
    if (isLastPage) {
      loadingMoreEnd = true;
      return;
    }
    loadingMore = true;
    String path =
        '${configData.apiEndPoint}?paginate=$paginate&page=$page&per_page=$perPage';
    if ({configData.parameters ?? {}}.isNotEmpty) {
      configData.parameters!.forEach((key, value) {
        path += '&$key=$value';
      });
    }

    operationReply = await APIProvider.instance.get(
      endPoint: path,
      fromJson: (json) => PaginationResponse<T>.fromJson(
        json,
        fromJson: configData.fromJson,
      ),
    );

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;

      isLastPage = (paginationResponse?.data ?? []).length < perPage;

      paginationList.addAll(paginationResponse?.data ?? []);

      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        operationReply = OperationReply.success();
      }
    }
    loadingMore = false;
  }

  Future<void> refreshApiCall() async {
    page = 1;
    loadingMoreEnd = false;
    loadingMore = false;
    await callApi();
  }
}
