 import 'package:flutter/material.dart';

void selectTextInField(TextEditingController controller) {
    controller.selection = TextSelection(
        baseOffset: 0, extentOffset: controller.value.text.length);
  }