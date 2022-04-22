import 'dart:ui';

import 'package:cari_hesapp_lite/components/snack_bar.dart/snack_bar.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/firebase_auth_exceptins.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/reset_passsword/reset_password_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../components/already_have_account_check.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/my_logo.dart';
import '../../../components/text_fields/rounded_text_field.dart';
import '../../../constants/constants.dart';
import '../../../services/firebase/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_view_model.dart';

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
    var viewModel = Provider.of<LoginViewModel>(context);
    return Container(
        color: Colors.grey[50],
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.07),
              const MyLogoWidget(),
              const Text("Cari Hesapp", style: TextStyle(fontFamily: "Coiny",fontSize: 30)),
              SizedBox(height: size.height * 0.02),
              MyRoundedTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: "Email",
                prefixIcon: const Icon(Icons.person_rounded),
              ),
              MyRoundedTextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                label: "Şifre",
                prefixIcon: const Icon(Icons.vpn_key_rounded),
                obscureText: !viewModel.isPassVisible,
                enableSuggestions: false,
                suffixIcon: IconButton(
                    onPressed: () {
                      bas("value");
                      viewModel.isPassVisible = !viewModel.isPassVisible;
                      bas("value222");
                    },
                    icon: Icon(viewModel.isPassVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined)),
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
                  bas("then");
                  if (user?.user != null) {
                   Navigator.popAndPushNamed(context, "/");
                  }
                }).onError((FirebaseAuthException onError, stackTrace) {
                  bas(onError.code);

                  showSnackBar(
                      context: context,
                      message: (emailController.text.isEmptyOrNull ||
                              passwordController.text.isEmptyOrNull)
                          ? "Email ve şifre giriniz"
                          : getAuthExceptionMessage(onError.code));
                });
              }),
              const AlreadyHaveAccountCheck(
                isLogin: true,
              ),
              GestureDetector(
                onTap: () {
                  goToView(context, viewToGo: ResetPasswordView());
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
