import 'package:flutter/material.dart';

// textfield decoration
InputDecoration getTextFieldDecoration({labelText: String, hintText: String}) {
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
