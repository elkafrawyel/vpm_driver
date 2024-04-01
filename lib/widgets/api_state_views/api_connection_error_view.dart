import 'package:driver/app/extensions/space.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app/config/app_color.dart';
import '../../../app/res/res.dart';
import '../app_widgets/app_text.dart';

class ApiConnectionErrorView extends StatelessWidget {
  final Function()? retry;

  const ApiConnectionErrorView({Key? key, this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(Res.animDisconnect),
            const AppText(
              'Make sure you connected to a network',
              color: hintColor,
              fontSize: 16,
            ),
            30.ph,
            ElevatedButton(
              onPressed: retry,
              style: ElevatedButton.styleFrom(
                backgroundColor: hintColor,
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
      ),
    );
  }
}
