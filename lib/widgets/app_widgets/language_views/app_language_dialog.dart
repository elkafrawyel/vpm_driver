import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/util/language/language_data.dart';
import '../app_text.dart';

showAppLanguageDialog({
  required BuildContext context,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => const _LanguageDialog(),
  );
}

class _LanguageDialog extends StatelessWidget {
  const _LanguageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
        textTheme: CupertinoTextThemeData(
            primaryColor: Theme.of(context).primaryColor),
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        primaryContrastingColor: Theme.of(context).primaryColor,
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
        actions: LanguageData.languageList()
            .map(
              (value) => CupertinoButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      // SvgPicture.asset(Res.iconLanguage),
                      Transform.scale(
                        scale: 2.5,
                        child: AppText(
                          value.flag,
                        ),
                      ),
                      const SizedBox(width: 30),
                      AppText(
                        value.name,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await LanguageData.changeLanguage(value);
                },
              ),
            )
            .toList(),
      ),
    );
  }


}
