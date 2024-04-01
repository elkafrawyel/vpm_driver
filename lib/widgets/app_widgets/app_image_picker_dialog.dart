import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/util/util.dart';
import 'app_text.dart';

showAppImageDialog({
  required BuildContext context,
  required Function(File image) onFilePicked,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => _ImagePickerDialog(
      onFilePicked: onFilePicked,
    ),
  );
}

class _ImagePickerDialog extends StatelessWidget {
  final Function(File image) onFilePicked;

  const _ImagePickerDialog({
    Key? key,
    required this.onFilePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        textTheme: CupertinoTextThemeData(primaryColor: Theme.of(context).primaryColor),
        // scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        primaryContrastingColor: Theme.of(context).primaryColor,
      ),
      child: CupertinoActionSheet(
        cancelButton: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: AppText(
            'close'.tr,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          CupertinoButton(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: <Widget>[
                Icon(CupertinoIcons.photo_camera_solid, color: Theme.of(context).primaryColor),
                const SizedBox(width: 20),
                AppText('camera'.tr, fontSize: 16, fontWeight: FontWeight.w700),
              ],
            ),
            onPressed: () async {
              Navigator.pop(context);
              File? imageFile = await _pickImage(gallery: false);
              if (imageFile != null) {
                onFilePicked(imageFile);
              }
            },
          ),
          CupertinoButton(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: <Widget>[
                Icon(Icons.insert_photo, color: Theme.of(context).primaryColor),
                const SizedBox(width: 20),
                AppText('gallery'.tr, fontSize: 16, fontWeight: FontWeight.w700),
              ],
            ),
            onPressed: () async {
              try {
                Navigator.pop(context);
                File? imageFile = await _pickImage();
                if (imageFile != null) {
                  onFilePicked(imageFile);
                }
              } catch (e) {
                Utils.logMessage(e.toString());
              }
            },
          ),
        ],
      ),
    );
  }

  Future<File?> _pickImage({bool gallery = true}) async {
    XFile? media;
    if (gallery) {
      media = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      media = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    if (media != null) {
      return File(media.path);
    } else {
      return null;
    }
  }
}
