import 'package:flutter/material.dart';

class FittedText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double fitSize;
  final AlignmentGeometry align;

  const FittedText(
      {Key key,
      @required this.color,
      @required this.text,
      @required this.size,
      @required this.fitSize,
      this.align = AlignmentDirectional.centerStart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: align,
      width: fitSize,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          text,
          style: TextStyle(fontSize: size, color: color),
        ),
      ),
    );
  }
}
