import 'installment_model.dart';
import 'expense_model.dart';

class HardcodedData {
  static List<InstallmentModel> getInstallments() {
    return [
      InstallmentModel(
        id: 1,
        totalFees: 50000.0,
        paidAmount: 20000.0,
        paymentDate: DateTime(2024, 1, 15),
        paymentMethod: 'تحويل بنكي',
        remainingAmount: 30000.0,
        dueDate: DateTime(2024, 3, 15),
        isPaid: false,
        createdAt: DateTime(2024, 1, 1),
      ),
      InstallmentModel(
        id: 2,
        totalFees: 35000.0,
        paidAmount: 35000.0,
        paymentDate: DateTime(2023, 12, 20),
        paymentMethod: 'نقدي',
        remainingAmount: 0.0,
        dueDate: DateTime(2024, 1, 20),
        isPaid: true,
        createdAt: DateTime(2023, 12, 1),
      ),
      InstallmentModel(
        id: 3,
        totalFees: 45000.0,
        paidAmount: 15000.0,
        paymentDate: DateTime(2024, 2, 1),
        paymentMethod: 'فيزا',
        remainingAmount: 30000.0,
        dueDate: DateTime(2024, 4, 1),
        isPaid: false,
        createdAt: DateTime(2024, 1, 15),
      ),
    ];
  }

  static List<ExpenseModel> getExpenses() {
    return [
      ExpenseModel(
        id: 1,
        reason: 'رحلة مدرسية إلى الأهرامات',
        amount: 500.0,
        dueDate: DateTime(2024, 3, 20),
        category: 'رحلات',
        isPaid: false,
        createdAt: DateTime(2024, 2, 1),
      ),
      ExpenseModel(
        id: 2,
        reason: 'أساور تتبع ذكية',
        amount: 1200.0,
        dueDate: DateTime(2024, 2, 28),
        category: 'أساور',
        isPaid: true,
        createdAt: DateTime(2024, 1, 15),
      ),
      ExpenseModel(
        id: 3,
        reason: 'كتب دراسية إضافية',
        amount: 800.0,
        dueDate: DateTime(2024, 3, 10),
        category: 'أخرى',
        isPaid: false,
        createdAt: DateTime(2024, 2, 10),
      ),
      ExpenseModel(
        id: 4,
        reason: 'رحلة ترفيهية إلى دريم بارك',
        amount: 750.0,
        dueDate: DateTime(2024, 4, 5),
        category: 'رحلات',
        isPaid: false,
        createdAt: DateTime(2024, 2, 15),
      ),
      ExpenseModel(
        id: 5,
        reason: 'زي رياضي إضافي',
        amount: 450.0,
        dueDate: DateTime(2024, 3, 1),
        category: 'أخرى',
        isPaid: true,
        createdAt: DateTime(2024, 2, 5),
      ),
    ];
  }
}
