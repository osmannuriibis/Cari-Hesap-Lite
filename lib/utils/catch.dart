import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';

///returns always [false]
String fetchCatch(
  Exception err,
   thisObject,
) {
  bas("-HATA---" * 5);

  bas("InRunType : $thisObject  Hata Mesajı: $err");

  if (err.runtimeType == FirebaseException) {
    bas((err as FirebaseException).code);
    return err.code;
  }
  return err.toString();
}
