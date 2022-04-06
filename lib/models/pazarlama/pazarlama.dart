import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/models/konum.dart';
import 'package:cari_hesapp_lite/utils/konum_service/konum_extension.dart';
import 'package:cari_hesapp_lite/utils/print.dart';

class PazarlamaModel extends BaseModel {
  @override
  String? id;

  String? unvani;

  String? yetkiliAdi;
  String? yetkiliNo;

  Timestamp? kayitTarihi;

  Timestamp? hatirlatici;

  List<dynamic>? telNo;
  String? email;

  String? adres;
  String? sehir;
  String? ilce;

  Konum? konum;

  String? aciklama;
  PazarlamaModel({
    this.id,
    this.unvani,
    this.yetkiliAdi,
    this.yetkiliNo,
    this.kayitTarihi,
    this.hatirlatici,
    this.telNo,
    this.email,
    this.adres,
    this.sehir,
    this.ilce,
    this.konum,
    this.aciklama,
  });

  @override
  PazarlamaModel fromMap(Map<String, dynamic> map) {
    return fromMap(map);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unvani': unvani,
      'yetkiliAdi': yetkiliAdi,
      'yetkiliNo': yetkiliNo,
      'kayitTarihi': kayitTarihi ,
      'hatirlatici': hatirlatici ,
      'telNo': telNo,
      'email': email,
      'adres': adres,
      'sehir': sehir,
      'ilce': ilce,
      'konum': konum?.toMap(),
      'aciklama': aciklama,
    };
  }

  PazarlamaModel copyWith({
    String? id,
    String? unvani,
    String? yetkiliAdi,
    String? yetkiliNo,
    Timestamp? kayitTarihi,
    Timestamp? hatirlatici,
    List<dynamic>? telNo,
    String? email,
    String? adres,
    String? sehir,
    String? ilce,
    Konum? konum,
    String? aciklama,
  }) {
    return PazarlamaModel(
      id: id ?? this.id,
      unvani: unvani ?? this.unvani,
      yetkiliAdi: yetkiliAdi ?? this.yetkiliAdi,
      yetkiliNo: yetkiliNo ?? this.yetkiliNo,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      hatirlatici: hatirlatici,
      telNo: telNo ?? this.telNo,
      email: email ?? this.email,
      adres: adres ?? this.adres,
      sehir: sehir ?? this.sehir,
      ilce: ilce ?? this.ilce,
      konum: konum ?? this.konum,
      aciklama: aciklama ?? this.aciklama,
    );
  }

  factory PazarlamaModel.fromMap(Map<String, dynamic> map) {
    return PazarlamaModel(
      id: map['id'],
      unvani: map['unvani'],
      yetkiliAdi: map['yetkiliAdi'],
      yetkiliNo: map['yetkiliNo'],
      kayitTarihi: map['kayitTarihi'] ,
      hatirlatici: map['hatirlatici'] ,
      telNo: List<dynamic>.from(map['telNo']),
      email: map['email'],
      adres: map['adres'],
      sehir: map['sehir'],
      ilce: map['ilce'],
      konum: map['konum'] != null ? Konum.fromMap(map['konum']) : null,
      aciklama: map['aciklama'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PazarlamaModel.fromJson(String source) =>
      PazarlamaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PazarlamaModel(id: $id, unvani: $unvani, yetkiliAdi: $yetkiliAdi, yetkiliNo: $yetkiliNo, kayitTarihi: $kayitTarihi, hatirlatici: $hatirlatici, telNo: $telNo, email: $email, adres: $adres, sehir: $sehir, ilce: $ilce, konum: $konum, aciklama: $aciklama)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PazarlamaModel &&
        other.id == id &&
        other.unvani == unvani &&
        other.yetkiliAdi == yetkiliAdi &&
        other.yetkiliNo == yetkiliNo &&
        other.kayitTarihi == kayitTarihi &&
        other.hatirlatici == hatirlatici &&
        listEquals(other.telNo, telNo) &&
        other.email == email &&
        other.adres == adres &&
        other.sehir == sehir &&
        other.ilce == ilce &&
        other.konum == konum &&
        other.aciklama == aciklama;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unvani.hashCode ^
        yetkiliAdi.hashCode ^
        yetkiliNo.hashCode ^
        kayitTarihi.hashCode ^
        hatirlatici.hashCode ^
        telNo.hashCode ^
        email.hashCode ^
        adres.hashCode ^
        sehir.hashCode ^
        ilce.hashCode ^
        konum.hashCode ^
        aciklama.hashCode;
  }
}
