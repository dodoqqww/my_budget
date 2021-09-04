import 'package:flutter/material.dart';

// app divider
class AppListItemDivider extends StatelessWidget {
  final Color color;

  const AppListItemDivider({Key key, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 5,
      color: color,
    );
  }
}

// textfield decoration
InputDecoration getAppTextFieldDecoration(
    {String labelText, String hintText = ""}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.blue, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.blue, width: 1.0),
    ),
    filled: true,
    contentPadding: EdgeInsets.only(left: 25, bottom: 20),
    //border: OutlineInputBorder(
    //    borderRadius: BorderRadius.circular(25),
    //    borderSide: new BorderSide(color: Colors.blue)),
    labelText: labelText,
    hintText: hintText,
  );
}

// card shape
Card getAppCardStyle({Widget child}) {
  return Card(
    elevation: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: child,
  );
}
