import 'package:flutter/material.dart';
import 'package:my_budget/providers/bottom_nav_state.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './screens/settings_screen.dart';
import './screens/user_screen.dart';

class AppNavigations extends StatelessWidget {
  final currentTab = [
    UserScreen(),
    MainScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print("build navigations");
    var provider = Provider.of<NavigationProvider>(context);

    return SafeArea(
        child: Scaffold(
            body: Container(child: currentTab[provider.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.orange,
                items: [
                  BottomNavigationBarItem(
                      label: 'User', icon: Icon(Icons.message_sharp)),
                  BottomNavigationBarItem(
                      label: 'Main', icon: Icon(Icons.golf_course_sharp)),
                  BottomNavigationBarItem(
                      label: 'Settings', icon: Icon(Icons.calendar_today)),
                ],
                currentIndex: provider.currentIndex,
                onTap: (int i) => {provider.changeIndex(i)})));
  }
}
