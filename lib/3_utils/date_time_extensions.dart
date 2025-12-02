import 'package:intl/intl.dart';

/// Extensiones para DateTime
extension DateTimeExtensions on DateTime {
  /// Formatea a "DD-MM-YYYY HH:mm:ss"
  String toFormattedString() {
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(this);
  }

  /// Formatea a "DD de MMMM de YYYY"
  String toLocalizedString() {
    return DateFormat('dd \'de\' MMMM \'de\' yyyy', 'es_ES').format(this);
  }

  /// Formatea solo la hora "HH:mm"
  String toTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  /// Formatea solo la fecha "DD/MM/YYYY"
  String toShortDateString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  /// Valida si es hoy
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Valida si fue ayer
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// Diferencia en días
  int daysBetween(DateTime other) {
    return difference(other).inDays.abs();
  }
}
