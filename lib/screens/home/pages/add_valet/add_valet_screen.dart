import 'dart:developer';
import 'dart:io';

import 'package:driver/app/extensions/space.dart';
import 'package:driver/app/res/res.dart';
import 'package:driver/data/models/user_model.dart';
import 'package:driver/widgets/app_widgets/app_cached_image.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/config/app_color.dart';
import '../../../../app/util/constants.dart';
import '../../../../app/util/information_viewer.dart';
import '../../../../app/util/operation_reply.dart';
import '../../../../app/util/util.dart';
import '../../../../controller/home_screen/current_parking_controller.dart';
import '../../../../data/models/start_parking_response.dart';
import '../../../../data/providers/network/api_provider.dart';
import '../../../../widgets/app_widgets/app_progress_button.dart';
import '../../../scanner/scanner_screen.dart';

class AddValetScreen extends StatefulWidget {
  const AddValetScreen({Key? key}) : super(key: key);

  @override
  State<AddValetScreen> createState() => _AddValetScreenState();
}

class _AddValetScreenState extends State<AddValetScreen>
    with AutomaticKeepAliveClientMixin {
  String? userId;
  UserModel? customer;
  List<File> images = [];
  final ImagePicker picker = ImagePicker();

  reset() {
    setState(() {
      customer = null;
      userId = null;
      images.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('add'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Offstage(
              offstage: customer != null,
              child: GestureDetector(
                onTap: () async {
                  userId = await Get.to(() => const ScannerScreen());
                  userId = '9d590ec5-fe9d-4730-a46f-bfcfc7902823';
                  if (userId != null) {
                    log("======> $userId");
                    setState(() {});
                  }
                },
                child: SvgPicture.asset(Res.iconQr),
              ),
            ),
            Offstage(
              offstage: customer != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 12.0,
                ),
                child: AppText(
                  'scan_owner'.tr,
                  maxLines: 2,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  centerText: true,
                ),
              ),
            ),
            Offstage(
              offstage: customer == null,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: Icon(
                  Icons.verified,
                  size: 200,
                  color: Colors.black,
                ),
              ),
            ),
            Offstage(
              offstage: customer == null,
              child: ListTile(
                leading: AppCachedImage(
                  imageUrl: customer?.avatar?.filePath,
                  isCircular: true,
                  width: 60,
                  height: 60,
                  borderColor: Colors.black,
                ),
                title: AppText(
                  customer?.name ?? '',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  maxLines: 2,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: hintColor,
                        size: 20,
                      ),
                      AppText(
                        customer?.phone ?? '',
                        color: hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            30.ph,
            Offstage(
              offstage: customer == null,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: reset,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 48.0,
                  ),
                  child: AppText('done'.tr),
                ),
              ),
            ),
            Offstage(
              offstage: customer == null && userId == null,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: images
                    .map((e) => Container(
                          width: 100,
                          height: 100,
                          alignment: AlignmentDirectional.topEnd,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRadius),
                            image: DecorationImage(
                              image: FileImage(e),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                images.remove(e);
                              });
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
            20.ph,
            Offstage(
              offstage: customer == null && userId == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (images.length > 4) {
                      InformationViewer.showSnackBar('max_image_count_is_5'.tr);
                      return;
                    }
                    final XFile? photo =
                        await picker.pickImage(source: ImageSource.camera);
                    if (photo != null) {
                      setState(() {
                        images.add(File(photo.path));
                      });
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera),
                      10.pw,
                      AppText(
                        'take_photo'.tr,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Offstage(
              offstage: customer == null && userId == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText('max_image_count_is_5'.tr),
                ),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: AppProgressButton(
                text: 'add'.tr,
                textColor: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                backgroundColor: Colors.black,
                onPressed: (animationController) async {
                  if (userId != null) {
                    getUserByCode(animationController: animationController);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> getUserByCode(
      {required AnimationController animationController}) async {
    if (userId == null) {
      return;
    }

    // List<MultipartFile> multipartFileList = [];
    // for (int i = 0; i < images.length; i++) {
    //   debugPrint("isFile: ${images[i]}");
    //
    //   /// Adding into list
    //   String filename = images[i].path.split('/').last;
    //   multipartFileList.add(
    //     MultipartFile.fromFileSync(
    //       images[i].path,
    //       filename: filename,
    //     ),
    //   );
    // }

    animationController.forward();
    OperationReply operationReply =
        await APIProvider.instance.post<StartParkingResponse>(
      endPoint: Res.apiStartParking,
      fromJson: StartParkingResponse.fromJson,
      requestBody: {
        'user_id': userId,
      },
      // files: images
      //     .map((element) => MapEntry(element.path.split("/").last, element))
      //     .toList(),
      files: images.map((element) => MapEntry('files', element)).toList(),
    );
    animationController.reverse();
    if (operationReply.isSuccess()) {
      StartParkingResponse startParkingResponse = operationReply.result;
      Utils().playSound();
      InformationViewer.showSuccessToast(
        msg: startParkingResponse.message ?? '',
      );
      Get.find<CurrentParkingController>().refreshApiCall();
      setState(() {
        customer = startParkingResponse.data?.user;
      });
    } else {
      Get.back();
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
