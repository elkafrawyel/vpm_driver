import 'package:driver/app/extensions/space.dart';
import 'package:driver/app/res/res.dart';
import 'package:driver/app/util/constants.dart';
import 'package:driver/screens/auth/login_screen.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Res.splashBgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black38,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText(
                  'splash_message'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                10.ph,
                AppText(
                  'lets_go'.tr,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                30.ph,
                GestureDetector(
                  onTap: (){
                    Get.offAll(()=>const LoginScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadius),
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      color: Colors.black
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 8.0,
                      ),
                      child: AppText(
                        'signIn'.tr,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
