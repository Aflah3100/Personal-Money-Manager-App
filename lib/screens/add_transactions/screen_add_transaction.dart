import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/functions/category/category_db.dart';
import 'package:flutter_money_management_app/db/functions/transaction/transaction_db.dart';
import 'package:flutter_money_management_app/db/models/category/category_model.dart';
import 'package:flutter_money_management_app/db/models/transaction/transaction_model.dart';
import 'package:intl/intl.dart';

class ScreenAddTransactions extends StatefulWidget {
  const ScreenAddTransactions({super.key});
  static String routeName = 'add-transaction-page';

  @override
  State<ScreenAddTransactions> createState() => _ScreenAddTransactionsState();
}

class _ScreenAddTransactionsState extends State<ScreenAddTransactions> {
  //selected items
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  CategoryType? selectedType;
  String selectDate = 'Select Date';
  DateTime? dateSelected;
  CategoryModel? categorySelected;

  //form key
  final _formkey = GlobalKey<FormState>();

  //format date function
  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  void initState() {
    selectedType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Form
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    //Purpose
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _purposeController,
                        validator: (purpose) {
                          return (purpose == null || purpose.isEmpty)
                              ? 'Purpose Field cant\'t be  Empty'
                              : null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'Purpose',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                    //Amount
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: _amountController,
                        validator: (amount) {
                          return (amount == null || amount.isEmpty)
                              ? 'Amount Field cant\'t be Empty'
                              : null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Amount',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ],
                ),
              ),
              //Date
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 30 * 2)),
                            initialDate: DateTime.now(),
                            lastDate: DateTime.now());
                        setState(() {
                          if (selectedDate == null) return;
                          dateSelected = selectedDate;
                          print(dateSelected);
                          selectDate = formatDate(selectedDate).toString();
                        });
                      },
                      icon: const Icon(Icons.calendar_today)),
                  Text(
                    selectDate,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              //Category Type
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Radio(
                          value: CategoryType.income,
                          groupValue: selectedType,
                          onChanged: (newType) {
                            setState(() {
                              if (newType != null) {
                                selectedType = newType;
                                categorySelected = null;
                              }
                            });
                          }),
                      const Text('Income'),
                      Radio(
                          value: CategoryType.expense,
                          groupValue: selectedType,
                          onChanged: (newType) {
                            setState(() {
                              if (newType != null) {
                                selectedType = newType;
                                categorySelected = null;
                              }
                            });
                          }),
                      const Text('Expense'),
                    ],
                  )
                ],
              ),
              //Category Selection

              DropdownButton(
                  value: categorySelected,
                  hint: const Text('Select Category'),
                  items: (selectedType == CategoryType.income
                          ? CategoryDb().incomeListNotifier
                          : CategoryDb().expenseListNotifier)
                      .value
                      .map((categoryModelObject) {
                    return DropdownMenuItem(
                      value: categoryModelObject,
                      child: Text(categoryModelObject.name),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      categorySelected = newValue;
                    });
                  }),

              //Add Button
              FilledButton.icon(
                  onPressed: () async {
                    if (await addtoDatabase()) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      TransactionDb().refreshUi();
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }

  //validate and add to database function
  Future<bool> addtoDatabase() async {
    if (_formkey.currentState!.validate()) {
      if (selectedType != null &&
          dateSelected != null &&
          categorySelected != null) {
        TransactionModel transaction = TransactionModel(
            purpose: _purposeController.text,
            amount: double.parse(_amountController.text),
            date: dateSelected.toString(),
            categoryType: selectedType!,
            categoryModel: categorySelected!);
        await TransactionDb().addTransaction(transaction);
        return true;
      }
    }
    return false;
  }
}
