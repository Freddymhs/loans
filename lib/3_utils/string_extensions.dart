/// Extensiones para String
extension StringExtensions on String {
  /// Capitaliza la primera letra
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Valida si es un email
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Valida si está vacío o solo tiene espacios
  bool get isBlank => trim().isEmpty;

  /// Lo contrario de isBlank
  bool get isNotBlank => !isBlank;

  /// Obtiene primeras N palabras
  String getFirstWords(int count) {
    final words = split(' ');
    return words.take(count).join(' ');
  }
}
