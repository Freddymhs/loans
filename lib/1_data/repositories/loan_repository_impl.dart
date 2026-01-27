import 'package:dartz/dartz.dart';
import 'package:loans/1_data/datasources/loan_datasource.dart';
import 'package:loans/1_data/datasources/loan_local_datasource.dart';
import 'package:loans/1_data/models/loan_model.dart';
import 'package:loans/0_domain/entities/loan_entity.dart';
import 'package:loans/0_domain/repositories/loan_repository.dart';
import 'package:loans/3_utils/errors/exceptions.dart';
import 'package:loans/3_utils/errors/failures.dart'
    show Failure, NetworkFailure, NotFoundFailure, UnknownFailure;

class LoanRepositoryImpl implements LoanRepository {
  final LoanDataSource remoteDataSource;
  final LoanLocalDataSource localDataSource;

  LoanRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<LoanEntity>>> getLoans() async {
    try {
      final remoteLoans = await remoteDataSource.getLoans('current_user');

      await localDataSource.cacheLoans(remoteLoans);

      final loans = remoteLoans.map((model) => model.toEntity()).toList();
      return Right(loans);
    } on NetworkException catch (e) {
      try {
        final cachedLoans = await localDataSource.getCachedLoans();
        final loans = cachedLoans.map((model) => model.toEntity()).toList();
        return Right(loans);
      } on CacheException catch (_) {
        return Left(NetworkFailure(e.message));
      }
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoanEntity>> getLoanById(String id) async {
    try {
      final cached = await localDataSource.getCachedLoan(id);
      if (cached != null) {
        return Right(cached.toEntity());
      }

      return const Left(NotFoundFailure('Loan not found'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoanEntity>> createLoan(LoanEntity loan) async {
    try {
      final loanModel = LoanModel.fromEntity(loan);
      final createdModel = await remoteDataSource.createLoan(loanModel);

      await localDataSource.cacheLoan(createdModel);

      return Right(createdModel.toEntity());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoanEntity>> updateLoan(LoanEntity loan) async {
    try {
      final loanModel = LoanModel.fromEntity(loan);
      final updatedModel = await remoteDataSource.updateLoan(
        loan.id,
        loanModel,
      );

      await localDataSource.cacheLoan(updatedModel);

      return Right(updatedModel.toEntity());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLoan(String loanId) async {
    try {
      await remoteDataSource.deleteLoan(loanId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoanEntity>> markAsReturned(String loanId) async {
    try {
      final updatedModel = await remoteDataSource.markAsReturned(loanId);

      await localDataSource.cacheLoan(updatedModel);

      return Right(updatedModel.toEntity());
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
