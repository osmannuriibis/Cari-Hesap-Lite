import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class MyBaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? buttonText;
  final Color onSurface;

  const MyBaseButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      this.onSurface = kPrimaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          onSurface: kPrimaryColor, primary: onSurface, onPrimary: Colors.black),
      child: Text(buttonText ?? " "),
      onPressed: onPressed,
    );
  }
}
