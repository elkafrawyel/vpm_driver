import 'dart:io';

import 'package:driver/app/res/res.dart';
import 'package:driver/app/util/information_viewer.dart';
import 'package:driver/app/util/operation_reply.dart';
import 'package:driver/app/util/util.dart';
import 'package:driver/data/models/start_parking_response.dart';
import 'package:driver/data/providers/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  final bool isEndingPark;

  const ScannerScreen({
    super.key,
    this.isEndingPark = false,
  });

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    // getUserByCode('9b58836c-10cd-4dc6-8009-c86c909f83f0');
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future<void> getUserByCode(String code) async {
    OperationReply operationReply =
        await APIProvider.instance.post<StartParkingResponse>(
      endPoint: Res.apiStartParking,
      fromJson: StartParkingResponse.fromJson,
      requestBody: {
        'user_id': code,
      },
    );
    if (operationReply.isSuccess()) {
      StartParkingResponse startParkingResponse = operationReply.result;
      Get.back(result: startParkingResponse.data?.user);
      Utils().playSound();
      InformationViewer.showSuccessToast(
        msg: startParkingResponse.message ?? '',
      );
    } else {
      Get.back();
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result != null && (result?.code ?? '').isNotEmpty) {
        await controller.stopCamera();
        String code = result!.code.toString();
        debugPrint('Scanner result : $code');
        if (widget.isEndingPark) {
          Get.back(result: code);
        } else {
          await getUserByCode(code);
        }
        await controller.resumeCamera();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
