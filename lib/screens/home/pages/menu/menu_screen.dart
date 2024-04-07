import 'package:driver/app/extensions/space.dart';
import 'package:driver/app/res/res.dart';
import 'package:driver/data/providers/network/api_provider.dart';
import 'package:driver/widgets/app_widgets/app_cached_image.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../../../app/util/information_viewer.dart';
import '../../../../app/util/operation_reply.dart';
import '../../../../data/models/general_response.dart';
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
            Center(
              child: AppCachedImage(
                imageUrl: LocalProvider().getUser()?.avatar?.filePath ?? '',
                isCircular: true,
                width: 140,
                height: 140,
                borderColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                LocalProvider().getUser()?.name ?? '',
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

    OperationReply operationReply =
        await APIProvider.instance.post<GeneralResponse>(
      endPoint: Res.apiLogout,
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );
    EasyLoading.dismiss();

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSnackBar(generalResponse.message);
      await Future.delayed(const Duration(milliseconds: 500));
      await LocalProvider().signOut();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
