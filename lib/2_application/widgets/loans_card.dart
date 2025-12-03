import 'package:flutter/material.dart';
import 'package:loans/1_domain/entities/loan_entity.dart';
import 'package:loans/3_utils/config/theme.dart';
import 'package:loans/3_utils/date_time_extensions.dart';

class LoansCard extends StatelessWidget {
  final LoanEntity loan;
  final bool isExpanded;
  final VoidCallback onTap;
  final Function(String)? onReturn;

  const LoansCard({
    super.key,
    required this.loan,
    required this.isExpanded,
    required this.onTap,
    this.onReturn,
  });

  Color _getStatusColor(LoanStatus status) {
    switch (status) {
      case LoanStatus.active:
        return AppColors.success;
      case LoanStatus.pending:
        return AppColors.warning;
      case LoanStatus.completed:
        return AppColors.success;
      case LoanStatus.overdue:
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isExpanded
                ? _getStatusColor(loan.status).withOpacity(0.5)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isExpanded ? 1.5 : 1,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            if (isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isExpanded ? 12 : 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getStatusColor(loan.status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      loan.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkForeground
                            : AppColors.lightForeground,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                _buildDetailRow('Persona', loan.borrowerId, isDark),
                const SizedBox(height: 8),
                _buildDetailRow(
                    'Fecha', loan.loanDate.formatToShortDate(), isDark),
                const SizedBox(height: 8),
                _buildDetailRow(
                    'Vence', loan.dueDate.formatToShortDate(), isDark),
                if (loan.status != LoanStatus.completed) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () => onReturn?.call(loan.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getStatusColor(loan.status),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Marcar devuelto',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDark) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: isDark
                ? AppColors.darkMutedForeground
                : AppColors.lightMutedForeground,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color:
                  isDark ? AppColors.darkForeground : AppColors.lightForeground,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _getStatusLabel(LoanStatus status) {
    switch (status) {
      case LoanStatus.active:
        return 'Activo';
      case LoanStatus.pending:
        return 'Pendiente';
      case LoanStatus.completed:
        return 'Completado';
      case LoanStatus.overdue:
        return 'Vencido';
      case LoanStatus.cancelled:
        return 'Cancelado';
    }
  }
}
