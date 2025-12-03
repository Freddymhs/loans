import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans/2_application/bloc/theme/theme_cubit.dart';
import 'package:loans/2_application/bloc/theme/theme_state.dart';
import 'package:loans/2_application/screens/loans_home_screen.dart';
import 'package:loans/3_utils/config/theme.dart';
import 'package:loans/injection_container.dart';

class MyLendsApp extends StatelessWidget {
  const MyLendsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'MyLends',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const LoansHomeScreen(),
          );
        },
      ),
    );
  }
}
