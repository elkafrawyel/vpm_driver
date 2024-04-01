
import 'package:flutter/material.dart';

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
        FocusScope.of(context).unfocus();
      },
    );
  }
}
