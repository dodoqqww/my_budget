import 'package:flutter/material.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("GraphScreen build()");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text("Graph"),
      ),
    );
  }
}
