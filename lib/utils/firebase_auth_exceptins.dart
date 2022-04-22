import 'package:cari_hesapp_lite/utils/print.dart';

String getAuthExceptionMessage(String errorCode) {
  bas("errorCode in FireAuthMessage");
  bas(errorCode);
  switch (errorCode) {
    case 'invalid-email':
      return "Geçersiz Email";
    case 'user-disabled':
      return "Pasif Kullanıcı";
    case 'user-not-found':
      return "Kullanıcı bulunamadı";
    case 'wrong-password':
      return "Yanlış Şifre";
    case 'email-already-in-use':
      return "Kayıtlı email girdiniz";
    case 'operation-not-allowed':
      return "Kısıtlanmış giriş";
    case 'weak-password':
      return "Zayıf şifre girdiniz";

    default:
      return "Birşeyler ters gitti";
  }

/*

email-already-in-use:
Thrown if there already exists an account with the given email address.

operation-not-allowed:
Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.
weak-password:


 invalid-email:
Thrown if the email address is not valid.
user-disabled:
Thrown if the user corresponding to the given email has been disabled.
user-not-found:
Thrown if there is no user corresponding to the given email.
wrong-password:
Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set. */
}
