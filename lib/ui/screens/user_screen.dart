import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("UserScreen build()");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text("User"),
      ),
    );
  }
}
