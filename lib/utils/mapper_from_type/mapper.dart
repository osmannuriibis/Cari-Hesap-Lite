import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/models/siparis_model.dart';
import 'package:cari_hesapp_lite/models/stok_hareket.dart';
import 'package:cari_hesapp_lite/models/user_model.dart';

class Mapper {
  static T fromMap<T>(Map<String, dynamic> map) {
    

    if (T == CariKart) {
      return CariKart.fromMap(map) as T;
    } else if (T == HesapHareket) {
      return HesapHareket.fromMap(map) as T;
    } else if (T == UserModel) {
      return UserModel.fromMap(map) as T;
    } else if (T == CariIslemModel) {
      return CariIslemModel.fromMap(map) as T;
    } else if (T == StokHareket) {
      return StokHareket.fromMap(map) as T;
    } else if (T == SiparisModel) {
      return SiparisModel.fromMap(map) as T;
    } else {
      throw Exception("$T type no exists => Mapper.fromMap() ");
    }
  }
}
