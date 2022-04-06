import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class MyBaseButton extends StatelessWidget {
   final VoidCallback onPressed;
  final String? buttonText;

  const MyBaseButton({Key? key, required this.onPressed, @required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onSurface: kPrimaryColor,
          primary: kPrimaryColor,
          onPrimary: Colors.black),
      child: Text(buttonText ?? " "),
      onPressed: onPressed,
    );
  }
}
