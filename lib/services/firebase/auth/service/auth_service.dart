import 'dart:async';

import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  late FirebaseAuth _auth;
  User? _currentUser;

  User? get currentUser => _currentUser ??= _auth.currentUser;

  set currentUser(User? value) {
    _currentUser = value;
    notifyListeners();
  }

  AuthService() {
    _auth = FirebaseAuth.instance;
  } // /* auth ?? */ FirebaseAuth.instance;

  String? get currentUserEmail => currentUser?.email;

  String? get currentUserDisplayName => currentUser?.displayName;

  String? get currentUserId => currentUser?.uid;

  //WEAP => WithEmailAndPassword

  //Kullanıcı başka kullanıcı alt kullanıcısı mı sorgusu
  String? get mainUserId => (true /* sorgu */) ? currentUserId : null;

  Future<UserCredential?> singInWEAP(
      {required String email, required String password}) async {
    try {
      return await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then<UserCredential>((user) => user);
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<UserCredential?> createUserWEAP(
      {required String email, required String password}) async {
    try {
      return await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) => user);
    } catch (e) {
      
      return null;
    }
  }

  Future<void> sendVerification() {
    
    return  _auth.currentUser!.sendEmailVerification();
    
  }
  /**/

  signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<String?> updatePassword(String newPassword) async {
    String? error;
    await _auth.currentUser!.updatePassword(newPassword).then((value) {
      error = null;
    }).onError((FirebaseAuthException e, stackTrace) {
      error = e.code;
    });
    return error;
  }

  Future<String?> updateEmailVerify(String newEmail) async {
    String? err;
    bas("newEmail " * 5);
    bas(newEmail);
    await _auth.currentUser!
        .verifyBeforeUpdateEmail(
      newEmail,
      /*   ActionCodeSettings(
                url: "http://www.osman.com",
                androidPackageName: "com.example.cari_takip") */
    )
        .then((value) {
      err = null;
    }).onError((FirebaseAuthException error, stackTrace) {
      err = error.code;
    });
    return err;
  }

  Future<String?> checkPassword(String password) async {
    try {
      var userCredential =
          await singInWEAP(email: currentUserEmail!, password: password);

      return userCredential?.user != null ? null : "something-went-wrong";
    } on FirebaseAuthException catch (err) {
      bas(err.code);
      return err.code;
    }
  }

  StreamSubscription<User?> Function(void Function(User? event)? onData,
      {bool? cancelOnError,
      void Function()? onDone,
      Function? onError}) listenUserChanges() {
    return _auth.userChanges().listen;
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }
}
