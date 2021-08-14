import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:quiver/time.dart';

class AddTrxScreen extends StatelessWidget {
  final DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print("AddTrxScreen build()");
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
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Description',
                                hintText: 'Description',
                              ),
                              autofocus: false,
                            ),
                          ),
                          Text("Photos"),
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
                            FloatingActionButton(
                                child: Icon(Icons.add),
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}
