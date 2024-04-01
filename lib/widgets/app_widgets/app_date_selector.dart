import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:driver/app/extensions/space.dart';

import '../../../app/config/app_color.dart';
import '../../../app/util/constants.dart';
import 'app_text.dart';

class AppDateSelector extends StatefulWidget {
  final DateTime? value;
  final Function(DateTime? date) onChanged;
  final DateTime? selectedDate;
  final String dateFormat;
  final bool withTime;
  final String? validationText;
  final String hint;
  final bool allowFutureDates;

  const AppDateSelector({
    Key? key,
    required this.hint,
    required this.onChanged,
    this.validationText,
    this.value,
    this.selectedDate,
    this.dateFormat = 'yyyy-MM-dd',
    this.withTime = false,
    this.allowFutureDates = false,
  }) : super(key: key);

  @override
  State<AppDateSelector> createState() => AppDateSelectorState();
}

class AppDateSelectorState extends State<AppDateSelector> {
  DateTime? selectedDate;
  FormFieldState<Object?>? formFieldState;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return widget.validationText;
        } else {
          return null;
        }
      },
      builder: (formFieldState) {
        this.formFieldState = formFieldState;
        bool hasError =
            formFieldState.hasError && widget.validationText != null;

        return GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius),
                  color: editableColor,
                  border: Border.all(
                    width: .3,
                    color:
                        hasError ? Colors.red : Theme.of(context).primaryColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    8.pw,
                    const Icon(Icons.date_range),
                    8.pw,
                    AppText(
                      widget.hint,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        _formatSelectedDate(selectedDate),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasError)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12, top: 10),
                  child: Text(
                    '${formFieldState.errorText} *',
                    style: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      color: errorColor,
                    ),
                  ),
                )
            ],
          ),
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
            _selectIosDate(context);
          },
        );
      },
    );
  }

  void _selectIosDate(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Get.isDarkMode ? Brightness.dark : Brightness.light,
          textTheme: CupertinoTextThemeData(
              primaryColor: Theme.of(context).primaryColor),
          // scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          primaryContrastingColor: Theme.of(context).primaryColor,
        ),
        child: CupertinoActionSheet(
          cancelButton: CupertinoButton(
            onPressed: Get.back,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: AppText(
              'save'.tr,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: 200,
              child: CupertinoDatePicker(
                mode: widget.withTime
                    ? CupertinoDatePickerMode.dateAndTime
                    : CupertinoDatePickerMode.date,
                minimumDate: DateTime(1950),
                maximumDate: widget.allowFutureDates
                    ? DateTime(2050)
                    : DateTime.now().add(
                        const Duration(seconds: 5),
                      ),
                initialDateTime: selectedDate,
                onDateTimeChanged: (DateTime picked) {
                  selectedDate = picked;
                  String date = _formatSelectedDate(selectedDate!);
                  widget.onChanged.call(picked);
                  // ignore: invalid_use_of_protected_member
                  formFieldState?.setValue(picked);
                  formFieldState?.validate();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSelectedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'MM-DD-YYYY';
    }
    return DateFormat(widget.dateFormat, (Get.locale?.languageCode ?? 'en'))
        .format(dateTime)
        .toString();
  }

  void reset() {
    selectedDate = null;
    // ignore: invalid_use_of_protected_member
    formFieldState?.setValue(null);
    formFieldState?.validate();
  }
}
