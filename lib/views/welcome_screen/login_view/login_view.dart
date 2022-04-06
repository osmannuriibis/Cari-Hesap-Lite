import 'components/body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(child: Body()),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key,required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          /*  Image.asset(null), */
          child,
        ],
      ),
    );
  }
}
