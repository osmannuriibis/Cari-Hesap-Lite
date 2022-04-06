import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/models/bilgiler/bilgiler.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';

///Bilgiler.cariGrup & Bilgiler.birimler

DocumentReference<Map<String,dynamic>> getBilgilerDocRef(String docName) {
  return DBUtils().getModelReference<Bilgiler>(docName);
}

///[docNameId] Bilgiler.cariGrup & Bilgiler.birimler
///
///
Future<String?> addOrSetBilgiler(String docNameId, String fieldName)  {
  
  return getBilgilerDocRef(docNameId).update({fieldName : fieldName}).getBoolResultForFirebase();
}
