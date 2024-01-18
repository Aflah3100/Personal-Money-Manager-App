import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/functions/category/category_db.dart';
import 'package:flutter_money_management_app/db/models/category/category_model.dart';

class IncomeLists extends StatelessWidget {
  const IncomeLists({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomeListNotifier,
        builder:
            (BuildContext context, List<CategoryModel> incomeList, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(incomeList[index].name),
                    trailing: IconButton(
                        onPressed: () {
                          CategoryDb().deleteCategory(incomeList[index].id);
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
              itemCount: incomeList.length);
        });
  }
}
