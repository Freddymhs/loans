import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedString() {
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(this);
  }

  String toLocalizedString() {
    return DateFormat('dd \'de\' MMMM \'de\' yyyy', 'es_ES').format(this);
  }

  String toTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  String toShortDateString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String formatToShortDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  int daysBetween(DateTime other) {
    return difference(other).inDays.abs();
  }
}
