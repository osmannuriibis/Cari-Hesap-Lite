import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../services/firebase/database/utils/database_utils.dart';

class SignUpViewModel extends ChangeNotifier {
  var auth = AuthService();

  String? _warningPass1;
  String? _warningPass2;

  var formKey = GlobalKey<FormState>();
  String? get warningPass2 => _warningPass2;
  set warningPass2(String? value) {
    _warningPass2 = value;
    notifyListeners();
  }

  String? get warningPass1 => _warningPass1;
  set warningPass1(String? value) {
    _warningPass2 = value;
    notifyListeners();
  }

  var controllerEmail = TextEditingController();

  var controllerPassword = TextEditingController();

/*   var controllerAd = TextEditingController();

  var controllerSoyad = TextEditingController();

  var controllerTel = TextEditingController(); */

  var controllerPassword2 = TextEditingController();

  Future<String?> save() async {
    UserCredential? res;
    if (formKey.currentState!.validate()) {
      res = await auth.createUserWEAP(
          email: controllerEmail.text.trim(),
          password: controllerPassword.text);
      return res != null ? null : "Birşeyler Ters Gitti";
    }
    return null;
  }

  void onChangePass2(String value) {
    if (isPassDifferent() && warningPass2 != null) {
      warningPass2 = "Şifreler farklı";
    }
  }

  bool isPassDifferent() =>
      (controllerPassword.text != controllerPassword2.text) ? true : false;

  String? validatorPass(String? p1) =>
      (controllerPassword.text != controllerPassword2.text)
          ? "Şifreler Farklı"
          : null;
}
