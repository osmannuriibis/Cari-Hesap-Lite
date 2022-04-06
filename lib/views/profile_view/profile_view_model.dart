import 'dart:async';

import 'package:cari_hesapp_lite/models/user_model.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/services/firebase/database/service/database_service.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  bool verify;

  ProfileViewModel(this.userId, {bool editing = false, this.verify = false}) {
    isOwner = true;
    isEditing = editing;
    //userId == auth.currentUserId;

    fetchUser(null);

    setController();
  }

  void fetchUser(String? userId) {
    DBService()
        .getModelReference<UserModel>(AuthService().currentUserId!)
        .get()
        .then((value) {
      bas("value" * 15);
      bas(value.data());
    });
    listenUser = dbUtil
        .getModelAsStream<UserModel>(userId ?? AuthService().currentUserId!)
        .call((event) {
      bas("event" * 15);
      bas(event);

      user = event;
      user!.id = userId;
      setController();
    });
  }

  var dbUtil = DBUtils();
  var auth = AuthService();
  bool _isBottomOpen = false;

  bool _isEditing = false;

  bool _isOwner = false;
  bool get isOwner => _isOwner;

  set isOwner(bool value) {
    _isOwner = value;
    notifyListeners();
  }

  late StreamSubscription<UserModel?> listenUser;

  late String userId;

  UserModel? _user;

  TextEditingController controllerUyelik = TextEditingController();

  TextEditingController controllerEmail = TextEditingController();

  TextEditingController controllerTel = TextEditingController();

  TextEditingController controllerSoyadi = TextEditingController();

  TextEditingController controllerAdi = TextEditingController();

  var formKeyChangeEmail = GlobalKey<FormState>();

  TextEditingController controllerChangeEmailPassword = TextEditingController();

  TextEditingController controllerChangeEmailEmail = TextEditingController();

  TextEditingController controllerChangePasswordOldPass =
      TextEditingController();
  TextEditingController controllerChangePasswordNew1Pass =
      TextEditingController();
  TextEditingController controllerChangePasswordNew2Pass =
      TextEditingController();

  bool _isPassVisible = false;

  String? _warningOldPass;

  String? _warningNewPass;

  String? _warningNewEmail;

  String? get warningNewEmail => _warningNewEmail;

  set warningNewEmail(String? value) {
    _warningNewEmail = value;
    notifyListeners();
  }

  String? get warningOldPass => _warningOldPass;

  set warningOldPass(String? value) {
    _warningOldPass = value;
    notifyListeners();
  }

  String? get warningNewPass => _warningNewPass;

  set warningNewPass(String? value) {
    _warningNewPass = value;
    notifyListeners();
  }

  bool get isPassVisible => _isPassVisible;
  set isPassVisible(bool value) {
    _isPassVisible = value;
    notifyListeners();
  }

  UserModel? get user => _user;

  set user(UserModel? value) {
    _user = value;
    notifyListeners();
  }

  bool get isEditing => _isEditing;

  set isEditing(bool isEditing) {
    _isEditing = isEditing;
    notifyListeners();
  }

  bool get isBottomOpen => _isBottomOpen;

  set isBottomOpen(bool value) {
    _isBottomOpen = value;
    notifyListeners();
  }

  void setController() {
    bas("user.toString()");
    bas(user.toString());

    controllerUyelik = TextEditingController(
        text: user?.uyelikTipi?.getUyelikTipiBaslik ?? "");

    controllerEmail =
        TextEditingController(text: auth.currentUserEmail ?? user?.email ?? "");

    controllerTel = TextEditingController(text: user?.phoneNumber ?? "");

    controllerSoyadi = TextEditingController(text: user?.soyadi ?? "");

    controllerAdi = TextEditingController(text: user?.adi ?? "");
  }

  setUsersField() {
    modeliHazirla();
    modeliYaz();
  }

  void modeliHazirla() {}

  void modeliYaz() {}

  Future<bool> changeEmail() async {
    String? checkResult =
        await checkPassword(controllerChangeEmailPassword.text);
    if (checkResult == null) {
      var result =
          await auth.updateEmailVerify(controllerChangeEmailEmail.text.trim());

      bas("email update HATALARI => e.code");
      bas(result);

      if (result == null) {
        return true;
      } else if (result == "invalid-email") {
        warningNewEmail = "Geçersiz Email adresi";
      } else if (result == "email-already-in-use") {
        warningNewEmail = "Email zaten kullanımda";
      } else {
        warningNewEmail = "Bişeyler yanlış gitti";
      }
    } else {
      warningOldPass = "Sanırım şifre hatalı";
    }
    return false;
  }

  Future<String?> checkPassword(String password) async {
    return await auth.checkPassword(password);
  }

  void setPassVisibility() {
    isPassVisible = !isPassVisible;
  }

  Future<bool> changePassword() async {
    warningNewPass = warningOldPass = null;

    String? chechResult =
        await checkPassword(controllerChangePasswordOldPass.text);
    bas(chechResult);

    if (chechResult == null) {
      if (controllerChangePasswordNew1Pass.text ==
          controllerChangePasswordNew2Pass.text) {
        var result =
            await auth.updatePassword(controllerChangePasswordNew1Pass.text);

        if (result == null) {
          return true;
        } else {
          if (result == "weak-password") {
            warningNewPass = "Daha güçlü bir şifre giriniz";
          } else {
            warningNewPass = "Tekrar deneyiniz";
          }
        }
      } else {
        warningNewPass = "Şifreler aynı olmalı";
      }
    } else {
      warningOldPass = "Şifre hatalı olmalı";
    }
    return false;
  }

  void removeDialogFields() {
    controllerChangeEmailEmail.text = controllerChangeEmailPassword.text =
        controllerChangePasswordNew1Pass.text = controllerChangePasswordNew2Pass
            .text = controllerChangePasswordOldPass.text = "";
    warningNewEmail = warningNewPass = warningOldPass = null;
  }

  Future<void> saveFields() async {
    await dbUtil.addOrSetModel<UserModel>(user!.copyWith(
        adi: controllerAdi.text.trim(),
        email: controllerEmail.text.trim(),
        id: userId,
        kayitTarihi: Timestamp.fromDate(
            AuthService().currentUser?.metadata.creationTime ?? DateTime.now()),
        phoneNumber: controllerTel.text.trim(),
        soyadi: controllerSoyadi.text.trim(),
        uyelikTipi: UyelikTipi.lite));
  }

  @override
  void dispose() {
    listenUser.cancel();
    super.dispose();
  }
}
