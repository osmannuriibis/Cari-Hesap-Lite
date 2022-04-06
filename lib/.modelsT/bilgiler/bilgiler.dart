//birimler
//cariGrup
//

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

abstract class Bilgiler extends BaseModel {
  static const String fiyatlar = "fiyatlar";

  Bilgiler();
  static const String birimler = "birimler";
  static const String cariGrup = "cariGrup";

  /// ->...tablo[i]/masrafKategori/$[ana masraf]/
  ///                                     $[alt masraf]/$[alt masraf]
  ///                                     $[alt masraf 2]/$[alt masraf 2]
  ///
  /// for document reference
  static const String masrafKategori = "masrafKategori";

  ///for ColRef
  static String anaMasraf = "anaMasraf";

  static String altMasraf = "altMasraf";

  @override
  BaseModel fromMap(Map<String,dynamic>? map) {
    return Bilgiler.fromMap(map);
  }

  factory Bilgiler.fromMap(Map<String,dynamic>? map) {
    throw UnimplementedError();
  }

  @override
  Map<String,dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
