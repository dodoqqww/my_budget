import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:my_budget/models/transaction.dart';
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
                            child: TextField(
                              controller: nameCtrl,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                hintText: 'Name',
                              ),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              controller: amountCtrl,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Amount',
                                hintText: 'Amount',
                              ),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              controller: descCtrl,
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Description',
                                hintText: 'Description',
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
                                  icon: Icon(Icons.camera),
                                  onPressed: () {
                                    //getImage(ImageSource.camera);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.image),
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
                                        child: Icon(Icons.edit),
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
