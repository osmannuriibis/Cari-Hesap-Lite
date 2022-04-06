import 'dart:math';

import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final bool isActive;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomRoundedButton(this.buttonText,
      {Key? key, required this.onPressed, this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size buttonSize = Size(size.width * 0.8 > 400 ? 400 : size.width * 0.8,
        sqrt(size.height) * 1.85);

    return Container(
      margin: EdgeInsets.symmetric(vertical: sqrt(size.width) * 0.5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          minimumSize: buttonSize,
          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.all( Radius.circular(29)),
          ),
          primary: isActive ? kPrimaryColor : kPrimaryLightColor,
        ),

        child: Text(buttonText),
        onPressed: onPressed, //onPressed,
      ),
    );
  }
}
