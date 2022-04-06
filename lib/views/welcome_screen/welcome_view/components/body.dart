import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/sign_up_view/sign_up_view_model.dart';

import '../../../../core/buttons/custom_rounded_button.dart';
import '../../../../views/welcome_screen/login_view/login_view.dart';
import '../../../../views/welcome_screen/sign_up_view/sign_up_view.dart';
import 'background.dart' as welcomeBackground;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return welcomeBackground.Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "HOŞGELDİNİZ",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.5,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            CustomRoundedButton(
              "GİRİŞ YAP",
              isActive: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginView();
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Hesabın yok mu?"),
            CustomRoundedButton(
              "KAYIT OL",
              onPressed: () {
                goToView(context,
                    viewToGo: SignUpView(), viewModel: SignUpViewModel());
              },
            ),
          ],
        ),
      ),
    );
  }
}
