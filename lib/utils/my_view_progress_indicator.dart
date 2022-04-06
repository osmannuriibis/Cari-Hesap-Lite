import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyViewProgressUtil {
  BuildContext? context;

  bool barrierDismissible;

  Color barrierColor;

  /* static final ProgressUtil _progressUtil = ProgressUtil._(context: context,);

  factory ProgressUtil(BuildContext context,
      {bool barrierDismissible, Color barrierColor}) {
    if (context != null) {
      _progressUtil.context = context;
      _progressUtil.barrierColor = barrierColor ?? Colors.black54;
      _progressUtil.barrierDismissible = barrierDismissible ?? false;
    }
    return _progressUtil;
  } */

  MyViewProgressUtil(  this.context,
      {this.barrierDismissible = false, this.barrierColor = Colors.white30}) {
    _showCircleProgress();
  }

  _showCircleProgress() {
    return showDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      context: context!,
      
      builder: (context) => Center(
        child: CPIndicator(),
      ),
    );
  }

  closeProgress() {
    if (context != null) {
      Navigator.pop<bool>(context!);

      context = null;
      return true;
    } else
      return false;
  }
}
