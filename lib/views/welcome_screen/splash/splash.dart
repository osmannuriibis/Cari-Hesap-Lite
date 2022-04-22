import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spinkit;

import '../../../constants/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: kPrimaryColor,
        body: spinkit.SpinKitCircle(
            color: Colors.black) // Lottie.asset("assets/lottie/splash.json")

        );
  }
}
