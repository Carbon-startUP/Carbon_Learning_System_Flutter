import '../models/hardcoded_data.dart';
import '../models/installment_model.dart';
import '../models/expense_model.dart';

class CostsRepository {
  Future<List<InstallmentModel>> getInstallments() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return HardcodedData.getInstallments();
  }

  Future<List<ExpenseModel>> getExpenses() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return HardcodedData.getExpenses();
  }
}
