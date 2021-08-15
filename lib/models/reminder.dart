import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class Reminder {
  String id;
  String name;
  String frequency;

  Reminder({@required this.id, @required this.name, @required this.frequency});
}
