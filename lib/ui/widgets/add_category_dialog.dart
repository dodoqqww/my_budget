import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:my_budget/providers/settings_screen_providers.dart';
import 'package:my_budget/ui/common/style.dart';
import 'package:provider/provider.dart';

Future<void> addCategoryDialog(BuildContext context) async {
  Color color = Colors.red;
  TextEditingController nameCtrl = TextEditingController();

  void changeColor(setState, Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  return showDialog(
      context: context,
      builder: (context) {
        final addEditCategoryScreenProvider =
            context.read<AddEditCategoryScreenProvider>();
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            title: Text(
              'Add category:',
              style: Theme.of(context).textTheme.headline2,
            ),
            content: StatefulBuilder(
              builder: (context, StateSetter setState) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          child: Icon(
                            Icons.circle,
                            color: color,
                            size: 32,
                          ),
                          onTap: () async {
                            changeColor(
                                setState, await openColorPicker(context));
                          },
                        ),
                      ),
                      Container(
                        width: 200,
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: nameCtrl,
                          // onChanged: (value) {
                          //   // setState(() {
                          //   //   valueText = value;
                          //   // });
                          // },
                          //controller: _textFieldController,
                          decoration: getAppTextFieldDecoration(
                              labelText: "Name", context: context),
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
                            addEditCategoryScreenProvider.addCategory();
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.save),
                        )
                      ],
                    ),
                  ),
                ]);
              },
            ));
      });
}

openColorPicker(BuildContext context, {Color color = Colors.red}) async {
  return showDialog(
      context: context,
      builder: (_) {
        Color data = color;
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
                      data = color;
                    },
                    selectedColor: data,
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
                          Navigator.pop(context, data);
                        },
                        icon: Icon(Icons.arrow_back)),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context, data);
                      },
                      child: Icon(Icons.edit),
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
