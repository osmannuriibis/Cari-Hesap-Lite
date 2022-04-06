import '../constants/constants.dart';
import 'package:flutter/material.dart';


class AlreadyHaveAccountCheck extends StatelessWidget {
  final bool isLogin;

  const AlreadyHaveAccountCheck({Key? key,required this.isLogin }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isLogin ? "Hesabın yok mu? ": "Zaten hesabın mı var? "),
            Text(
              isLogin ? "Kaydol" : "Giriş yap",
              style: const TextStyle(
                  color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
