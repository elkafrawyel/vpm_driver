import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:driver/app/res/res.dart';

import '../../../app/config/app_color.dart';
import 'app_text.dart';

enum AppGender { male, female }

extension GenderItem on AppGender {
  String get title {
    switch (this) {
      case AppGender.male:
        return 'male'.tr;
      case AppGender.female:
        return 'female'.tr;
    }
  }

  dynamic get value {
    switch (this) {
      case AppGender.male:
        return 0;
      case AppGender.female:
        return 1;
    }
  }

  String get assetName {
    switch (this) {
      case AppGender.male:
        return Res.iconMale;
      case AppGender.female:
        return Res.iconFemale;
    }
  }
}

showAppGenderDialog({
  required BuildContext context,
  required Function(AppGender gender) onGenderPicked,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => _GenderPickerDialog(
      onGenderPicked: onGenderPicked,
    ),
  );
}

class _GenderPickerDialog extends StatelessWidget {
  final Function(AppGender gender) onGenderPicked;

  const _GenderPickerDialog({
    Key? key,
    required this.onGenderPicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? textColor = Theme.of(context).primaryColor;

    return CupertinoTheme(
      data: CupertinoThemeData(
        primaryContrastingColor: editableColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: CupertinoActionSheet(
        cancelButton: CupertinoButton(
          color: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () => Navigator.pop(context),
          child: AppText(
            'close'.tr,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
        ),
        actions: AppGender.values
            .map(
              (gender) => CupertinoButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                pressedOpacity: 0.4,
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      gender.assetName,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 20),
                    AppText(
                      gender.title,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ],
                ),
                onPressed: () async {
                  onGenderPicked(gender);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
