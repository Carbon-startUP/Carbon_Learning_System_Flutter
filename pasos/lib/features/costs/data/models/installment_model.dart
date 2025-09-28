class InstallmentModel {
  final int? id;
  final double totalFees;
  final double paidAmount;
  final DateTime paymentDate;
  final String paymentMethod;
  final double remainingAmount;
  final DateTime dueDate;
  final bool isPaid;
  final DateTime createdAt;

  InstallmentModel({
    this.id,
    required this.totalFees,
    required this.paidAmount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.remainingAmount,
    required this.dueDate,
    required this.isPaid,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalFees': totalFees,
      'paidAmount': paidAmount,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'remainingAmount': remainingAmount,
      'dueDate': dueDate.toIso8601String(),
      'isPaid': isPaid ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory InstallmentModel.fromMap(Map<String, dynamic> map) {
    return InstallmentModel(
      id: map['id'],
      totalFees: map['totalFees']?.toDouble() ?? 0.0,
      paidAmount: map['paidAmount']?.toDouble() ?? 0.0,
      paymentDate: DateTime.parse(map['paymentDate']),
      paymentMethod: map['paymentMethod'] ?? '',
      remainingAmount: map['remainingAmount']?.toDouble() ?? 0.0,
      dueDate: DateTime.parse(map['dueDate']),
      isPaid: map['isPaid'] == 1,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  InstallmentModel copyWith({
    int? id,
    double? totalFees,
    double? paidAmount,
    DateTime? paymentDate,
    String? paymentMethod,
    double? remainingAmount,
    DateTime? dueDate,
    bool? isPaid,
    DateTime? createdAt,
  }) {
    return InstallmentModel(
      id: id ?? this.id,
      totalFees: totalFees ?? this.totalFees,
      paidAmount: paidAmount ?? this.paidAmount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      dueDate: dueDate ?? this.dueDate,
      isPaid: isPaid ?? this.isPaid,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
