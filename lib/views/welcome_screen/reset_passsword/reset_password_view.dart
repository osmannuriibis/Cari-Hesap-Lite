import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/buttons/base_primary_button.dart';
import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/components/snack_bar.dart/snack_bar.dart';
import 'package:cari_hesapp_lite/components/text_fields/base_form_field.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);

  final controller = TextEditingController();
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleText: "Şifre Sıfırlama",
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("""Hesabınıza bağlı Email adresine
Şifre Yenileme Emaili Gönderilecektir"""),
            ),
          ),
          BaseFormField(
            keyboardType: TextInputType.emailAddress,
            labelText: "Email Adres",
            hintText: "Email adresinizi giriniz",
            controller: controller,
          ),
          MyBaseButton(
              onPressed: () {
                auth.auth
                    .sendPasswordResetEmail(email: controller.text.trim())
                    .then((value) async {
                  await onSuccess(context);
                  Navigator.pop(context);
                }).onError((FirebaseAuthException e, stackTrace) {
                  String message = "Birşeyler ters gitti";
                  bas("Hata: " + e.code);
                  switch (e.code) {
                    case 'invalid-email':
                      message = 'Geçersiz Email adresi';
                      break;
                    case 'user-not-found':
                      message = 'Böyle bir kullanıcı bulunamadı';
                      break;
                    default:
                  }

                  showSnackBar(context: context, message: message);
                });
              },
              buttonText: "Gönder")
        ],
      ),
    );
  }

  onSuccess(BuildContext context) async {
    await showAlertDialog(context,
        title: "Başarılı",
        actionsPadding: const EdgeInsets.all(2),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Lütfen email adresinizi kontrol ediniz.'),
            Text(
              "(Spam klasörüne bakmayı unutmayınız)",
              textScaleFactor: 0.75,
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await OpenMailApp.openMailApp();
              },
              child: const Text("Email Uygulamasını Aç")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Kapat"))
        ]);
  }
}
