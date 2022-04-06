import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  late SplashViewModel _viewModel = SplashViewModel();

  @override
  Widget build(BuildContext context) {
    //_viewModel.setContext(context);
    _viewModel.control(context);

    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/lottie/splash.json"),
      ),
    );
  }
}
