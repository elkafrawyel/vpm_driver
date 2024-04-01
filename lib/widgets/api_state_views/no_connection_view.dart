import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app/res/res.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAr = Get.locale?.languageCode == 'ar';

    return WillPopScope(
      onWillPop: () async {
        var connectivityResult = await (Connectivity().checkConnectivity());
        bool isConnected = connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi;
        return Future.value(isConnected);
        // return Future.value(true);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Lottie.asset(Res.animDisconnect, width: 200, height: 200),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                isAr ? 'لا يوجد اتصال بالانترنت!' : 'No Internet Connection !',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
                isAr
                    ? 'الرجاء التحقق من اتصال الانترنت الخاص بك'
                    : 'Please Check Your Internet Connection',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: AppElevatedButton(
            //     text: isAr ? 'أعادة المحاولة ' : 'Retry',
            //     onPressed: () async {
            //       var connectivityResult = await (Connectivity().checkConnectivity());
            //       if (connectivityResult == ConnectivityResult.mobile ||
            //           connectivityResult == ConnectivityResult.wifi) {
            //         SharedMethods.hideGetXDialog();
            //         Get.offAll(HomeScreen(), binding: GetBinding());
            //       } else {
            //         InformationViewer.showErrorToast(
            //             msg: isAr ? 'لا يوجد اتصال بالانترنت!' : 'No Internet Connection !');
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
