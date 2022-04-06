import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';

import 'depo.dart';

Future<num> getStokMiktarFromAllDepo(String stokId) async {
  num miktar = 0.0;

  var docList = (await DBUtils(). getClassReference<DepoModel>().get()).docs;
  for (var doc in docList) {
    var map = (doc.get("stokMiktar") as Map?);
    if (map == null) continue;
    for (var item in map.entries) {
      if (item.key == stokId) {
        miktar += item.value as num;
      }
    }
  }
  return miktar;
}

Future<num> getStokMiktarFromTheDepo(String depoId, String stokId) async {
  num miktar = 0.0;

  var map =
      (await DBUtils().getModelReference<DepoModel>(depoId).get()).get("stokMiktar") as Map;

  for (var item in map.entries) {
    if (item.key == stokId) {
      miktar += item.value as num;
    }
  }

  return miktar;
}
