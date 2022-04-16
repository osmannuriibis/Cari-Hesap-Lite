import 'package:cari_hesapp_lite/enums/route_names.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/sign_up_view/sign_up_view.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/sign_up_view/sign_up_view_model.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountCheck extends StatelessWidget {
  final bool isLogin;

  const AlreadyHaveAccountCheck({Key? key, required this.isLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLogin) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => SignUpViewModel(),
                  child: SignUpView(),
                ),
              ));
        } else {
          Navigator.popAndPushNamed(context, RouteNames.Login.route);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isLogin ? "Hesabın yok mu? " : "Zaten hesabın mı var? "),
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
