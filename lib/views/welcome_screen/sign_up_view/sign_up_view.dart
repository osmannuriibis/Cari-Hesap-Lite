import 'package:cari_hesapp_lite/components/already_have_account_check.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/enums/route_names.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/utils/validator.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/sign_up_view/sign_up_view_model.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/verify_view/verify_view.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/verify_view/verify_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import '../../../../components/buttons/rounded_button.dart';
import '../../../../components/text_fields/rounded_text_field.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/scroll_column.dart';

class SignUpView extends StatelessWidget with Validator {
  late SignUpViewModel viewModel;

  SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<SignUpViewModel>(context);
    return Scaffold(
      body: Form(
        key: viewModel.formKey,
        child: Center(
          child: MyColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* MyRoundedTextField(
                controller: viewModel.controllerAd,
                label: "İsim",
                validator: cokKisaOldu,
              ),
              MyRoundedTextField(
                controller: viewModel.controllerSoyad,
                label: "Soyisim",
              ),
              MyRoundedTextField(
                controller: viewModel.controllerTel,
                label: "Tel(Opsiyonel)",
              ), */
              SvgPicture.asset("assets/icons/handshake-svgrepo-com.svg",
                  height: context.height * 0.2),
              MyRoundedTextField(
                controller: viewModel.controllerEmail,
                label: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              MyRoundedTextField(
                controller: viewModel.controllerPassword,
                label: "Şifre",
                keyboardType: TextInputType.visiblePassword,
                obscureText: !viewModel.isVisiblePass1,
                suffixIcon: IconButton(
                    onPressed: () {
                      viewModel.isVisiblePass1 = !viewModel.isVisiblePass1;
                    },
                    icon: Icon(!viewModel.isVisiblePass1
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    color: kAccentColor),
              ),
              MyRoundedTextField(
                controller: viewModel.controllerPassword2,
                label: "Şifre Tekrar",
                onChanged: viewModel.onChangePass2,
                validator: viewModel.validatorPass,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !viewModel.isVisiblePass2,
                suffixIcon: IconButton(
                    onPressed: () {
                      viewModel.isVisiblePass2 = !viewModel.isVisiblePass2;
                    },
                    icon: Icon(!viewModel.isVisiblePass2
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    color: kAccentColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: kPrimaryColor,
                        value: viewModel.isChecked,
                        onChanged: (value) {
                          viewModel.isChecked = value ?? false;
                        }),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Kullanıcı Sözleşmesi",
                        style: context.textTheme.caption!
                            .copyWith(color: kPrimaryColor),
                      ),
                    ),
                    Text("'ni kabul ediyorum",
                        style: context.textTheme.caption),
                  ],
                ),
              ),
              viewModel.warningCheck != null
                  ? Text(
                      viewModel.warningCheck!,
                      style: context.textTheme.caption!
                          .copyWith(color: Colors.red, fontSize: 10),
                    )
                  : const SizedBox.shrink(),
              const Divider(),
              RoundedButton("KAYDOL", onPressed: () async {
                if ((await viewModel.save()) == null) {
                  bas("value");
                  Navigator.popAndPushNamed(
                      context, RouteNames.AuthWrapper.route);
                }
              }),
              const AlreadyHaveAccountCheck(isLogin: false),
            ],
          ),
        ),
      ),
    );
  }
}
