// lib/models/nutrition/log.dart

class LogItem {
  final String id;
  final String planId;
  final String? mealId;
  final int ingredientId;
  final int? weightUnitId;
  final DateTime datetime;
  final double amount;

  const LogItem({
    required this.id,
    required this.planId,
    this.mealId,
    required this.ingredientId,
    this.weightUnitId,
    required this.datetime,
    required this.amount,
  });

  factory LogItem.fromJson(Map<String, dynamic> json) {
    final mealItem = json['mealItem'] as Map<String, dynamic>?;
    return LogItem(
      id: json['id']?.toString() ?? '',
      planId: json['planId']?.toString() ?? '',
      mealId: json['mealId']?.toString(),
      ingredientId: mealItem?['ingredientId'] as int? ?? 0,
      weightUnitId: mealItem?['weight_unit_id'] as int?,
      datetime:
          DateTime.tryParse(json['datetime']?.toString() ?? '') ??
          DateTime.now(),
      amount: (mealItem?['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
