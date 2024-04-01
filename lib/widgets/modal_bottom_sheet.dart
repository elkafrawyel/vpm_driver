import 'package:flutter/cupertino.dart';

///  this scroll controller must provide to SingleChildScrollView so it
///  can scroll on keyboard opening or user actions

Future showAppModalBottomSheet({
  required BuildContext context,
  required ScrollableWidgetBuilder builder,
  double initialChildSize = 0.5,
  double minChildSize = 0.4,
  double maxChildSize = 0.9,
}) async {
  await showCupertinoModalPopup(
    context: context,
    // isScrollControlled: true,
    // backgroundColor: Colors.transparent,
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          maxChildSize: maxChildSize,
          minChildSize: minChildSize,
          initialChildSize: initialChildSize,
          builder: builder,
        ),
      ),
    ),
  );
}
