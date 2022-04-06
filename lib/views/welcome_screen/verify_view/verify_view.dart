import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/buttons/rounded_button.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/verify_view/verify_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyView extends StatelessWidget {
  VerifyView({Key? key}) : super(key: key);
  late VerifyViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<VerifyViewModel>(context);
    return Scaffold(
      key: viewModel.key,
      appBar: MyAppBar(
        titleText: "Email Doğrulama",
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Email Doğrulama Mail'i\n${AuthService().currentUserEmail}\nadresine gönderildi"),
          RoundedButton("TEKRAR GÖNDER", onPressed: viewModel.sendVerify)
        ],
      ),
    );
  }
}
