
import 'package:flutter/material.dart';

class MyNumText extends StatelessWidget {
  final num numText;
  final Color minusColor;
  final Color plusColor;
  final int fractionDigits;

  const MyNumText(this.numText,
      {Key? key,
      this.fractionDigits = 2,
      this.minusColor = Colors.black,
      this.plusColor = Colors.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      numText.toStringAsFixed(fractionDigits) +
          ( "₺"),
      style: Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: !numText.isNegative ? plusColor : minusColor),
    );
  }
}
