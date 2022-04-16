import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/reset_passsword/reset_password_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../components/already_have_account_check.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/text_fields/rounded_text_field.dart';
import '../../../constants/constants.dart';
import '../../../services/firebase/auth/service/auth_service.dart';
import 'components/body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: Colors.grey[50],
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(height: size.height * 0.02),
              SvgPicture.asset(
                "assets/icons/handshake-svgrepo-com.svg",
                height: size.height * 0.2,
              ),
              SizedBox(height: size.height * 0.02),
              MyRoundedTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: "Email",
                prefixIcon: Icon(Icons.person_rounded),
              ),
              MyRoundedTextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                label: "Şifre",
                prefixIcon: const Icon(Icons.vpn_key_rounded),
                obscureText: true, //!viewModel.isPassVisible,
                enableSuggestions: false,
              ),
              const Divider(
                indent: 12,
                endIndent: 12,
              ),
              RoundedButton("GİRİŞ", onPressed: () {
                context
                    .read<AuthService>()
                    .singInWEAP(
                        email: emailController.text.trim(),
                        password: passwordController.text)
                    .then((user) {
                  if (user?.user != null) {
                    Navigator.pop(context);
                  }
                });
              }),
              const AlreadyHaveAccountCheck(
                isLogin: true,
              ),
              GestureDetector(
                onTap: () {
                  goToView(context, viewToGo:  ResetPasswordView());
                },
                child: false
                    ? null
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Şifremi unuttum. "),
                          Text(
                            "Sıfırla",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ));
  }
}
