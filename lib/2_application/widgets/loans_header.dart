import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans/2_application/bloc/theme/theme_cubit.dart';
import 'package:loans/2_application/bloc/theme/theme_state.dart';
import 'package:loans/3_utils/config/theme.dart';

class LoansHeader extends StatelessWidget {
  const LoansHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState.isDarkMode;
        final iconBackgroundColor =
            isDark ? AppColors.glassDark.withOpacity(0.3) : Colors.white;
        final iconColor = isDark ? Colors.grey[300]! : Colors.grey[700]!;
        final borderColor = isDark
            ? AppColors.borderGlassDark.withOpacity(0.3)
            : Colors.grey[300]!;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: iconColor,
                    size: 22,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menú lateral - Próximamente'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
              Text(
                'PRÉSTAMOS',
                style: AppTextStyles.titleLarge.copyWith(
                  color:
                      isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: borderColor,
                        width: 1,
                      ),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        isDark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        color: iconColor,
                        size: 22,
                      ),
                      onPressed: () {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Perfil de usuario - Próximamente'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: iconBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: borderColor,
                          width: 1,
                        ),
                        boxShadow: isDark
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: iconColor,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
