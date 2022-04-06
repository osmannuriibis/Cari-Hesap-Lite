import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> showDateDialog(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? (DateTime.now()).subtract(Duration(days: 365)),
    lastDate: lastDate ?? (DateTime.now()).add(Duration(days: 365)),
    confirmText: "Tamam",
    cancelText: "Vazgeç",
  );
}
