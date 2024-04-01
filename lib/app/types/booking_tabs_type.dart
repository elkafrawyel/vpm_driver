import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum BookingTabsType {
  active,
  completed;
  // cancelled;

  @override
  String toString() => title;
}

extension BookingTabItem on BookingTabsType {
  String get title {
    switch (this) {
      case BookingTabsType.active:
        return 'active'.tr;
      case BookingTabsType.completed:
        return 'completed'.tr;
      // case BookingTabsType.cancelled:
      //   return 'cancelled'.tr;
      default:
        return 'active'.tr;
    }
  }
}
