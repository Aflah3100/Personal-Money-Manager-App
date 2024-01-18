import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/functions/category/category_db.dart';
import 'package:flutter_money_management_app/screens/category/widgets/expense_list.dart';
import 'package:flutter_money_management_app/screens/category/widgets/income_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    CategoryDb().refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color labelColor =
        theme.brightness == Brightness.light ? Colors.black : Colors.white;
    Color unselectedLabelColor = theme.brightness == Brightness.light
        ? Colors.grey
        : Colors.grey.withOpacity(0.7);

    return Column(
      children: [
        TabBar(
            controller: _tabcontroller,
            labelColor: labelColor,
            unselectedLabelColor: unselectedLabelColor,
            tabs: const [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              )
            ]),
        Expanded(
          child: TabBarView(
              controller: _tabcontroller,
              children: const [IncomeLists(), ExpenseLists()]),
        )
      ],
    );
  }
}
