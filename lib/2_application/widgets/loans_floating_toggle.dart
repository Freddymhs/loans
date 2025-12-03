import 'package:flutter/material.dart';
import 'package:loans/2_application/screens/loans_home_screen.dart';
import 'package:loans/3_utils/config/theme.dart';

class LoansFloatingToggle extends StatefulWidget {
  final LoansType currentType;
  final VoidCallback onToggle;
  final int outCount;
  final int inCount;

  const LoansFloatingToggle({
    super.key,
    required this.currentType,
    required this.onToggle,
    required this.outCount,
    required this.inCount,
  });

  @override
  State<LoansFloatingToggle> createState() => _LoansFloatingToggleState();
}

class _LoansFloatingToggleState extends State<LoansFloatingToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _rotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(LoansFloatingToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentType != widget.currentType) {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOut = widget.currentType == LoansType.outgoing;
    final count = isOut ? widget.outCount : widget.inCount;
    final label = isOut ? 'OUT' : 'IN';
    final color = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return GestureDetector(
      onTap: widget.onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isOut ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$count items',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
