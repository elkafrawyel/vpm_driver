import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/app_color.dart';
import 'app_widgets/app_text.dart';

showAppSelectorDialog<T>({
  required BuildContext context,
  required Function(T item) onItemSelected,
  required List<T> items,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => _AppSelectorDialog(
      onItemSelected: onItemSelected,
      items: items,
    ),
  );
}

class _AppSelectorDialog<T> extends StatelessWidget {
  final Function(T item) onItemSelected;
  final List<T> items;

  const _AppSelectorDialog({
    Key? key,
    required this.onItemSelected,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? textColor = Theme.of(context).primaryColor;

    return CupertinoTheme(
      data: CupertinoThemeData(
        primaryContrastingColor: editableColor,
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: CupertinoActionSheet(
        cancelButton: CupertinoButton(
          color: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () => Navigator.pop(context),
          child: AppText(
            'close'.tr,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
        ),
        actions: items
            .map(
              (item) => CupertinoButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                pressedOpacity: 0.4,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText(
                    item.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                onPressed: () async {
                  onItemSelected(item);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
