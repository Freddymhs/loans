import 'package:flutter/material.dart';

class AppColors {
  // HELPER METHOD: Obtener colores según el tema actual
  static bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // GETTERS DINÁMICOS: Estos métodos devuelven el color correcto según el tema
  static Color getBackground(BuildContext context) =>
      _isDarkMode(context) ? darkBackground : lightBackground;

  static Color getForeground(BuildContext context) =>
      _isDarkMode(context) ? darkForeground : lightForeground;

  static Color getCard(BuildContext context) =>
      _isDarkMode(context) ? darkCard : lightCard;

  static Color getPrimary(BuildContext context) =>
      _isDarkMode(context) ? darkPrimary : lightPrimary;

  static Color getSecondary(BuildContext context) =>
      _isDarkMode(context) ? darkSecondary : lightSecondary;

  static Color getMuted(BuildContext context) =>
      _isDarkMode(context) ? darkMuted : lightMuted;

  static Color getMutedForeground(BuildContext context) =>
      _isDarkMode(context) ? darkMutedForeground : lightMutedForeground;

  static Color getBorder(BuildContext context) =>
      _isDarkMode(context) ? darkBorder : lightBorder;

  static Color getAccent(BuildContext context) =>
      _isDarkMode(context) ? accentDark : accent;

  // Colores neutros comunes (para sombras, iconos, etc.)
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey300 = Color(0xFFD1D5DB); // Gris claro para bordes
  static const Color grey600 = Color(0xFF4B5563); // Gris medio
  static const Color grey700 = Color(0xFF374151); // Gris oscuro para iconos

  // LIGHT MODE COLORS (según documentación)
  static const Color lightBackground = Color(0xFFF7F9FC); // HSL(210, 40%, 98%)
  static const Color lightForeground = Color(0xFF0F172A); // HSL(222, 47%, 11%)
  static const Color lightCard = Color(0xFFFFFFFF); // HSL(0, 0%, 100%)
  static const Color lightPrimary =
      Color(0xFF1A9E8C); // HSL(174, 72%, 40%) - teal
  static const Color lightSecondary = Color(0xFFEEF1F5); // HSL(210, 30%, 94%)
  static const Color lightMuted = Color(0xFFE8ECF1); // HSL(210, 30%, 92%)
  static const Color lightMutedForeground =
      Color(0xFF5E6B7D); // HSL(215, 20%, 45%)
  static const Color lightBorder = Color(0xFFDDE3EB); // HSL(214, 30%, 88%)

  // DARK MODE COLORS (según documentación)
  static const Color darkBackground = Color(0xFF0B1120); // HSL(222, 47%, 8%)
  static const Color darkForeground = Color(0xFFF7F9FC); // HSL(210, 40%, 98%)
  static const Color darkCard = Color(0xFF111827); // HSL(222, 47%, 12%)
  static const Color darkPrimary =
      Color(0xFF2DD4BF); // HSL(174, 72%, 56%) - cyan
  static const Color darkSecondary = Color(0xFF1E293B); // HSL(222, 30%, 18%)
  static const Color darkMuted = Color(0xFF232E3F); // HSL(222, 30%, 20%)
  static const Color darkMutedForeground =
      Color(0xFF94A3B8); // HSL(215, 20%, 65%)
  static const Color darkBorder = Color(0xFF2A3649); // HSL(222, 30%, 22%)

  // SHARED COLORS (estados - funcionan en ambos modos)
  static const Color success = Color(0xFF22C55E); // HSL(142, 72%, 50%) - verde
  static const Color warning =
      Color(0xFFF59E0B); // HSL(38, 92%, 50%) - amarillo
  static const Color error = Color(0xFFEF4444); // HSL(0, 72%, 51%) - rojo
  static const Color accent =
      Color(0xFF8B5CF6); // HSL(270, 60%, 55%) - púrpura light
  static const Color accentDark =
      Color(0xFFA78BFA); // HSL(270, 60%, 60%) - púrpura dark

  // Fondos con gradientes (Dark Mode)
  static const Color darkBgStart = Color(0xFF0D1526); // Gradient start
  static const Color darkBgMiddle = Color(0xFF0F0D1A); // Gradient middle
  static const Color darkBgEnd = Color(0xFF080B14); // Gradient end

  // Fondos con gradientes (Light Mode)
  static const Color lightBgStart = Color(0xFFF7F9FC); // Gradient start
  static const Color lightBgMiddle = Color(0xFFF1F4F8); // Gradient middle
  static const Color lightBgEnd = Color(0xFFEBEEF3); // Gradient end

  // Aliases para compatibilidad
  static const Color primary = lightPrimary;
  static const Color primaryDark = darkPrimary;
  static const Color secondary = warning; // orange/yellow
  static const Color secondaryDark = warning;

  // Glassmorphism - Cards con efecto vidrio
  static const Color glassLight = Color(0xFFFFFFFF);
  static const Color glassDark = Color(0xFF1E293B);

  // Bordes glassmorphism
  static const Color borderGlassLight = lightBorder;
  static const Color borderGlassDark = darkBorder;

  // Backwards compatibility
  static const Color background = lightBackground;
  static const Color surface = lightCard;
  static const Color surfaceVariant = lightSecondary;
  static const Color border = lightBorder;
  static const Color divider = lightMuted;

  // Textos
  static const Color textPrimary = lightForeground;
  static const Color textSecondary = lightMutedForeground;
  static const Color textTertiary = lightMuted;
  static const Color textDark = darkForeground;
  static const Color textDarkSecondary = darkMutedForeground;

  // Estados de préstamos (compatibilidad)
  static const Color returned = success;
  static const Color notReturned = warning;
  static const Color deleted = error;

  // Gradientes (mantenidos para botones)
  static const Color gradientDarkStart = Color(0xFF8B5CF6);
  static const Color gradientDarkMiddle = Color(0xFF3B82F6);
  static const Color gradientDarkEnd = Color(0xFF06B6D4);
  static const Color gradientLightStart = Color(0xFF06B6D4);
  static const Color gradientLightMiddle = Color(0xFF3B82F6);
  static const Color gradientLightEnd = Color(0xFF8B5CF6);
  static const Color info = Color(0xFF3B82F6);
}

/// Estilos de texto
class AppTextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.2,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}

/// Tema de la aplicación
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0F172A), // slate-900
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: const Color(0xFF1E293B), // slate-800
        foregroundColor: Colors.white,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B), // slate-800
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF334155), // slate-700
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF475569)), // slate-600
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF475569)), // slate-600
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
