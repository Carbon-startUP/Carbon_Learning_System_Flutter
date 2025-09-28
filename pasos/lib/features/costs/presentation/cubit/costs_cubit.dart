import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/costs_repository.dart';
import 'costs_state.dart';

class CostsCubit extends Cubit<CostsState> {
  final CostsRepository _repository;

  CostsCubit({CostsRepository? repository})
    : _repository = repository ?? CostsRepository(),
      super(CostsInitial());

  Future<void> loadCosts() async {
    emit(CostsLoading());
    try {
      final installments = await _repository.getInstallments();
      final expenses = await _repository.getExpenses();

      double totalFees = 0;
      double totalPaid = 0;
      double totalRemaining = 0;

      for (var installment in installments) {
        totalFees += installment.totalFees;
        totalPaid += installment.paidAmount;
        totalRemaining += installment.remainingAmount;
      }

      emit(
        CostsLoaded(
          installments: installments,
          expenses: expenses,
          totalFees: totalFees,
          totalPaid: totalPaid,
          totalRemaining: totalRemaining,
        ),
      );
    } catch (e) {
      emit(CostsError('فشل في تحميل البيانات'));
    }
  }
}
