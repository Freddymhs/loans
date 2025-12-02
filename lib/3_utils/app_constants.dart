/// Constantes de la aplicación
class AppConstants {
  // Company
  static const String defaultCompanyValue = 'null';
  static const String noCompanyAssigned = 'null';

  // Database tables
  static const String usersTable = 'users';
  static const String lendsTable = 'lends';
  static const String companiesTable = 'companies';

  // Durations
  static const Duration shortDuration = Duration(milliseconds: 300);
  static const Duration mediumDuration = Duration(milliseconds: 600);
  static const Duration longDuration = Duration(seconds: 1);

  // Pagination
  static const int pageSize = 20;
  static const int initialPage = 0;

  // Retry
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // Cache
  static const Duration cacheExpiration = Duration(minutes: 5);

  // Validation
  static const int minLendQuantity = 1;
  static const int maxLendQuantity = 10000;

  // Empty states
  static const String emptyLendsMessage = 'No hay préstamos aún';
  static const String emptyDebtsMessage = 'No hay deudas aún';
  static const String emptyUsersMessage = 'No hay usuarios en tu empresa';
}
