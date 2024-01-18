import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';


@HiveType(typeId: 0)
enum CategoryType{
  @HiveField(1)
  income,
  @HiveField(2)
  expense
}

@HiveType(typeId: 1)
class CategoryModel{

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final CategoryType type;
   @HiveField(3)
  final bool isDeleted;

  CategoryModel({required this.id,required this.name, required this.type,this.isDeleted=false});


  @override
  String toString() {
    return "id: $id,name: $name,type: $type";
  }
}