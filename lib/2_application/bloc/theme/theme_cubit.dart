import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loans/2_application/bloc/theme/theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light());

  void toggleTheme() {
    emit(ThemeState(isDarkMode: !state.isDarkMode));
  }

  void setDarkMode(bool isDarkMode) {
    emit(ThemeState(isDarkMode: isDarkMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
