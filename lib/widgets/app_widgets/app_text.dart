import 'package:flutter/material.dart';

import '../../../app/res/res.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final bool centerText;
  final int maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool lineThrough;
  final bool underLine;

  const AppText(
    this.text, {
    this.color,
    this.centerText = false,
    this.maxLines = 1,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.lineThrough = false,
    this.underLine = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: Res.appFontFamily,
        fontWeight: fontWeight,
        decoration: lineThrough
            ? TextDecoration.lineThrough
            : underLine
                ? TextDecoration.underline
                : TextDecoration.none,
        decorationThickness: 1,
        decorationColor: color ?? Colors.black,
      ),
    );
  }
}
