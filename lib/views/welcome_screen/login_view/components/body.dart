import '../../../../components/already_have_account_check.dart';
import '../../../../components/buttons/rounded_button.dart';
import '../../../../components/text_fields/rounded_text_field.dart';
import '../../../../constants/constants.dart';
import '../../../../services/firebase/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              Text("GİRİŞ EKRANI",
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(height: size.height * 0.02),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.4,
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
                prefixIcon: Icon(Icons.vpn_key_rounded),
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
                  print(user?.user?.email);
                  if (user?.user != null) {
                    Navigator.pop(context);
                  }
                });
              }),
              const AlreadyHaveAccountCheck(
                isLogin: true,
              ),
              GestureDetector(
                onTap: () {},
                child: false
                    ? null
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Şifreni mi unuttun? "),
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
