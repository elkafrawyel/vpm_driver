import 'dart:ui';

import 'package:driver/controller/home_screen/home_screen_binding.dart';
import 'package:driver/data/models/user_model.dart';
import 'package:driver/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/res/res.dart';
import '../../app/util/information_viewer.dart';
import '../../app/util/keys.dart';
import '../../app/util/operation_reply.dart';
import '../../app/util/util.dart';
import '../../data/models/general_response.dart';
import '../../data/providers/network/api_provider.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../../widgets/dialogs_view/app_dialog_view.dart';
import '../scanner/scanner_screen.dart';

class MapScreen extends StatefulWidget {
  final UserModel userModel;
  final String parkingId;
  final String latitude;
  final String longitude;

  const MapScreen({
    super.key,
    required this.userModel,
    required this.parkingId,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? myLocation;
  Map<MarkerId, Marker> garagesMarkersMap = {};
  List<Polyline> polyLinesList = [];

  @override
  void initState() {
    getMyPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'map'.tr,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
      ),
      body: Stack(
        children: [
          myLocation == null
              ? const SizedBox()
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: myLocation!,
                    zoom: 14,
                  ),
                  myLocationEnabled: true,
                  // tiltGesturesEnabled: true,
                  // compassEnabled: true,
                  scrollGesturesEnabled: true,
                  // zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  onTap: (position) {},
                  onCameraMove: (position) {},
                  onMapCreated: onMapCreated,
                  markers: Set<Marker>.of(garagesMarkersMap.values),
                  polylines: Set<Polyline>.of(polyLinesList),
                ),
          PositionedDirectional(
            start: 0,
            bottom: 30,
            end: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _endRequest,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 12,
                  ),
                  child: AppText(
                    'end_park'.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? customerId;

  Future _endRequest() async {
    customerId = await Get.to(() => const ScannerScreen(
          isEndingPark: true,
        ));
    // customerId = '9c334e0e-bb90-4428-ae51-ef935cfd56de';
    if (customerId != null) {
      if (customerId == widget.userModel.id) {
        Utils().playSound();
        InformationViewer.showSuccessToast(msg: 'Scan Completed SuccessFully');
      }
    } else {
      InformationViewer.showErrorToast(msg: 'Scan Failed');

      return;
    }

    EasyLoading.show();

    OperationReply operationReply = await APIProvider.instance.patch(
      endPoint: "${Res.apiEndParking}/${widget.parkingId}",
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );

    EasyLoading.dismiss();
    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.offAll(() => const HomeScreen(), binding: HomeScreenBinding());
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }

  Future addUserMarker() async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    final Uint8List? markerIcon = await _getBytesFromAssetMarker(
      Res.locationPinImage,
      150,
    );
    icon = markerIcon == null ? icon : BitmapDescriptor.fromBytes(markerIcon);

    MarkerId markerId = MarkerId(widget.parkingId);
    Marker marker = Marker(
      markerId: markerId,
      icon: icon,
      position: LatLng(
        // 30.95712249827692, 31.19021671167132,
        double.parse(widget.latitude),
        double.parse(widget.longitude),
      ),
      onTap: () async {},
    );
    garagesMarkersMap[markerId] = marker;

    setState(() {});
    getDirectionsToDestination(
      lineId: widget.parkingId,
      destination: PointLatLng(
        // 30.95712249827692, 31.19021671167132,
        double.parse(widget.latitude),
        double.parse(widget.longitude),
      ),
    );
  }

  Future<Uint8List?> _getBytesFromAssetMarker(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
          targetHeight: width);
      FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ImageByteFormat.png))!
          .buffer
          .asUint8List();
    } catch (e) {
      Utils.logMessage("==============>${e.toString()}");
      return null;
    }
  }

  Future getDirectionsToDestination({
    required String lineId,
    required PointLatLng destination,
  }) async {
    animateToPosition(myLocation!, zoom: 14);

    PointLatLng origin = PointLatLng(
      double.parse(myLocation!.latitude.toString()),
      double.parse(
        myLocation!.longitude.toString(),
      ),
    );
    PolylineResult result =
        await PolylinePoints(apiKey: googleMapKey).getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: origin,
        destination: destination,
        mode: TravelMode.driving,
      ),
    );
    List<LatLng> polylineCoordinates = [];

    if (result.status == 'OK' && result.points.isNotEmpty) {
      Utils.logMessage('Origin===========>${result.startAddress}');
      Utils.logMessage('Destination======>${result.endAddress}');
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    Polyline polyLine = Polyline(
      polylineId: PolylineId(lineId),
      color: Colors.blue,
      points: polylineCoordinates,
      width: 10,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      // patterns: [PatternItem.dash(10), PatternItem.gap(10)],
    );

    polyLinesList.clear();
    polyLinesList.add(polyLine);
    setState(() {});
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  Future checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _openSettingDialog();
        Future.error('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _openSettingDialog();
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
  }

  Future getMyPosition({bool loading = true}) async {
    await checkLocationPermission();
    if (loading) {
      EasyLoading.show(status: 'getting_location'.tr);
    }
    Position position = await Geolocator.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);
    if (myLocation == null) {
      Get.back();
      InformationViewer.showErrorToast(msg: 'Faild to get your location');
    }
    setState(() {});
    if (loading) {
      EasyLoading.dismiss();
    }

    if (loading) {
      animateToPosition(myLocation!);
    }
    addUserMarker();
  }

  _openSettingDialog() {
    Get.dialog(
      AppDialogView(
        title: 'location_permission'.tr,
        message: 'location_permission_message'.tr,
        onActionClicked: () async {
          Get.back();
          openAppSettings();
        },
        actionText: 'ok'.tr,
        svgName: Res.iconLocation,
      ),
    );
  }

  animateToPosition(LatLng latLng, {double? zoom}) {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          latLng,
          zoom ?? 16,
        ),
      );
    } else {
      Utils.logMessage('AnimateCamera failed.');
    }
  }
}
