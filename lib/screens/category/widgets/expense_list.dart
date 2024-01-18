import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/functions/category/category_db.dart';
import 'package:flutter_money_management_app/db/models/category/category_model.dart';

class ExpenseLists extends StatelessWidget {
  const ExpenseLists({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseListNotifier,
        builder:
            (BuildContext context, List<CategoryModel> expenseList, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(expenseList[index].name),
                    trailing: IconButton(
                        onPressed: () {
                          CategoryDb().deleteCategory(expenseList[index].id);
                          CategoryDb().refreshUi();
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
              itemCount: expenseList.length);
        });
  }
}
