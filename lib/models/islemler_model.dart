import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///[id] = islemKodu
abstract class Islemler extends BaseModel {
  String? id; //islemKodu

  num? toplamTutar;

  ParaBirimi paraBirimi = ParaBirimi.TRY;

  Timestamp? islemTarihi;

  Timestamp? kayitTarihi;

  String? islemKodu;

  String? evrakNo;

  String? cariId;
  
  String? cariUnvani;

  String? personelId;
  String? kullaniciId;

  String? aciklama;

  num? kurOrani;
}
