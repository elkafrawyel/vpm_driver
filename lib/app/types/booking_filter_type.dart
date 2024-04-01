import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum BookingFilterType {
  all,
  daily,
  monthly,
  yearly;

  @override
  String toString() => title;
}

extension TabItem on BookingFilterType {
  String get title {
    switch (this) {
      case BookingFilterType.all:
        return 'all'.tr;
      case BookingFilterType.daily:
        return 'daily'.tr;
      case BookingFilterType.monthly:
        return 'monthly'.tr;
      case BookingFilterType.yearly:
        return 'yearly'.tr;
      default:
        return 'all'.tr;
    }
  }

  String get value {
    switch (this) {
      case BookingFilterType.all:
        return 'all';
      case BookingFilterType.daily:
        return 'day';
      case BookingFilterType.monthly:
        return 'month';
      case BookingFilterType.yearly:
        return 'year';
      default:
        return 'all';
    }
  }
}
