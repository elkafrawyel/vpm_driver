import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app/res/res.dart';

class ApiLoadingView extends StatelessWidget {
  const ApiLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(Res.animApiLoading),
          // AppText(
          //   errorText,
          //   color: hintColor,
          //   fontSize: 18,
          // ),
          // 30.ph,
          // ElevatedButton(
          //   onPressed: retry,
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: errorColor,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: const Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
          //     child: AppText('Try Again'),
          //   ),
          // )
        ],
      ),
    );
  }
}
