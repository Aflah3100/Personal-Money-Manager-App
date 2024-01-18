import 'package:flutter/material.dart';
import 'package:flutter_money_management_app/screens/home/screen_home.dart';

class MoneyManagerBottomNavigationBar extends StatelessWidget {
  const MoneyManagerBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.currentIndexNotifier,
        builder: (context, updatedIndex, child) {
          return BottomNavigationBar(
            currentIndex: updatedIndex,
            selectedItemColor: const Color.fromARGB(255, 14, 120, 207),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category')
            ],
            onTap: (selectedIndex) {
              ScreenHome.currentIndexNotifier.value = selectedIndex;
            },
          );
        });
  }
}
