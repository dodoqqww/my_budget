import 'package:flutter/material.dart';

class MyLegendWidget extends StatelessWidget {
  final String text;
  final MaterialColor color;
  final double space;
  final TextStyle style;

  const MyLegendWidget(
      {Key key,
      @required this.text,
      @required this.color,
      this.space = 3,
      this.style})
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
            style:
                style == null ? Theme.of(context).textTheme.bodyText2 : style,
          )
        ],
      ),
    );
  }
}
