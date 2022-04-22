import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyLogoWidget extends StatelessWidget {
  final double sizeFactor;

  const MyLogoWidget({Key? key, this.sizeFactor = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/svg/logo_without_back.png",
      height: height(context) * 0.30 * sizeFactor,
    );
  }
}
