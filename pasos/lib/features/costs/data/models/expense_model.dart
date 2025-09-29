class ExpenseModel {
  final int? id;
  final String reason;
  final double amount;
  final DateTime dueDate;
  final String category;
  final bool isPaid;
  final DateTime createdAt;

  ExpenseModel({
    this.id,
    required this.reason,
    required this.amount,
    required this.dueDate,
    required this.category,
    required this.isPaid,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reason': reason,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'category': category,
      'isPaid': isPaid ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      reason: map['reason'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      dueDate: DateTime.parse(map['dueDate']),
      category: map['category'] ?? '',
      isPaid: map['isPaid'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  ExpenseModel copyWith({
    int? id,
    String? reason,
    double? amount,
    DateTime? dueDate,
    String? category,
    bool? isPaid,
    DateTime? createdAt,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
