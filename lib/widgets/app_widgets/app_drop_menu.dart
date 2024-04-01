import 'package:flutter/material.dart';

import '../../../app/config/app_color.dart';
import 'app_text.dart';

class AppDropMenu<T> extends StatefulWidget {
  final List<T> items;
  final Function(T?) onChanged;
  final String hint;
  final T? initialValue;
  final bool bordered;
  final double radius;
  final bool expanded;
  final Color? backgroundColor;
  final bool centerHint;
  final String? validationText;

  const AppDropMenu({
    Key? key,
    this.initialValue,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.bordered = false,
    this.radius = 8,
    this.expanded = false,
    this.backgroundColor,
    this.centerHint = false,
    this.validationText,
  }) : super(key: key);

  @override
  State<AppDropMenu<T>> createState() => AppDropMenuState<T>();
}

class AppDropMenuState<T> extends State<AppDropMenu<T>> {
  T? selectedItem;
  FormFieldState<Object?>? formFieldState;

  @override
  void initState() {
    selectedItem = widget.initialValue;
    super.initState();
  }

  void clearSelection() {
    setState(() {
      selectedItem = null;
    });
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
      builder: ((formFieldState) {
        this.formFieldState = formFieldState;
        bool hasError = formFieldState.hasError && widget.validationText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: widget.bordered
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.radius),
                      border: Border.all(width: 1, color: hasError ? errorColor : Theme.of(context).primaryColor),
                      color: widget.backgroundColor,
                    )
                  : BoxDecoration(color: widget.backgroundColor),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<T>(
                value: selectedItem,
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                hint: Align(
                  alignment: widget.centerHint ? AlignmentDirectional.center : AlignmentDirectional.centerStart,
                  child: AppText(
                    selectedItem == null ? widget.hint : selectedItem.toString(),
                    maxLines: 1,
                    color: hintColor,
                    fontSize: 14,
                  ),
                ),
                isExpanded: widget.expanded,
                iconSize: 25,
                icon: const Icon(Icons.keyboard_arrow_down),
                // iconEnabledColor: Theme.of(context).primaryColor,
                underline: const SizedBox(),
                items: widget.items.isEmpty
                    ? []
                    : widget.items
                        .map(
                          (e) => DropdownMenuItem<T>(
                            value: widget.items[widget.items.indexOf(e)],
                            child: AppText(
                              e.toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                  widget.onChanged(value);
                },
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
        );
      }),
    );
  }
}
