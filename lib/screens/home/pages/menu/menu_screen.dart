import 'package:driver/app/extensions/space.dart';
import 'package:driver/widgets/app_widgets/app_cached_image.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../../../data/providers/storage/local_provider.dart';
import '../../../../widgets/app_widgets/app_dialog.dart';
import '../../../../widgets/app_widgets/language_views/app_language_switch.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('menu'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            50.ph,
            const Center(
              child: AppCachedImage(
                imageUrl:
                    'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                isCircular: true,
                width: 140,
                height: 140,
                borderColor: Colors.black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: AppText(
                'Mahmoud Ashraf',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              title: AppText(
                'profile'.tr,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.stars,
                    color: Colors.white,
                  ),
                ),
              ),
              title: AppText(
                'rewards'.tr,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              trailing: AppText(
                "300 ${'point'.tr}",
                fontWeight: FontWeight.w800,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
              ),
              title: AppText(
                'notifications'.tr,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
            ListTile(
              splashColor: Colors.transparent,
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                ),
              ),
              title: AppText(
                'language'.tr,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              trailing: const AppLanguageSwitch(),
              onTap: () {},
            ),
            ListTile(
              onTap: () {
                scaleAlertDialog(
                  context: context,
                  title: 'logout'.tr,
                  body: 'logout_message'.tr,
                  cancelText: 'cancel'.tr,
                  confirmText: 'submit'.tr,
                  barrierDismissible: true,
                  onCancelClick: () {
                    Get.back();
                  },
                  onConfirmClick: () async {
                    Get.back();
                    _logout();
                  },
                );
              },
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
              title: AppText(
                'logout'.tr,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    EasyLoading.show();

    // OperationReply operationReply = await AuthRepositoryIml().logOut();
    // if (operationReply.isSuccess()) {
    //   GeneralResponse generalResponse = operationReply.result;
    //   EasyLoading.dismiss();
    //   InformationViewer.showSnackBar(generalResponse.message);
    //   await Future.delayed(const Duration(milliseconds: 500));
    await LocalProvider().signOut();
    EasyLoading.dismiss();
    // } else {
    //   InformationViewer.showSnackBar(operationReply.message);
    // }
  }
}
