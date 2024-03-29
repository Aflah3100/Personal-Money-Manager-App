import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/functions/category/category_db.dart';
import 'package:flutter_money_management_app/screens/add_transactions/screen_add_transaction.dart';
import 'package:flutter_money_management_app/screens/category/screen_category.dart';
import 'package:flutter_money_management_app/screens/category/widgets/add_category_popup.dart';
import 'package:flutter_money_management_app/screens/home/widgets/bottomnavigationbar.dart';
import 'package:flutter_money_management_app/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);
  static final _pages = [const ScreenTransactions(), const ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    CategoryDb().refreshUi();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Money Manager',
          style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigationBar(),
      body: ValueListenableBuilder(
          valueListenable: currentIndexNotifier,
          builder: (BuildContext context, int newValue, Widget? _) {
            return SafeArea(child: _pages[newValue]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTransactions.routeName);
          } else {
            displayAddCategoryPopUp(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
