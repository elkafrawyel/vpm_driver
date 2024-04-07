import 'package:driver/app/extensions/space.dart';
import 'package:driver/widgets/app_widgets/app_progress_button.dart';
import 'package:driver/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forget_password'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              (MediaQuery.sizeOf(context).height * 0.3).ph,
              AppTextFormField(
                controller: emailController,
                hintText: 'email',
                validateEmptyText: 'email_required'.tr,
              ),
              AppProgressButton(
                text: 'submit'.tr,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                onPressed: (animationController) async {},
              ),
              (MediaQuery.sizeOf(context).height * 0.3).ph,
            ],
          ),
        ),
      ),
    );
  }
}
