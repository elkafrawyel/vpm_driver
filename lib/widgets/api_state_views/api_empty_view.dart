import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../app/config/app_color.dart';
import '../../../app/res/res.dart';
import '../app_widgets/app_text.dart';

class ApiEmptyView extends StatelessWidget {
  final String emptyText;

  const ApiEmptyView({
    Key? key,
    required this.emptyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Lottie.asset(Res.animApiEmpty, height: 400),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: AppText(
                emptyText,
                color: hintColor,
                fontSize: 18,
                maxLines: 3,
                centerText: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
