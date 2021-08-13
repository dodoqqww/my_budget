import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/providers/bottom_nav_state.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './screens/settings_screen.dart';
import 'screens/graph_screen.dart';

class BottomNavigation extends StatelessWidget {
  final currentTab = [
    GraphScreen(),
    MainScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print("AppNavigations build()");
    var provider = Provider.of<NavigationProvider>(context);

    return SafeArea(
        child: Scaffold(
            body: Container(child: currentTab[provider.currentIndex]),
            bottomNavigationBar: ConvexAppBar(
                style: TabStyle.reactCircle,
                items: [
                  TabItem(icon: Icons.assessment),
                  TabItem(icon: Icons.attach_money),
                  TabItem(icon: Icons.settings),
                ],
                initialActiveIndex: provider.currentIndex,
                onTap: (int i) => {provider.changeIndex(i)})));
  }
}
