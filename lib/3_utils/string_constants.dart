/// Strings de la aplicación (sin hardcode en UI)
class AppStrings {
  // App
  static const String appName = 'MyLends';
  static const String appDescription = 'Gestiona préstamos entre empresas';

  // Auth
  static const String signInWithGoogle = 'Iniciar sesión con Google';
  static const String signOut = 'Cerrar sesión';
  static const String signInTitle = 'Bienvenido a MyLends';
  static const String signingIn = 'Iniciando sesión...';

  // Loans
  static const String loansTab = 'Préstamos';
  static const String debtsTab = 'Deudas';
  static const String addLoan = 'Agregar préstamo';
  static const String editLoan = 'Editar préstamo';
  static const String deleteLoan = 'Eliminar préstamo';
  static const String markAsReturned = 'Marcar como devuelto';
  static const String lendAdded = 'Préstamo añadido exitosamente';
  static const String lendUpdated = 'Préstamo actualizado';
  static const String lendDeleted = 'Préstamo eliminado';
  static const String lendReturned = 'Préstamo marcado como devuelto';

  // Common actions
  static const String save = 'Guardar';
  static const String cancel = 'Cancelar';
  static const String delete = 'Eliminar';
  static const String edit = 'Editar';
  static const String close = 'Cerrar';
  static const String retry = 'Reintentar';
  static const String loading = 'Cargando...';

  // Status
  static const String returned = 'Devuelto';
  static const String notReturned = 'No devuelto';
  static const String pending = 'Pendiente';

  // Errors
  static const String errorOccurred = 'Ocurrió un error';
  static const String networkError = 'Error de conexión';
  static const String databaseError = 'Error en la base de datos';
  static const String authError = 'Error de autenticación';
  static const String unknownError = 'Error desconocido';
  static const String tryAgain = 'Intenta de nuevo';

  // Validation
  static const String fieldRequired = 'Este campo es requerido';
  static const String invalidEmail = 'Email inválido';
  static const String invalidQuantity = 'Cantidad inválida';

  // Company
  static const String noCompany = 'No perteneces a ninguna empresa';
  static const String selectCompany = 'Selecciona una empresa';
  static const String selectUser = 'Selecciona un usuario';
  static const String differentCompany = 'El usuario debe ser de otra empresa';
}
