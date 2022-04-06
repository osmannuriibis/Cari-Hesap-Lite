import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    String message = "",
    MaterialColor? textColor, SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: textColor),

    ),
    action: action,
  ));
}

void showSaveSnackBar(BuildContext context){
  
}