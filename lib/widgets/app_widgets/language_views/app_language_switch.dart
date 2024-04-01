import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../app/util/language/language_data.dart';
import '../../../data/providers/storage/local_provider.dart';

class AppLanguageSwitch extends StatefulWidget {
  const AppLanguageSwitch({super.key});

  @override
  State<AppLanguageSwitch> createState() => _AppLanguageSwitchState();
}

class _AppLanguageSwitchState extends State<AppLanguageSwitch> {
  int index = LocalProvider().isAr() ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ToggleSwitch(
          minWidth: 70.0,
          initialLabelIndex: index,
          cornerRadius: 8.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey.shade500,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          labels: LanguageData.languageList().map((e) => e.name).toList(),
          activeBgColors: [
            [Colors.black],
            [Colors.black],
          ],
          onToggle: (int? index) async {
            if (index == null) {
              return;
            }
            await LanguageData.changeLanguage(
              LanguageData.languageList()[index],
            );
            setState(() {
              this.index = index;
            });
          },
        ),
      ),
    );
  }
}
