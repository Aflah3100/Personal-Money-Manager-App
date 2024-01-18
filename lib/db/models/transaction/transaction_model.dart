import 'package:flutter_money_management_app/db/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String purpose;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final CategoryType categoryType;
  @HiveField(5)
  final CategoryModel categoryModel;

  TransactionModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.categoryType,
      required this.categoryModel}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
