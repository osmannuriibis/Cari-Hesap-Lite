import 'dart:async';

import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class VerifyViewModel extends ChangeNotifier {
  late StreamSubscription<User?> listenUser;
  var key = GlobalKey<ScaffoldState>();
  VerifyViewModel() {
    sendVerify();
  }

  listenVerify() {
    listenUser = AuthService().listenUserChanges().call(
      (event) {
        bas("User Değişti", this);

        bas("event --- " * 10);
        bas(event);
      },
    );
  }

  Future<void> sendVerify() async {
    bas("sendVerify");
    AuthService().sendVerification();

    while (true) {
      await Future.delayed(const Duration(seconds: 3)).then((value) => null);
      bas("whie");
      applyVerification();
    }
  }

  void applyVerification() {
    AuthService().currentUser!.reload();
    if (AuthService().currentUser!.emailVerified) {
      bas("burada");
      Phoenix.rebirth(key.currentContext!);
    }
  }
}
