import '../../constants/constants.dart';

import '../../core/containers/active_button_container.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color, textColor;

  const RoundedButton(this.text,
      {Key? key,
      @required this.onPressed,
      this.color = kPrimaryColor,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActiveButtonContainer(
      child: TextButton(
        /*padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        color: color,*/
        style: TextButton.styleFrom(
            primary: kPrimaryColor,
            ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
