import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:vibration/vibration.dart';

import '../../../../app/config/app_color.dart';
import '../../../../app/util/constants.dart';
import 'custom_shake_widget.dart';

class AppPhoneTextField extends StatefulWidget {
  const AppPhoneTextField({super.key, required this.onChanged});

  final Function(PhoneNumber phoneNumber) onChanged;

  @override
  State<AppPhoneTextField> createState() => AppPhoneTextFieldState();
}

class AppPhoneTextFieldState extends State<AppPhoneTextField> {
  final GlobalKey<CustomShakeWidgetState> _shakerKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();

  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).primaryColor;

    return CustomShakeWidget(
      key: _shakerKey,
      shakeCount: 4,
      shakeOffset: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius),
          ),
          child: IntlPhoneField(
            controller: phoneController,
            focusNode: _focusNode,
            initialCountryCode: 'SA',
            // languageCode: LocalProvider().isAr() ? 'ar' : 'en',
            cursorColor: Theme.of(context).primaryColor,
            showDropdownIcon: true,
            invalidNumberMessage: 'valid_phone'.tr,
            textInputAction: TextInputAction.next,
            pickerDialogStyle: PickerDialogStyle(
              listTilePadding: const EdgeInsets.symmetric(horizontal: 20),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              searchFieldCursorColor: Theme.of(context).primaryColor,
              countryNameStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 16),
              searchFieldInputDecoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'search'.tr,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12,
                ),
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(kRadius),
                //   borderSide: BorderSide(
                //     width: kSelectedBorderWidth,
                //     color: borderColor,
                //   ),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius),
                  borderSide: BorderSide(
                    width: kBorderWidth,
                    color: borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius),
                  borderSide: BorderSide(
                    width: kSelectedBorderWidth,
                    color: borderColor,
                  ),
                ),
                fillColor: Colors.black,
              ),
              padding: const EdgeInsets.all(12.0),
              countryCodeStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),

            disableLengthCheck: true,
            flagsButtonPadding: const EdgeInsetsDirectional.only(start: 8),
            dropdownTextStyle: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(
              hintText: 'phone'.tr,
              disabledBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius),
                borderSide: BorderSide(
                  width: kBorderWidth,
                  color: borderColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius),
                borderSide: BorderSide(
                  width: kBorderWidth,
                  color: borderColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius),
                borderSide: BorderSide(
                  width: kSelectedBorderWidth,
                  color: errorColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius),
                borderSide: BorderSide(
                  width: kSelectedBorderWidth,
                  color: borderColor,
                ),
              ),
              fillColor: editableColor,
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }

  Future shake() async {
    _focusNode.requestFocus();
    _shakerKey.currentState?.shake();
    if ((await Vibration.hasVibrator()) ?? false) {
      Vibration.vibrate();
    }
  }
}
