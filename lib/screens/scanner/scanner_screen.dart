import 'dart:developer';

import 'package:driver/app/extensions/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/util/constants.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../../widgets/dialogs_view/app_dialog_view.dart';

class ScannerScreen extends StatefulWidget {
  final bool isEndingPark;

  const ScannerScreen({
    super.key,
    this.isEndingPark = false,
  });

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with WidgetsBindingObserver{
  MobileScannerController? cameraController;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() async {
    await cameraController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool _shouldHandleResume = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _shouldHandleResume) {
      _shouldHandleResume = false;
      bool enabled = await checkCameraPermission();
      if (enabled) {
        setState(() {});
      }
    }
  }

  Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.camera.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      Get.dialog(
        Align(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: AppDialogView(
              svgName: '',
              title: 'camera_permission'.tr,
              message: 'camera_permission_message'.tr,
              onActionClicked: () async {
                Get.back(closeOverlays: true);
                _shouldHandleResume = true;
                openAppSettings();
              },
              actionText: 'ok'.tr,
            ),
          ),
        ),
        barrierDismissible: false,
      );
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkCameraPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return _scannerView();
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      'camera_permission_message'.tr,
                      centerText: true,
                      maxLines: 3,
                    ),
                    20.ph,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _shouldHandleResume = true;
                        openAppSettings();
                      },
                      child: AppText(
                        'enable_camera_permission'.tr,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  Widget _scannerView() {
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(
        const Offset(0, 0),
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: MediaQuery.sizeOf(context).width * 0.8,
    );

    cameraController ??= MobileScannerController();

    return MobileScanner(
      scanWindow: scanWindow,
      controller: cameraController,
      onDetect: (barcodeCapture) async {
        final barcode = barcodeCapture.barcodes.first;
        final String? code = barcode.rawValue;

        if (!_isDialogShowing && code != null) {
          _isDialogShowing = true;

          //so that the station loading start while the sheet opens

          debugPrint('Scanner result : $code');
          if (widget.isEndingPark) {
            Get.back(result: code);
          } else {
            Get.back(result: code);
          }

          _isDialogShowing = false;
        }
      },
      onDetectError: (object, stack) =>
          log('Error while scanning: $object\n$stack'),
      placeholderBuilder: (context) => Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      overlayBuilder: (context, view) {
        return ScanWindowOverlay(
          scanWindow: scanWindow,
          controller: cameraController!,
          borderColor: Colors.white,
          borderRadius: BorderRadius.circular(kRadius),
        );
      },
    );
  }
}
