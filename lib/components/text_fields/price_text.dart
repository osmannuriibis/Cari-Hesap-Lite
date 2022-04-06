
import 'package:flutter/material.dart';

class PText extends StatelessWidget {

  final String value;

  final double fontSize;

  const PText(this.value,
      {Key? key,  this.fontSize = 17})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: "Pragmata",
        fontWeight: FontWeight.w600,
      ),
    );
  }
}


