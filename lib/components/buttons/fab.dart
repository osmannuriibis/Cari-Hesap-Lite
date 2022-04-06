import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;
  final bool mini;
  final Object heroTag;

  const FAB(
      {Key? key,
      this.onPressed,
      this.child = const Icon(Icons.add),
      this.backgroundColor = kPrimaryColor,
      this.mini = false, this.heroTag ='<default FloatingActionButton tag>'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      mini: mini,
      backgroundColor: backgroundColor,
      child: child,
      onPressed: onPressed,
    );
  }
}
