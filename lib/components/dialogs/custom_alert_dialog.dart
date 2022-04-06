import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final List<Widget>? actions;
  final Widget? content;
  final String? title;
  final EdgeInsetsGeometry contentPadding,actionsPadding,insetPadding;
  final bool scrollable;
  final Alignment alignment;

  const CustomAlertDialog(
      {Key? key,
      this.actions,
      this.alignment = Alignment.center,
      this.content,
      this.title,
      this.scrollable = false,
      this.insetPadding =  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      this.contentPadding = const EdgeInsets.all(8),
      this.actionsPadding = EdgeInsets.zero,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: contentPadding,
      actions: actions,
      insetPadding:insetPadding as EdgeInsets ,
      content: content,
      actionsPadding: actionsPadding,
      scrollable: scrollable,
      title: title != null
          ? Align(
              alignment: alignment,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(title ?? ""),
              ),
            )
          : null,
      titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    );
  }
}
