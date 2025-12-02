import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool isDarkMode;

  const ThemeState({required this.isDarkMode});

  factory ThemeState.light() => const ThemeState(isDarkMode: false);
  factory ThemeState.dark() => const ThemeState(isDarkMode: true);

  // JSON serialization for HydratedBloc
  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(isDarkMode: json['isDarkMode'] as bool? ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'isDarkMode': isDarkMode};
  }

  @override
  List<Object?> get props => [isDarkMode];
}
