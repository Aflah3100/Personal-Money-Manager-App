import 'package:flutter_money_management_app/db/models/transaction/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel transactionObject);
}

class TransactionDb implements TransactionDbFunctions {

  //private constructor
  TransactionDb._internal();

  //static instance (Singleton Object)
  static TransactionDb? instance;

  factory TransactionDb(){
    instance ??=TransactionDb._internal();
    return instance!;
  }
  @override
  Future<void> addTransaction(TransactionModel transactionObject) async {
    Box<TransactionModel> transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionDb.put(transactionObject.id, transactionObject);
  }
}
