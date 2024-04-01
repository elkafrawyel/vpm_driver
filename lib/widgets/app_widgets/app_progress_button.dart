import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/util/util.dart';
import 'app_text.dart';

class AppProgressButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? progressIndicatorColor;
  final bool? isBordered;
  final Color? textColor;
  final double? fontSize;
  final double? radius;
  final double? elevation;
  final EdgeInsets? padding;
  final Future Function(AnimationController animationController) onPressed;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const AppProgressButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.child,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isBordered = false,
    this.height,
    this.progressIndicatorColor,
    this.radius,
    this.elevation,
    this.padding,
    this.fontFamily,
    this.fontWeight,
  }) : super(key: key);

  @override
  State<AppProgressButton> createState() => AppProgressButtonState();
}

class AppProgressButtonState extends State<AppProgressButton>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<BorderRadiusGeometry?> radiusAnimation;

  late double buttonHeight;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          // TODO: Handle this case.
          break;
        case AnimationStatus.forward:

          /// here we are reversing the state of the animation controller
          /// to reserve the initial state of the animation controller in
          ///  case of exception
          Future.delayed(const Duration(seconds: 5), () {
            try {
              if (mounted) {
                controller.reverse();
              }
            } catch (e) {
              Utils.logMessage(e.toString());
            }
          });
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          // TODO: Handle this case.
          break;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buttonHeight = widget.height ?? 45;

    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    sizeAnimation = Tween<double>(
      begin: widget.width ?? 200,
      end: buttonHeight,
    ).animate(curvedAnimation);

    radiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(widget.radius ?? 12.0),
      end: BorderRadius.circular(50),
    ).animate(curvedAnimation);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        constraints: BoxConstraints(minWidth: buttonHeight),
        width: sizeAnimation.value,
        height: buttonHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: widget.elevation,
            backgroundColor: widget.backgroundColor ??
                Theme.of(context).primaryColor, //background color
            shape: RoundedRectangleBorder(
                borderRadius: radiusAnimation.value!,
                side: !widget.isBordered!
                    ? BorderSide.none
                    : BorderSide(color: Theme.of(context).primaryColor)),
          ),
          onPressed: () async {
            try {
              if (controller.isCompleted) return;
              widget.onPressed(controller);
            } catch (e) {
              if (kDebugMode) {
                print(e.toString());
              }
            }
          },
          child: controller.isCompleted
              ? Center(
                  child: OverflowBox(
                    maxWidth: buttonHeight,
                    maxHeight: buttonHeight,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GetPlatform.isIOS
                            ? CupertinoActivityIndicator(
                                color: widget.textColor ?? Colors.white)
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  widget.textColor ?? Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                )
              : FittedBox(
                  child: widget.child ??
                      AppText(
                        widget.text ?? 'Click Me',
                        color: widget.textColor,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                      ),
                ),
        ),
      ),
    );
  }
}
