import 'TextButtonContainer.dart';
import 'package:flutter/material.dart';

class ActiveButtonContainer extends StatelessWidget {
  final Color? color;
  final Widget child;

  const ActiveButtonContainer({Key? key,required this.child, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButtonContainer(
    fieldColor: color,
      child: child,

    );
  }
}
