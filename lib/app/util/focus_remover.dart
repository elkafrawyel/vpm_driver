import 'package:flutter/material.dart';

///makes sure when you tap outside any input field it loses focus
class FocusRemover extends StatelessWidget {
  final Widget _child;

  const FocusRemover({Key? key, required Widget child})
      : _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _child,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}
