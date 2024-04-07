import 'package:driver/app/res/res.dart';
import 'package:driver/app/util/operation_reply.dart';
import 'package:driver/controller/general_controller.dart';
import 'package:driver/data/models/parking_list_response.dart';
import 'package:driver/data/providers/network/api_provider.dart';
import 'package:driver/screens/home/pages/history/components/active_parking_list.dart';
import 'package:driver/screens/home/pages/history/components/ended_parking_list.dart';
import 'package:flutter/material.dart';

import '../../data/models/parking_model.dart';

class HistoryController extends GeneralController {
  List<ParkingModel> currentParkingList = [];
  List<ParkingModel> endedParkingList = [];

  List<Widget> pages = [
    const ActiveParkingList(),
    const EndedParkingList(),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
    refreshApiCall();
  }

  int page = 1;

  int totalPages = 1;

  bool loadingMore = false, loadingMoreEnd = false;

  @override
  void onInit() {
    super.onInit();
    _loadParkingList();
  }

  Future _loadParkingList() async {
    operationReply = OperationReply.loading();

    operationReply = await APIProvider.instance.get(
      endPoint:
          "${Res.apiGetParkingList}?paginate=$_selectedIndex&status=${_selectedIndex == 0 ? 'current' : 'ends'}",
      fromJson: ParkingListResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      ParkingListResponse parkingListResponse = operationReply.result;
      totalPages = parkingListResponse.meta?.lastPage?.toInt() ?? 1;
      switch (_selectedIndex) {
        case 0:
          currentParkingList = parkingListResponse.data ?? [];
          if (currentParkingList.isEmpty) {
            operationReply = OperationReply.empty();
          } else {
            operationReply = OperationReply.success();
          }
          break;
        case 1:
          endedParkingList = parkingListResponse.data ?? [];
          if (endedParkingList.isEmpty) {
            operationReply = OperationReply.empty();
          } else {
            operationReply = OperationReply.success();
          }
          break;
      }
    }
  }

  void loadMoreParking() async {
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
    operationReply = await APIProvider.instance.get(
      endPoint:
          "${Res.apiGetParkingList}?paginate=$_selectedIndex&status=ends&page=$page",
      fromJson: ParkingListResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      ParkingListResponse parkingListResponse = operationReply.result;

      endedParkingList.addAll(parkingListResponse.data ?? []);
    }

    loadingMore = false;
    update();
  }

  @override
  Future<void> refreshApiCall() async {
    endedParkingList.clear();
    page = 1;
    totalPages = 1;
    loadingMoreEnd =false;
    loadingMore=false;
    _loadParkingList();
  }
}
