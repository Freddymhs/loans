import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans/2_application/bloc/loans/loans_bloc.dart';
import 'package:loans/2_application/bloc/loans/loans_event.dart';
import 'package:loans/2_application/bloc/loans/loans_state.dart';
import 'package:loans/2_application/widgets/error_widget.dart';
import 'package:loans/2_application/widgets/loading_widget.dart';
import 'package:loans/2_application/widgets/loans_floating_toggle.dart';
import 'package:loans/2_application/widgets/loans_header.dart';
import 'package:loans/2_application/widgets/loans_list.dart';
import 'package:loans/2_application/widgets/loans_status_bar.dart';
import 'package:loans/3_utils/config/theme.dart';
import 'package:loans/injection_container.dart';

enum LoansType { outgoing, incoming }

class LoansHomeScreen extends StatelessWidget {
  const LoansHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoansBloc>()..add(const LoadLoansEvent()),
      child: const _LoansHomeScreenContent(),
    );
  }
}

class _LoansHomeScreenContent extends StatefulWidget {
  const _LoansHomeScreenContent();

  @override
  State<_LoansHomeScreenContent> createState() =>
      _LoansHomeScreenContentState();
}

class _LoansHomeScreenContentState extends State<_LoansHomeScreenContent> {
  LoansType _currentType = LoansType.outgoing;
  static const String _currentUserId = 'current_user';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    AppColors.darkBgStart,
                    AppColors.darkBgMiddle,
                    AppColors.darkBgEnd,
                  ]
                : [
                    AppColors.lightBgStart,
                    AppColors.lightBgMiddle,
                    AppColors.lightBgEnd,
                  ],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<LoansBloc, LoansState>(
            listener: (context, state) {
              if (state is LoanMarkedAsReturned) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Préstamo marcado como devuelto'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state is LoanCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Préstamo creado exitosamente'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoansLoading) {
                return const Center(child: LoadingWidget());
              }

              if (state is LoansError) {
                return ErrorDisplayWidget(
                  message: state.message,
                  onRetry: () {
                    context.read<LoansBloc>().add(const LoadLoansEvent());
                  },
                );
              }

              if (state is LoansLoaded) {
                return _buildContent(context, state);
              }

              if (state is LoanMarkedAsReturned || state is LoanCreated) {
                return const Center(child: LoadingWidget());
              }

              return const Center(child: LoadingWidget());
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<LoansBloc, LoansState>(
        builder: (context, state) {
          if (state is! LoansLoaded) {
            return const SizedBox.shrink();
          }

          final outCount = state.outgoingCount(_currentUserId);
          final inCount = state.incomingCount(_currentUserId);

          return LoansFloatingToggle(
            currentType: _currentType,
            onToggle: () {
              setState(() {
                _currentType = _currentType == LoansType.outgoing
                    ? LoansType.incoming
                    : LoansType.outgoing;
              });
            },
            outCount: outCount,
            inCount: inCount,
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, LoansLoaded state) {
    final loans = _currentType == LoansType.outgoing
        ? state.getOutgoingLoans(_currentUserId)
        : state.getIncomingLoans(_currentUserId);

    return SingleChildScrollView(
      child: Column(
        children: [
          const LoansHeader(),
          LoansStatusBar(
            activeCount: state.activeCount,
            pendingCount: state.pendingCount,
          ),
          LoansListWidget(
            loans: loans,
            type: _currentType,
            onReturn: (loanId) {
              context.read<LoansBloc>().add(MarkLoanAsReturnedEvent(loanId));
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
