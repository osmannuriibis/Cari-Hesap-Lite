import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../services/firebase/database/utils/database_utils.dart';

class SignUpViewModel extends ChangeNotifier {
  var auth = AuthService();

  String? _warningPass1;
  String? _warningPass2;
  String? _warningCheck;
  var formKey = GlobalKey<FormState>();

  bool _isChecked = false;

  bool _isVisiblePass1 = false;
  set isVisiblePass1(bool val) {
    _isVisiblePass1 = val;
    notifyListeners();
  }
  bool get isVisiblePass1 => _isVisiblePass1;

  bool _isVisiblePass2 = false;
  set isVisiblePass2(bool val) {
    _isVisiblePass2 = val;
    notifyListeners();
  }
  bool get isVisiblePass2 => _isVisiblePass2;

  bool get isChecked => _isChecked;
  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

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

  String? get warningCheck => _warningCheck;
  set warningCheck(String? value) {
    _warningCheck = value;
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
    if (formKey.currentState!.validate() && isChecked) {
      warningCheck = null;
      res = await auth.createUserWEAP(
          email: controllerEmail.text.trim(),
          password: controllerPassword.text);
      return res != null ? null : "Birşeyler Ters Gitti";
    }
    bas(isChecked);
    if (!isChecked) {
      return (warningCheck = "*Sözleşme kabul edilmeli");
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
