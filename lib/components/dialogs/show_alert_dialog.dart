import 'package:flutter/material.dart';

import 'custom_alert_dialog.dart';

Future<T?> showAlertDialog<T>(BuildContext context,
    {String? title,
    Widget? content,
    List<Widget>? actions,
    EdgeInsets actionsPadding = const EdgeInsets.all(8)}) {
  return showDialog<T>(
    context: context,
    builder: (context) => CustomAlertDialog(
      
      title: title,
      content: content,
      
      actionsPadding: actionsPadding,
      actions: actions,
      contentPadding: const EdgeInsets.all(20),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
    ),
  );
}
