import 'package:flutter/material.dart';

class MyLegendWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double space;

  const MyLegendWidget(
      {Key key, @required this.text, @required this.color, this.space = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: space),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.circle,
            color: color,
            size: 16,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
