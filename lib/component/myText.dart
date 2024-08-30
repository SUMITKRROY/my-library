import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color fontColor;
    bool alignment;

  MyText({
    super.key,
    required this.label,
    required this.fontSize,
    required this.fontColor,
      this.alignment = false
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
      textAlign: alignment ? TextAlign.center : TextAlign.start,
    );
  }
}
