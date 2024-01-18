// ignore_for_file: constant_identifier_names, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/models/category/category_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

//Category DB name
const DB_NAME='category-db';

abstract class CategoryDbFunctions{

  Future<List<CategoryModel>> fetchCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> deleteCategory(String id);
}


class CategoryDb implements CategoryDbFunctions {

  //Private Constructor
  CategoryDb._internal();

  static CategoryDb? _instance;

  factory CategoryDb(){
    _instance ??= CategoryDb._internal();
    return _instance!;
  }

  //Category Model Lists
  ValueNotifier<List<CategoryModel>> incomeListNotifier=ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseListNotifier=ValueNotifier([]);

  @override
  Future<void> addCategory(CategoryModel category)async {
    Box<CategoryModel> categoryDb=await Hive.openBox<CategoryModel>(DB_NAME);
    await categoryDb.put(category.id,category);
    refreshUi();
  }
  
  @override
  Future<List<CategoryModel>> fetchCategories() async{
    Box<CategoryModel> categoryDb=await Hive.openBox<CategoryModel>(DB_NAME);
    return categoryDb.values.toList();
  }

   @override
  Future<void> deleteCategory(String id)async {
    Box<CategoryModel> categoryDb=await Hive.openBox<CategoryModel>(DB_NAME);
    categoryDb.delete(id);
  }

  //refresh UI Function

  Future<void> refreshUi()async{
    incomeListNotifier.value.clear();
    expenseListNotifier.value.clear();
    List<CategoryModel> categoryLists=await fetchCategories();
    
    Future.forEach(categoryLists, (categoryModelObject) {
      if(categoryModelObject.type==CategoryType.income){
        incomeListNotifier.value.add(categoryModelObject);
      }else{
        expenseListNotifier.value.add(categoryModelObject);
      }
    });

    // ignore: invalid_use_of_visible_for_testing_member
    incomeListNotifier.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member
    expenseListNotifier.notifyListeners();

  }

  Future<void> deleteAll() async{
    Box<CategoryModel> categoryDb=await Hive.openBox<CategoryModel>(DB_NAME);
    categoryDb.deleteAll(categoryDb.keys);

  }
  
 

}