import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  late FirebaseAuth auth;
  User? _currentUser;

  User? get currentUser => _currentUser ??= auth.currentUser;

  set currentUser(User? value) {
    _currentUser = value;
    notifyListeners();
  }

  AuthService() {
    auth = FirebaseAuth.instance;
  } // /* auth ?? */ FirebaseAuth.instance;

  String? get currentUserEmail => currentUser?.email;

  String? get currentUserDisplayName => currentUser?.displayName;

  String? get currentUserId => currentUser?.uid;

  //WEAP => WithEmailAndPassword

  //Kullanıcı başka kullanıcı alt kullanıcısı mı sorgusu
  String? get mainUserId => (true /* sorgu */) ? currentUserId : null;

  Future<UserCredential?> singInWEAP(
      {required String email, required String password}) async {
    return await auth
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then<UserCredential>((user) => user);
  }

  Future<UserCredential> createUserWEAP(
      {required String email, required String password}) async {
  
      return await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) => user);
  
  }

  Future<void> sendVerification() {
    return auth.currentUser!.sendEmailVerification();
  }

  signOut() async {
    await auth.signOut();
    notifyListeners();

    
  }

  Future<String?> updatePassword(String newPassword) async {
    String? error;
    await auth.currentUser!.updatePassword(newPassword).then((value) {
      error = null;
    }).onError((FirebaseAuthException e, stackTrace) {
      error = e.code;
    });
    return error;
  }

  Future<String?> updateEmailVerify(String newEmail) async {
    String? err;
    await auth.currentUser!
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
      return err.code;
    }
  }

  StreamSubscription<User?> Function(void Function(User? event)? onData,
      {bool? cancelOnError,
      void Function()? onDone,
      Function? onError}) listenUserChanges() {
    return auth.userChanges().listen;
  }

  Stream<User?> authStateChanges() => auth.authStateChanges();

  Future<void> resetPassword(String email) {
    return auth.sendPasswordResetEmail(email: email);
  }
}
