import 'package:flutter/material.dart';
import 'package:loans/3_utils/config/theme.dart';

class LoansStatusBar extends StatelessWidget {
  final int activeCount;
  final int pendingCount;

  const LoansStatusBar({
    super.key,
    required this.activeCount,
    required this.pendingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _StatusItem(
            label: 'ACTIVOS',
            count: activeCount,
            color: AppColors.lightPrimary,
          ),
          const SizedBox(width: 12),
          _StatusItem(
            label: 'PENDIENTES',
            count: pendingCount,
            color: AppColors.warning,
          ),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatusItem({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? color.withOpacity(0.2) : color,
        borderRadius: BorderRadius.circular(20),
        border: isDark
            ? Border.all(
                color: color.withOpacity(0.4),
                width: 1,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isDark ? color : Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isDark ? color : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: AppTextStyles.labelSmall.copyWith(
                color: isDark ? Colors.white : color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
