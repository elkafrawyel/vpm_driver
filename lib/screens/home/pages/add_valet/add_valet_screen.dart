import 'dart:io';

import 'package:driver/app/extensions/space.dart';
import 'package:driver/app/util/constants.dart';
import 'package:driver/app/util/information_viewer.dart';
import 'package:driver/screens/scanner/scanner_screen.dart';
import 'package:driver/widgets/app_widgets/app_cached_image.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/app_widgets/app_progress_button.dart';

class AddValetScreen extends StatefulWidget {
  const AddValetScreen({Key? key}) : super(key: key);

  @override
  State<AddValetScreen> createState() => _AddValetScreenState();
}

class _AddValetScreenState extends State<AddValetScreen> {
  String? username;
  List<File> images = [];
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: AppText(
                  'scan_owner'.tr,
                  maxLines: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  centerText: true,
                ),
              ),
              IconButton(
                onPressed: () async {
                  String? code = await Get.to(() => const ScannerScreen());
                  if (code != null) {
                    setState(() {
                      username = code;
                    });
                  }
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.black,
                  size: 100,
                ),
              ),
              if (username != null)
                ListTile(
                  leading: const AppCachedImage(
                    imageUrl:
                        'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                    isCircular: true,
                    width: 60,
                    height: 60,
                    borderColor: Colors.black,
                  ),
                  title: AppText(
                    username ?? 'Mahmoud Ashraf',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              20.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
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
                      20.pw,
                      AppText(
                        'take_photo'.tr,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText('max_image_count_is_5'.tr),
                ),
              ),
              20.ph,
              Wrap(
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
              10.ph,
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: AppProgressButton(
                  text: 'add'.tr,
                  textColor: Colors.white,
                  width: MediaQuery.sizeOf(context).width,
                  backgroundColor: Colors.black,
                  onPressed: (animationController) async {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
