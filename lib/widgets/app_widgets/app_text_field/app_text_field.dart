import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:vibration/vibration.dart';

import '../../../../app/config/app_color.dart';
import '../../../../app/res/res.dart';
import '../../../../app/util/constants.dart';
import '../app_text.dart';
import 'auth_form_rules.dart';
import 'custom_shake_widget.dart';

enum AppFieldType {
  text,
  id,
  name,
  email,
  password,
  confirmPassword,
  phone,
  swiftCode,
  bankNumber,
}

class AppTextFormField extends StatefulWidget {
  final Color? backgroundColor;
  final String? hintText;
  final String? text;
  final String? validateEmptyText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? labelText;
  final String? suffixText;
  final bool required;
  final bool? showLabel;
  final Color? hintColor;
  final Color? labelColor;
  final Color? textColor;
  final IconData? suffixIcon;
  final String? prefixIcon;
  final Color? suffixIconColor;
  final bool enabled;
  final List<String>? autoFillHints;
  final double? radius;
  final double? horizontalPadding;
  final double verticalPadding;
  final Function(String value)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(String value)? onFieldSubmitted;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final AppFieldType appFieldType;

  final bool checkRules;
  final bool alwaysShowRules;

  const AppTextFormField({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.backgroundColor,
    this.hintText,
    this.text,
    this.validateEmptyText,
    this.maxLines,
    this.maxLength,
    this.labelText,
    this.suffixText,
    this.hintColor,
    this.labelColor,
    this.textColor,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.autoFillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.radius = 8,
    this.showLabel = false,
    this.suffixIconColor,
    this.horizontalPadding,
    this.verticalPadding = 12,
    this.fillColor,
    this.textInputAction,
    this.appFieldType = AppFieldType.text,
    this.checkRules = true,
    this.required = true,
    this.alwaysShowRules = false,
  }) : super(key: key);

  @override
  AppTextFormFieldState createState() => AppTextFormFieldState();
}

class AppTextFormFieldState extends State<AppTextFormField> {
  bool _isSecure = false;
  bool _isPasswordField = false;
  String? _helperText;
  FormFieldState<Widget>? formFieldState;
  bool hasError = false;
  final GlobalKey<CustomShakeWidgetState> _shakerKey = GlobalKey();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isPasswordField = AppFieldType.password == widget.appFieldType ||
        AppFieldType.confirmPassword == widget.appFieldType;
    _isSecure = _isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).primaryColor;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding ?? 8.0,
        vertical: 8.0,
      ),
      child: CustomShakeWidget(
        key: _shakerKey,
        shakeCount: 4,
        shakeOffset: 10,
        child: FormField<Widget>(
          builder: (formFieldState) {
            this.formFieldState = formFieldState;
            // hasError = formFieldState.value != null && widget.controller.text.isNotEmpty && widget.required;
            // print('error: ' + widget.controller.text + '   ' + hasError.toString());
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  obscureText: _isSecure,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.textColor,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: widget.controller,
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  validator: (String? value) {
                    if (!widget.required) {
                      return null;
                    } else if (value == null || value.isEmpty) {
                      return !widget.required
                          ? null
                          : (widget.validateEmptyText ?? 'field_required'.tr);
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String? value) {
                    if (widget.onChanged != null && value != null) {
                      widget.onChanged!(value);
                    }

                    if (value == null || !widget.checkRules) {
                      return;
                    }

                    switch (widget.appFieldType) {
                      case AppFieldType.text:
                        break;
                      case AppFieldType.name:
                        _validateRules(value, nameRules);
                        break;
                      case AppFieldType.email:
                        _validateRules(value, emailRules);
                        break;
                      case AppFieldType.password:
                        _validateRules(value, passwordRules);
                        break;
                      case AppFieldType.id:
                        _validateRules(value, idRules);
                        break;
                      case AppFieldType.confirmPassword:
                        break;
                      case AppFieldType.phone:
                        _validateRules(value, phoneNumberRules);
                        break;
                      case AppFieldType.swiftCode:
                        _validateRules(value, swiftCodeRules);
                        break;
                      case AppFieldType.bankNumber:
                        _validateRules(value, bankNumberRules);
                        break;
                    }
                  },
                  textInputAction: widget.textInputAction,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  autofillHints: widget.autoFillHints,
                  onEditingComplete: widget.onEditingComplete,
                  autovalidateMode: AutovalidateMode.disabled,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.start,
                  maxLines: _isPasswordField ? 1 : widget.maxLines,
                  maxLength: widget.maxLength,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 2,
                  decoration: InputDecoration(
                    helperText:
                        (_helperText?.isEmpty ?? true) ? null : _helperText,
                    helperMaxLines: 4,
                    helperStyle: const TextStyle(
                      color: errorColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    labelText: widget.showLabel! ? widget.labelText : null,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontFamily: Res.appFontFamily),
                    hintText: widget.hintText ?? '',
                    fillColor: widget.fillColor ?? Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: hintColor,
                          fontFamily: Res.appFontFamily,
                        ),

                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    alignLabelWithHint: true,
                    prefixIcon: widget.prefixIcon != null
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 15.0,
                              end: 8,
                              top: 15,
                              bottom: 15,
                            ),
                            child: SvgPicture.asset(
                              widget.prefixIcon!,
                              fit: BoxFit.fitHeight,
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                hintColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : null,
                    suffixText: widget.suffixText ?? '',
                    suffixStyle: Theme.of(context).textTheme.titleMedium,
                    suffixIcon: widget.suffixIcon != null || _isPasswordField
                        ? GestureDetector(
                            onTap: _isPasswordField ? _toggle : null,
                            child: Icon(
                              _isPasswordField
                                  ? _isSecure
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off
                                  : widget.suffixIcon,
                              size: 20,
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    enabled: widget.enabled,
                    errorStyle: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: errorColor,
                      fontFamily: Res.appFontFamily,
                    ),
                    // disabledBorder:
                    //     const OutlineInputBorder(borderSide: BorderSide.none),
                    // enabledBorder: !widget.enabled
                    //     ? const OutlineInputBorder(borderSide: BorderSide.none)
                    //     : OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.circular(widget.radius ?? kRadius),
                    //         borderSide: BorderSide(
                    //           width: kBorderWidth,
                    //           color: borderColor,
                    //         ),
                    //       ),
                    // border: !widget.enabled
                    //     ? const OutlineInputBorder(borderSide: BorderSide.none)
                    //     : OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.circular(widget.radius ?? kRadius),
                    //         borderSide: BorderSide(
                    //           width: kBorderWidth,
                    //           color: borderColor,
                    //         ),
                    //       ),
                    // errorBorder: OutlineInputBorder(
                    //   borderRadius:
                    //       BorderRadius.circular(widget.radius ?? kRadius),
                    //   borderSide: BorderSide(
                    //     width: kSelectedBorderWidth,
                    //     color: errorColor,
                    //   ),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius:
                    //       BorderRadius.circular(widget.radius ?? kRadius),
                    //   borderSide: BorderSide(
                    //     width: kSelectedBorderWidth,
                    //     color: borderColor,
                    //   ),
                    // ),
                  ),
                ),
                if (hasError) formFieldState.value ?? const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  bool validate() {
    if (widget.controller.text.isEmpty || hasError) {
      shake();
      return false;
    } else {
      return true;
    }
  }

  void _toggle() {
    setState(() {
      _isSecure = !_isSecure;
    });
  }

  void updateHelperText(String text) {
    setState(() {
      _helperText = text;
    });
  }

  Future shake() async {
    _shakerKey.currentState?.shake();
    _focusNode.requestFocus();
    if ((await Vibration.hasVibrator()) ?? false) {
      Vibration.vibrate();
    }
  }

  _validateRules(String value, List<AuthFormRule> rules) {
    if (!widget.required) {
      return;
    }
    List<Widget>? errors = [];

    for (var element in rules) {
      final text = AppText(
        element.ruleText,
        color: element.condition(value) ? Colors.green : errorColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
      if (widget.alwaysShowRules && element.condition(value)) {
        errors.add(text);
      } else if (element.condition(value) == false) {
        errors.add(text);
      }
    }

    // ignore: invalid_use_of_protected_member
    formFieldState?.setValue(
      Padding(
        padding: const EdgeInsetsDirectional.only(start: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: errors,
        ),
      ),
    );

    setState(() {
      hasError = errors.isNotEmpty && widget.required;
    });
  }

  final List<AuthFormRule> idRules = [
    AuthFormRule(
      ruleText: 'min_14_char'.tr,
      condition: (value) {
        return value.length >= 14;
      },
    ),
  ];

  final List<AuthFormRule> nameRules = [
    AuthFormRule(
      ruleText: 'invalid_username'.tr,
      condition: (value) {
        return GetUtils.isUsername(value);
      },
    ),
  ];

  final List<AuthFormRule> emailRules = [
    AuthFormRule(
      ruleText: 'invalid_email'.tr,
      condition: (value) {
        return GetUtils.isEmail(value);
      },
    )
  ];

  final List<AuthFormRule> passwordRules = [
    AuthFormRule(
      ruleText: 'min_6_char'.tr,
      condition: (value) {
        return value.length >= 6;
      },
    ),
    // AuthFormRule(
    //   ruleText: '1Lowercase'.tr,
    //   condition: (value) {
    //     return RegExp(r'(?=[a-z])').hasMatch(value);
    //   },
    // ),
    // AuthFormRule(
    //   ruleText: '1Uppercase'.tr,
    //   condition: (value) {
    //     return GetUtils.hasCapitalletter(value);
    //   },
    // ),
    // AuthFormRule(
    //   ruleText: '1SpecialCharacters'.tr,
    //   condition: (value) {
    //     return RegExp(r'(?=[!@#$&%^{}/|])').hasMatch(value);
    //   },
    // ),
    // AuthFormRule(
    //   ruleText: '1NumericValue'.tr,
    //   condition: (value) {
    //     return RegExp(r'(?=[0-9])').hasMatch(value);
    //   },
    // ),
  ];

  final List<AuthFormRule> phoneNumberRules = [
    AuthFormRule(
      ruleText: 'invalid_phone'.tr,
      condition: (value) {
        return GetUtils.isPhoneNumber(value);
      },
    ),
  ];

  final List<AuthFormRule> swiftCodeRules = [
    AuthFormRule(
      ruleText: 'valid_swift_code'.tr,
      condition: (value) {
        return value.length >= 8 && value.length <= 11;
      },
    ),
  ];
  final List<AuthFormRule> bankNumberRules = [
    AuthFormRule(
      ruleText: 'bank_number'.tr,
      condition: (value) {
        return value.length == 14;
      },
    ),
  ];
}
