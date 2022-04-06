import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/models/bilgiler/bilgiler.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';

CollectionReference<Map<String, dynamic>> getAnaMasrafColRef() {
  return DBUtils()
      .getClassReference<Bilgiler>()
      .doc(Bilgiler.masrafKategori)
      .collection(Bilgiler.anaMasraf);
}

DocumentReference<Map<String, dynamic>> getAnaMasrafDocRef(String masrafId) {
  return getAnaMasrafColRef().doc(masrafId);
}

CollectionReference<Map<String, dynamic>> getAltMasrafColRef(
    String anaMasrafId) {
  return getAnaMasrafDocRef(anaMasrafId).collection(Bilgiler.altMasraf);
}

DocumentReference<Map<String, dynamic>> getAltMasrafDocRef(
    String anaMasrafId, String altMasrafId) {
  return getAltMasrafColRef(anaMasrafId).doc(altMasrafId);
}

Future<MapEntry> getAltMasrafMapByIds(
    String anaMasrafId, String altMasrafId) async {
  var anaDocRef = getAnaMasrafDocRef(anaMasrafId);
  String anaAdi = (await anaDocRef.get()).get("adi");

  var altDocRef = getAltMasrafDocRef(anaMasrafId, altMasrafId);
  String altAdi = (await altDocRef.get()).get("adi");

  return MapEntry(anaAdi, altAdi);
}

Future<String?> addOrSetAltMasraf(String anaMasrafId, String altMasrafAdi,
    {String? altMasrafId}) async {
  var id = getAltMasrafColRef(anaMasrafId).doc(altMasrafId).id;
  return await getAltMasrafColRef(anaMasrafId)
      .doc(id)
      .set({'adi': altMasrafAdi.toCapForEachOne()}).getBoolResultForFirebase();

  
}

Future<String?> addOrSetAnaMasraf(String anaMasrafAdi,
    [String? anaMasrafId]) async {
  var id = getAnaMasrafColRef().doc(anaMasrafId).id;
  return  await getAnaMasrafColRef()
      .doc(id)
      .set({'adi': anaMasrafAdi.toCapForEachOne()}).getBoolResultForFirebase();

  
}

Future<String?> deleteAnaMasraf(String id) {
  var ref = getAnaMasrafDocRef(id);
 return ref.delete().getBoolResultForFirebase();
}

Future<String?> deleteAltMasraf(String altMasrafId, String anaMasrafId) {
  return getAltMasrafDocRef(anaMasrafId, altMasrafId).delete().getBoolResultForFirebase();
}
