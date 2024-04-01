import 'package:driver/app/extensions/space.dart';
import 'package:driver/app/res/res.dart';
import 'package:driver/controller/app_config_controller.dart';
import 'package:driver/widgets/app_widgets/app_progress_button.dart';
import 'package:driver/widgets/app_widgets/app_text.dart';
import 'package:driver/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<AppTextFormFieldState> emailState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> passwordState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('signIn'.tr),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 200,
            horizontal: 28.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Res.logoImage),
              30.ph,
              AppTextFormField(
                key: emailState,
                controller: emailController,
                hintText: 'email'.tr,
                validateEmptyText: 'email_is_required'.tr,
                appFieldType: AppFieldType.email,
              ),
              AppTextFormField(
                key: passwordState,
                controller: passwordController,
                hintText: 'password'.tr,
                validateEmptyText: 'password_is_required'.tr,
                appFieldType: AppFieldType.password,
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppText('forget_password?'.tr),
                  ),
                ),
              ),
              20.ph,
              AppProgressButton(
                text: 'signIn'.tr,
                textColor: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                backgroundColor: Colors.black,
                onPressed: (animationController) async {
                  _login(animationController);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login(AnimationController animationController) async {
    // if (emailController.text.isEmpty) {
    //   emailState.currentState?.shake();
    //   return;
    // } else if (passwordController.text.isEmpty) {
    //   passwordState.currentState?.shake();
    //   return;
    // } else {
    //   animationController.forward();
    //
      Get.find<AppConfigController>().isLoggedIn.value = true;
      // animationController.reverse();
    // }
  }
}
