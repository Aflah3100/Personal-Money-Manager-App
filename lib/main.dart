// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/db/models/category/category_model.dart';
import 'package:flutter_money_management_app/db/models/transaction/transaction_model.dart';
import 'package:flutter_money_management_app/screens/add_transactions/screen_add_transaction.dart';
import 'package:flutter_money_management_app/screens/home/screen_home.dart';
import 'package:flutter_money_management_app/utils/theme_manager.dart';
import 'package:flutter_money_management_app/utils/themes.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  //Hive-Database-Connections
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

   //Themes
  //  final  _lightTheme = const MaterialTheme(TextTheme()).light();
  //  final  _darkTheme = const MaterialTheme(TextTheme()).dark();
  //  final _lightHighContrast=const MaterialTheme(TextTheme()).lightHighContrast();
  //  final _darkHighContrast=const MaterialTheme(TextTheme()).darkHighContrast();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Personal Money Manager',
      themeMode: ThemeMode.system,
      darkTheme: ThemeManager().darkTheme,
      theme: ThemeManager().lightTheme,
      home:  const ScreenHome(),
      routes: {
        ScreenAddTransactions.routeName:(context){
         return const ScreenAddTransactions();
        }
      },
      
    );
  }
}

