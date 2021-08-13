import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("SettingsScreen build()");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text("Settings"),
      ),
    );
  }
}
