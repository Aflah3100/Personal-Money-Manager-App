// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/functions/category/category_db.dart';
import 'package:flutter_money_management_app/db/models/category/category_model.dart';

//Radio Button Notifier
ValueNotifier<CategoryType> radioButtonNotifier =
    ValueNotifier(CategoryType.income);

Future<void> displayAddCategoryPopUp(BuildContext context) async {
  //text controller
  final _textController = TextEditingController();

  //form key
  final _formkey=GlobalKey<FormState>();
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          title: const Center(child: Text('Add Category')),
          contentPadding: const EdgeInsets.all(10.0),
          children: [
            Form(
              key: _formkey,
              child: TextFormField(
                controller: _textController,
                validator: (name) => (name==null || name.isEmpty)?'Name Can\'t be Empty' :null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintText: 'Name'),
              ),
            ),
            const Row(
              children: [
                CategoryRadioButton(
                    title: 'Income', value: CategoryType.income),
                CategoryRadioButton(
                    title: 'Expense', value: CategoryType.expense),
              ],
            ),
            FilledButton(
                onPressed: () {
                  
                  if(_formkey.currentState!.validate()){
                    String name=_textController.text;
                    CategoryType type=radioButtonNotifier.value;
                    CategoryDb().addCategory(CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, type: type));
                    Navigator.of(dialogContext).pop();
                  }
                },
                child: const Text(
                  'Add',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        );
      });
}

//Radio Button Widget

class CategoryRadioButton extends StatelessWidget {
  final String title;
  final CategoryType value;
  const CategoryRadioButton(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: radioButtonNotifier,
        builder:
            (BuildContext context, CategoryType newCategoryType, Widget? _) {
          return Row(
            children: [
              Radio<CategoryType>(
                  value: value,
                  groupValue: newCategoryType,
                  onChanged: (newValue) {
                    if (newValue == null) return;
                    radioButtonNotifier.value = newValue;
                  }),
              Text(title)
            ],
          );
        });
  }
}
