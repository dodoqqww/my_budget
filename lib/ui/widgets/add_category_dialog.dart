import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:my_budget/ui/common/style.dart';

Future<void> addCategoryDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            title: Text('Add category'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      child: Icon(
                        Icons.circle,
                        size: 32,
                      ),
                      onTap: () {
                        openColorPicker(context);
                      },
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      onChanged: (value) {
                        // setState(() {
                        //   valueText = value;
                        // });
                      },
                      //controller: _textFieldController,
                      decoration: getAppTextFieldDecoration(labelText: "Name"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.save),
                    )
                  ],
                ),
              ),
            ]));
      });
}

void openColorPicker(BuildContext context) async {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding: const EdgeInsets.all(6.0),
          //title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 200,
                  width: double.infinity,
                  child: MaterialColorPicker(
                    onColorChange: (Color color) {
                      // Handle color changes
                    },
                    selectedColor: Colors.red,
                    colors: [
                      Colors.red,
                      Colors.deepOrange,
                      Colors.yellow,
                      Colors.lightGreen,
                      Colors.blue,
                      Colors.cyan,
                      Colors.orange,
                      Colors.grey,
                      Colors.lime,
                      Colors.purple,
                      Colors.pink
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.save),
                    )
                  ],
                ),
              ),
            ],
          ),

          // actions: [
          //   TextButton(
          //     child: Text('CANCEL'),
          //     onPressed: Navigator.of(context).pop,
          //   ),
          //   TextButton(
          //     child: Text('SUBMIT'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //       //   setState(() => _mainColor = _tempMainColor);
          //       //   setState(() => _shadeColor = _tempShadeColor);
          //     },
          //   ),
          // ],
        );
      });
}
