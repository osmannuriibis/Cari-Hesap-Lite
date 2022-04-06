import 'package:cari_hesapp_lite/enums/route_names.dart';
import 'package:cari_hesapp_lite/utils/validator.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/sign_up_view/sign_up_view_model.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/verify_view/verify_view.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/verify_view/verify_view_model.dart';
import '../../../../components/buttons/rounded_button.dart';
import '../../../../components/text_fields/rounded_text_field.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/scroll_column.dart';

class SignUpView extends StatelessWidget with Validator {
  late SignUpViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<SignUpViewModel>(context);
    return Scaffold(
      body: Form(
        key: viewModel.formKey,
        child: Center(
          child: MyColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignment.stretch,
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
              MyRoundedTextField(
                controller: viewModel.controllerEmail,
                label: "Email",
                validator: emailValidator,
              ),
              MyRoundedTextField(
                controller: viewModel.controllerPassword,
                label: "Şifre",
              ),
              MyRoundedTextField(
                controller: viewModel.controllerPassword2,
                label: "Şifre Tekrar",
                onChanged: viewModel.onChangePass2,
                validator: viewModel.validatorPass,
              ),
              const Divider(),
              RoundedButton("KAYDOL", onPressed: () async {
                if ((await viewModel.save()) == null) {
                  Navigator.popAndPushNamed(
                      context, RouteNames.AuthWrapper.route);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
