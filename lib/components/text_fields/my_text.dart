import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  TextEditingController? controller;

  final EdgeInsets contentPadding;

  final FontWeight fontWeight;

  final InputBorder border;

  final VoidCallback? onTap;

  MyText(
    this.text, {
    Key? key,
    this.controller,
    this.fontWeight = FontWeight.normal,
    this.style,
    this.contentPadding = const EdgeInsets.all(0),
    this.border = InputBorder.none,
    this.onTap,
  }) : super(key: key) {
    controller = controller ?? TextEditingController();
    if (controller!.text.isEmpty) controller!.text = text;
    controller!.text = controller!.text.trim() + " " + ParaBirimi.TRY.getSembol;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextField(
        onTap: onTap,
        decoration: InputDecoration(
          border: border,
          contentPadding: contentPadding,
          isCollapsed: true,
        ),
        controller: controller,
        showCursor: false,
        readOnly: true,
        style: style ??
            TextStyle(
              // fontFamily: "Pragmata",
              fontSize: 17,
              fontWeight: fontWeight,
            ),
      ),
    );
  }
}
