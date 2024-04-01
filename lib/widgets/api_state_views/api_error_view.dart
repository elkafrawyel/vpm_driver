import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:driver/app/extensions/space.dart';

import '../../../app/config/app_color.dart';
import '../../../app/res/res.dart';
import '../app_widgets/app_text.dart';

class ApiErrorView extends StatelessWidget {
  final String errorText;
  final Function()? retry;

  const ApiErrorView({Key? key, required this.errorText, this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(Res.animApiError),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: AppText(
                errorText,
                color: hintColor,
                fontSize: 18,
                maxLines: 3,
                centerText: true,
              ),
            ),
          ),
          30.ph,
          ElevatedButton(
            onPressed: retry,
            style: ElevatedButton.styleFrom(
              backgroundColor: errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
              child: AppText('Try Again'),
            ),
          )
        ],
      ),
    );
  }
}
