import 'package:equatable/equatable.dart';
import '../../data/models/installment_model.dart';
import '../../data/models/expense_model.dart';

abstract class CostsState extends Equatable {
  const CostsState();

  @override
  List<Object?> get props => [];
}

class CostsInitial extends CostsState {}

class CostsLoading extends CostsState {}

class CostsLoaded extends CostsState {
  final List<InstallmentModel> installments;
  final List<ExpenseModel> expenses;
  final double totalFees;
  final double totalPaid;
  final double totalRemaining;

  const CostsLoaded({
    required this.installments,
    required this.expenses,
    required this.totalFees,
    required this.totalPaid,
    required this.totalRemaining,
  });

  @override
  List<Object?> get props => [
    installments,
    expenses,
    totalFees,
    totalPaid,
    totalRemaining,
  ];
}

class CostsError extends CostsState {
  final String message;

  const CostsError(this.message);

  @override
  List<Object?> get props => [message];
}
