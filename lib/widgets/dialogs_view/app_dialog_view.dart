import 'package:driver/app/extensions/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/util/constants.dart';
import '../app_widgets/app_text.dart';

// Get.dialog(
//   AppDialogView(
//     svgName: Res.iconSuccess,
//     title: 'Congratulations!',
//     message: 'Your account is ready to use',
//     actionText: 'Go to Homepage',
//     onActionClicked: () {},
//   ),
// );

// Get.dialog(
//   AppDialogView(
//     svgName: Res.iconLocation,
//     title: 'Congratulations!',
//     message: 'Your account is ready to use',
//     actionText: 'Go to Homepage',
//     onActionClicked: () {},
//   ),
// );

// Get.dialog(
// AppDialogView(
// svgName: Res.iconPhoneVerified,
// title: 'Congratulations!',
// message: 'Your account is ready to use',
// actionText: 'Go to Homepage',
// onActionClicked: () {},
// ),
// );
class AppDialogView extends StatelessWidget {
  final String svgName;
  final String title;
  final String message;
  final String actionText;
  final VoidCallback onActionClicked;

  const AppDialogView({
    super.key,
    required this.svgName,
    required this.title,
    required this.message,
    required this.actionText,
    required this.onActionClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(
        vertical: 200,
        horizontal: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: SvgPicture.asset(svgName)),
              20.ph,
              AppText(
                title,
                fontSize: 24,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
              10.ph,
              AppText(
                message,
                fontSize: 16,
                maxLines: 3,
                centerText: true,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              20.ph,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 50,
                child: ElevatedButton(
                  onPressed: onActionClicked.call,
                  child: AppText(
                    actionText,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
