import 'package:driver/app/extensions/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../app_widgets/app_text.dart';

class PaginationView extends StatelessWidget {
  final bool showLoadMoreWidget;
  final bool showLoadMoreEndWidget;
  final Widget child;
  final EndOfPageListenerCallback loadMoreData;
  final Color textColor;
  final EdgeInsetsDirectional? loadMorePadding;
  final EdgeInsetsDirectional? loadMoreEndPadding;

  const PaginationView({
    this.showLoadMoreWidget = false,
    this.showLoadMoreEndWidget = false,
    required this.loadMoreData,
    this.loadMorePadding,
    this.loadMoreEndPadding,
    required this.child,
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LazyLoadScrollView(
            onEndOfPage: loadMoreData,
            child: child,
          ),
        ),
        Visibility(
          visible: showLoadMoreWidget,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  "LoadingMore".tr,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                5.pw,
                const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showLoadMoreEndWidget,
          child: Padding(
            padding: loadMoreEndPadding ??
                const EdgeInsetsDirectional.only(
                  start: 12.0,
                  end: 12.0,
                  bottom: 28.0,
                  top: 18.0,
                ),
            child: AppText(
              "LoadingMoreEnd".tr,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
