import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/ui/common/style.dart';
import 'package:quiver/time.dart';

class AddEditTrxScreen extends StatelessWidget {
  final Transaction trx;

  final DateTime time = DateTime.now();

  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  AddEditTrxScreen({Key key, this.trx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("AddEditTrxScreen build()");

    bool hasTrx = false;
    if (trx != null) {
      hasTrx = true;
      nameCtrl.text = trx.name;
      amountCtrl.text = trx.amount.toString();
      descCtrl.text = trx.desc;
    }

    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 35, 10, 75),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: FlutterDatePickerTimeline(
                          selectedItemBackgroundColor: Colors.blue,
                          startDate: DateTime(time.year, time.month, 01),
                          endDate: DateTime(time.year, time.month,
                              daysInMonth(time.year, time.month)),
                          initialSelectedDate: time,
                          onSelectedDateChange: (DateTime dateTime) {
                            print(dateTime);
                          },
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 275,
                                    child: InputDecorator(
                                      decoration: getTextFieldDecoration(
                                          labelText: "Category",
                                          hintText: "Category"),
                                      child: DropdownButtonHideUnderline(
                                        child: Container(
                                          height: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: DropdownButton(
                                              value: 'First',
                                              items: <String>[
                                                'First',
                                                'Second',
                                                'Third',
                                                'Fourth'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String newValue) {
                                                //S setState(() {
                                                //S   dropdownValue = newValue;
                                                //S });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                  )
                                ],
                              )),
                          // TODO implement select card and options
                          //  InputDecorator(
                          //    decoration: const InputDecoration(
                          //        border: OutlineInputBorder()),
                          //    child: DropdownButtonHideUnderline(
                          //      child: DropdownButton(
                          //          //...
                          //          ),
                          //    ),
                          //  ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              controller: amountCtrl,
                              decoration: getTextFieldDecoration(
                                  labelText: "Amount", hintText: "Amount"),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              controller: descCtrl,
                              maxLines: 6,
                              decoration: getTextFieldDecoration(
                                labelText: 'Details',
                                hintText: 'Details',
                              ),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: Row(
                              children: <Widget>[
                                Text("Images:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFF000000))),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.camera,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    //getImage(ImageSource.camera);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.image, color: Colors.blue),
                                  onPressed: () {
                                    //getImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: 1,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      child: Container(
                                        //decoration: BoxDecoration(
                                        //  image: DecorationImage(
                                        //    image: FileImage(images[index]),
                                        //    fit: BoxFit.cover,
                                        //  ),
                                        //),
                                        child: Text('2'),
                                      ),
                                      onTap: () => print("image"),
                                    )),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back)),
                            Spacer(),
                            Visibility(
                              visible: !hasTrx,
                              child: FloatingActionButton(
                                  child: Icon(Icons.add),
                                  backgroundColor: Colors.green,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            Visibility(
                                visible: hasTrx,
                                child: Row(
                                  children: [
                                    FloatingActionButton(
                                        child: Icon(Icons.delete),
                                        backgroundColor: Colors.red,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FloatingActionButton(
                                        child: Icon(Icons.copy),
                                        backgroundColor: Colors.blue,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FloatingActionButton(
                                        child: Icon(Icons.save),
                                        backgroundColor: Colors.green,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}
