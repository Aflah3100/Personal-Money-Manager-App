import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/models/transaction/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel transactionObject);
  Future<List<TransactionModel>> fetchTransactions();
  Future<void> deleteTransaction({required String transactionid});
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

  //valuenotifer
  ValueNotifier<List<TransactionModel>> transactionListNotifier=ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel transactionObject) async {
    Box<TransactionModel> transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionDb.put(transactionObject.id, transactionObject);
  }
  
  @override
  Future<List<TransactionModel>> fetchTransactions() async{
    final transactionDb=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transactionDb.values.toList();
  }

  @override
  Future<void> deleteTransaction({required String transactionid}) async{
    final transactionDb=await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    transactionDb.delete(transactionid);
  }
  

  //refreshUI
  Future<void> refreshUi()async{
    List<TransactionModel> transactionList=await fetchTransactions();
    transactionList.sort((transactionModel1,transactionModel2){
      return DateTime.parse(transactionModel1.date).compareTo(DateTime.parse(transactionModel2.date));
    });
    transactionListNotifier.value.clear();
    Future.forEach(transactionList, (transactionModelObject){
      transactionListNotifier.value.add(transactionModelObject);
    });
    transactionListNotifier.notifyListeners();

  }
  

}
