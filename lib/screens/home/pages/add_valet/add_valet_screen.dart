import 'dart:io';

import 'package:driver/app/extensions/space.dart';
import 'package:driver/data/models/user_model.dart';
import 'package:driver/screens/scanner/scanner_screen.dart';
import 'package:driver/widgets/app_widgets/app_cached_image.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/config/app_color.dart';

class AddValetScreen extends StatefulWidget {
  const AddValetScreen({Key? key}) : super(key: key);

  @override
  State<AddValetScreen> createState() => _AddValetScreenState();
}

class _AddValetScreenState extends State<AddValetScreen>
    with AutomaticKeepAliveClientMixin {
  UserModel? customer;
  List<File> images = [];
  final ImagePicker picker = ImagePicker();

  reset() {
    setState(() {
      customer = null;
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
              child: IconButton(
                onPressed: () async {
                  customer = await Get.to(() => const ScannerScreen());
                  if (customer != null) {
                    setState(() {});
                  }
                },
                icon: const Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.black,
                  size: 220,
                ),
              ),
            ),
            Offstage(
              offstage: customer != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
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
            )
            // Wrap(
            //   spacing: 10,
            //   runSpacing: 10,
            //   children: images
            //       .map((e) => Container(
            //             width: 100,
            //             height: 100,
            //             alignment: AlignmentDirectional.topEnd,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(kRadius),
            //               image: DecorationImage(
            //                 image: FileImage(e),
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //             child: IconButton(
            //               icon: const Icon(
            //                 Icons.clear,
            //                 color: Colors.red,
            //               ),
            //               onPressed: () {
            //                 setState(() {
            //                   images.remove(e);
            //                 });
            //               },
            //             ),
            //           ))
            //       .toList(),
            // ),
            // 20.ph,
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 28.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.black,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8))),
            //     onPressed: () async {
            //       if (images.length > 4) {
            //         InformationViewer.showSnackBar('max_image_count_is_5'.tr);
            //         return;
            //       }
            //       final XFile? photo =
            //           await picker.pickImage(source: ImageSource.camera);
            //       if (photo != null) {
            //         setState(() {
            //           images.add(File(photo.path));
            //         });
            //       }
            //     },
            //     child: Row(
            //       mainAxisSize: MainAxisSize.max,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         const Icon(Icons.camera),
            //         20.pw,
            //         AppText(
            //           'take_photo'.tr,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 28.0),
            //   child: Align(
            //     alignment: AlignmentDirectional.centerStart,
            //     child: AppText('max_image_count_is_5'.tr),
            //   ),
            // ),
            // 10.ph,
            // Padding(
            //   padding: const EdgeInsets.all(28.0),
            //   child: AppProgressButton(
            //     text: 'add'.tr,
            //     textColor: Colors.white,
            //     width: MediaQuery.sizeOf(context).width,
            //     backgroundColor: Colors.black,
            //     onPressed: addPhotosToRequest,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future addPhotosToRequest(AnimationController animationController) async {}
}
