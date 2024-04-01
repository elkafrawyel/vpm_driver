import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math.dart' as math;

import 'app_text.dart';

Future<void> showAppDialog(
  BuildContext context,
  //preferred as Column
  Widget child, {
  double? height,
  Color? backgroundColor,
  double horizontalPadding = 12.0,
  double radius = 12.0,
  bool barrierDismissible = false,
  EdgeInsets contentPadding = const EdgeInsets.all(12.0),
}) async {
  await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      insetPadding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 0.0),
      contentPadding: contentPadding,
      content: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          height: height,
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
      ),
    ),
  );
}

void scaleDialog({
  required BuildContext context,
  required Widget content,
  String? title,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
  bool barrierDismissible = false,
  Color? backgroundColor,
  double? height,
  double horizontalMargin = 12.0,
  double radius = 12.0,
  EdgeInsets contentPadding = const EdgeInsets.all(12.0),
  int animationDuration = 400,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dialog',
    pageBuilder: (ctx, a1, a2) => Container(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: AlertDialog(
          backgroundColor:
              backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          insetPadding: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: 12.0),
          contentPadding: contentPadding,
          actions: <Widget>[
            if (onConfirmClick != null)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  confirmText ?? "Confirm",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            if (onCancelClick != null)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  cancelText ?? "Cancel",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700),
                ),
              )
          ],
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ??
                    Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              height: height,
              width: MediaQuery.of(context).size.width,
              child: content,
            ),
          ),
        ),
      );
    },
  );
}

void scaleAlertDialog({
  required BuildContext context,
  required String title,
  required String body,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
  bool barrierDismissible = false,
  int animationDuration = 400,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: title,
    pageBuilder: (ctx, a1, a2) => Container(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: GetPlatform.isIOS
            ? CupertinoAlertDialog(
                title: AppText(
                  title,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    body,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                actions: [
                  if (onConfirmClick != null)
                    TextButton(
                      onPressed: onConfirmClick,
                      child: Text(
                        confirmText ?? "Confirm",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (onCancelClick != null)
                    TextButton(
                      onPressed: onCancelClick,
                      child: Text(
                        cancelText ?? "Cancel",
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
                      ),
                    ),
                ],
              )
            : AlertDialog(
                title: AppText(
                  title,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
                content: AppText(
                  body,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                actions: <Widget>[
                  if (onConfirmClick != null)
                    TextButton(
                      onPressed: onConfirmClick,
                      child: Text(
                        confirmText ?? "Confirm",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  if (onCancelClick != null)
                    TextButton(
                      onPressed: onCancelClick,
                      child: Text(
                        cancelText ?? "Cancel",
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
                      ),
                    )
                ],
              ),
      );
    },
  );
}

void rotateDialog({
  required BuildContext context,
  required Widget content,
  String? title,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
  bool barrierDismissible = false,
  Color? backgroundColor,
  double? height,
  double horizontalMargin = 12.0,
  double radius = 12.0,
  EdgeInsets contentPadding = const EdgeInsets.all(12.0),
  int animationDuration = 400,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dialog',
    pageBuilder: (ctx, a1, a2) => Container(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (ctx, a1, a2, child) {
      return Transform.rotate(
        angle: math.radians(a1.value * 360),
        child: AlertDialog(
          backgroundColor:
              backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          insetPadding: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: 12.0),
          contentPadding: contentPadding,
          actions: <Widget>[
            if (onConfirmClick != null)
              TextButton(
                onPressed: onConfirmClick,
                child: Text(
                  confirmText ?? "Confirm",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            if (onCancelClick != null)
              TextButton(
                onPressed: onCancelClick,
                child: Text(
                  cancelText ?? "Cancel",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700),
                ),
              )
          ],
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ??
                    Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              height: height,
              width: MediaQuery.of(context).size.width,
              child: content,
            ),
          ),
        ),
      );
    },
  );
}

void translateDialog({
  required BuildContext context,
  required Widget content,
  Offset? startOffset,
  String? title,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
  bool barrierDismissible = false,
  Color? backgroundColor,
  double? height,
  double horizontalMargin = 12.0,
  double radius = 12.0,
  EdgeInsets contentPadding = const EdgeInsets.all(12.0),
  int animationDuration = 400,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dialog',
    pageBuilder: (ctx, a1, a2) => Container(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (ctx, a1, a2, child) {
      Offset begin = startOffset ?? const Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = a1.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: AlertDialog(
          backgroundColor:
              backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          insetPadding: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: 12.0),
          contentPadding: contentPadding,
          actions: <Widget>[
            if (onConfirmClick != null)
              TextButton(
                onPressed: onConfirmClick,
                child: Text(
                  confirmText ?? "Confirm",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            if (onCancelClick != null)
              TextButton(
                onPressed: onCancelClick,
                child: Text(
                  cancelText ?? "Cancel",
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w700),
                ),
              )
          ],
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ??
                    Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              height: height,
              width: MediaQuery.of(context).size.width,
              child: content,
            ),
          ),
        ),
      );
    },
  );
}
