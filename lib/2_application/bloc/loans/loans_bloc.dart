import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loans/1_domain/usecases/loan/create_loan_usecase.dart';
import 'package:loans/1_domain/usecases/loan/get_loans_usecase.dart';
import 'package:loans/1_domain/usecases/loan/mark_loan_as_returned_usecase.dart';
import 'package:loans/2_application/bloc/loans/loans_event.dart';
import 'package:loans/2_application/bloc/loans/loans_state.dart';

class LoansBloc extends Bloc<LoansEvent, LoansState> {
  final GetLoansUseCase getLoansUseCase;
  final CreateLoanUseCase createLoanUseCase;
  final MarkLoanAsReturnedUseCase markLoanAsReturnedUseCase;

  LoansBloc({
    required this.getLoansUseCase,
    required this.createLoanUseCase,
    required this.markLoanAsReturnedUseCase,
  }) : super(const LoansInitial()) {
    on<LoadLoansEvent>(_onLoadLoans);
    on<CreateLoanEvent>(_onCreateLoan);
    on<MarkLoanAsReturnedEvent>(_onMarkLoanAsReturned);
    on<UpdateLoanEvent>(_onUpdateLoan);
    on<DeleteLoanEvent>(_onDeleteLoan);
  }

  Future<void> _onLoadLoans(
    LoadLoansEvent event,
    Emitter<LoansState> emit,
  ) async {
    emit(const LoansLoading());

    final result = await getLoansUseCase();

    result.fold(
      (failure) => emit(LoansError(failure.message)),
      (loans) => emit(LoansLoaded(loans)),
    );
  }

  Future<void> _onCreateLoan(
    CreateLoanEvent event,
    Emitter<LoansState> emit,
  ) async {
    final result = await createLoanUseCase(
      CreateLoanParams(
        lenderId: event.loan.lenderId,
        borrowerId: event.loan.borrowerId,
        amount: event.loan.amount,
        currency: event.loan.currency,
        description: event.loan.description,
        loanDate: event.loan.loanDate,
        dueDate: event.loan.dueDate,
        interestRate: event.loan.interestRate,
      ),
    );

    result.fold(
      (failure) => emit(LoansError(failure.message)),
      (loan) {
        emit(LoanCreated(loan));
        add(const LoadLoansEvent());
      },
    );
  }

  Future<void> _onMarkLoanAsReturned(
    MarkLoanAsReturnedEvent event,
    Emitter<LoansState> emit,
  ) async {
    final result = await markLoanAsReturnedUseCase(
      MarkLoanAsReturnedParams(event.loanId),
    );

    result.fold(
      (failure) => emit(LoansError(failure.message)),
      (loan) {
        emit(LoanMarkedAsReturned(loan));
        add(const LoadLoansEvent());
      },
    );
  }

  Future<void> _onUpdateLoan(
    UpdateLoanEvent event,
    Emitter<LoansState> emit,
  ) async {
    emit(const LoansError('Update not yet implemented'));
  }

  Future<void> _onDeleteLoan(
    DeleteLoanEvent event,
    Emitter<LoansState> emit,
  ) async {
    emit(const LoansError('Delete not yet implemented'));
  }
}
