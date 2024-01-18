import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/utils/themes.dart';

class ThemeManager {
  TextTheme darkTextTheme = ThemeData().textTheme;
  //lightTheme
  ThemeData lightTheme = MaterialTheme(const TextTheme()
      .copyWith(
          titleLarge: const TextStyle(
            color: Colors.black,
          ),
          titleMedium: const TextStyle(
            color: Colors.black,
          ),
          titleSmall: const TextStyle(
            color: Colors.black,
          ),
          bodySmall: const TextStyle(fontFamily: 'RobotoSlab'),
          bodyMedium: const TextStyle(fontFamily: 'RobotoSlab'),
          bodyLarge: const TextStyle(fontFamily: 'RobotoSlab'))
      .apply(
        fontFamily: 'RobotoSlab',
      )).light();
  ThemeData darkTheme = MaterialTheme(const TextTheme()
          .copyWith(
              titleLarge: const TextStyle(color: Colors.white),
              titleMedium: const TextStyle(color: Colors.white),
              titleSmall: const TextStyle(color: Colors.white),
              bodySmall: const TextStyle(fontFamily: 'RobotoSlab'),
              bodyMedium: const TextStyle(fontFamily: 'RobotoSlab'),
              bodyLarge: const TextStyle(fontFamily: 'RobotoSlab'))
          .apply(fontFamily: 'RobotoSlab'))
      .dark();
}
