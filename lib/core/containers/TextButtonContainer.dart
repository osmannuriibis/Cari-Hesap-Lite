// ignore_for_file: file_names

import '../../constants/constants.dart';
import 'package:flutter/material.dart';
class TextButtonContainer extends StatelessWidget {
  final Widget? child;
  final Color? fieldColor;

  const TextButtonContainer({Key? key, this.child, this.fieldColor = kPrimaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    //double height = size.height;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: (width * 0.8) < 400 ? width * 0.8 : 400,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(29),


      ),

      child : child,


    );
  }
}
