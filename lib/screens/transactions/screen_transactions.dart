import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/functions/transaction/transaction_db.dart';
import 'package:flutter_money_management_app/db/models/category/category_model.dart';
import 'package:flutter_money_management_app/db/models/transaction/transaction_model.dart';
import 'package:flutter_money_management_app/utils/helper_functions.dart';
import 'package:intl/intl.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb().refreshUi();
    return ValueListenableBuilder(
        valueListenable: TransactionDb().transactionListNotifier,
        builder: (BuildContext context,
            List<TransactionModel> transactionModelList, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, index) {
                TransactionModel transaction = transactionModelList[index];
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 80.0, // Adjust width as needed
                      height: 50.0, // Adjust height as needed
                      decoration: BoxDecoration(
                        color: (transaction.categoryType == CategoryType.income)
                            ? const Color.fromARGB(
                                255, 75, 160, 78) // Color for income
                            : Colors
                                .red, // Color for expense, // Adjust color as needed
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          formatDate(DateTime.parse(transaction.date)),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    title: Text('\u20B9 ${transaction.amount}'),
                    subtitle: Text(
                      HelperFunction.firstLetterCapitalize(transaction.categoryModel.name),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          TransactionDb().deleteTransaction(
                              transactionid: transaction.id!);
                          TransactionDb().refreshUi();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 224, 83, 73),
                        )),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15.0,
                );
              },
              itemCount: transactionModelList.length);
        });
  }

  //date formart function
  String formatDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  
}
