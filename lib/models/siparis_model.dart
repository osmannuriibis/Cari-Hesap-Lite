import 'dart:convert';

import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/enums/siparis_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

class SiparisModel extends BaseModel {
  String? id;

  ///Ürün ID => [urunId]
  ///Ürün miktarı => [miktar]
  ///Ürün adi => [urunAdi]
  late List<SiparisKalemModel> siparisKalemleri;
  String? cariId;
  String? cariAdi;
  CariIslemTuru? cariIslemTuru;
  SiparisStatus? siparisStatus;
  Timestamp? kayitTarihi;
  Timestamp? siparisTarihi;
  String? personelId;
  String? aciklama;

  SiparisModel({
    this.id,
    this.cariId,
    this.cariAdi,
    this.cariIslemTuru,
    this.siparisStatus,
    this.kayitTarihi,
    this.siparisTarihi,
    this.personelId,
    this.aciklama,
    List<SiparisKalemModel>? siparisKalemleri,
  }) {
    this.siparisKalemleri = siparisKalemleri ?? [];
  }

  SiparisModel copyWith({
    String? id,
    String? cariId,
    required String? cariAdi,
    SiparisStatus? siparisStatus,
    CariIslemTuru? cariIslemTuru,
    Timestamp? kayitTarihi,
    Timestamp? siparisTarihi,
    String? personelId,
    String? aciklama,
    List<SiparisKalemModel>? siparisKalemleri,
  }) {
    return SiparisModel(
      id: id ?? this.id,
      cariId: cariId ?? this.cariId,
      cariAdi: cariAdi ?? this.cariAdi,
      siparisStatus: siparisStatus ?? this.siparisStatus,
      cariIslemTuru: cariIslemTuru ?? this.cariIslemTuru,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      siparisTarihi: siparisTarihi ?? this.siparisTarihi,
      personelId: personelId ?? this.personelId,
      aciklama:  aciklama ?? this.aciklama,
      siparisKalemleri: siparisKalemleri ?? this.siparisKalemleri,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cariId': cariId,
      'cariAdi': cariAdi,
      'siparisStatus': siparisStatus!.name,
      'cariIslemTuru': cariIslemTuru!.stringValue,
      'kayitTarihi': kayitTarihi,
      'siparisTarihi': siparisTarihi,
      'personelId': personelId,
      'aciklama'  : aciklama,
      'siparisKalemleri': siparisKalemleri.map((x) => x.toMap()).toList(),
    };
  }

  factory SiparisModel.fromMap(Map<String, dynamic> map) {
    return SiparisModel(
      id: map['id'],
      cariId: map['cariId'],
      cariAdi: map['cariAdi'],
      cariIslemTuru: (map['cariIslemTuru'] as String).toCariIslemTuru,
      siparisStatus: (map['siparisStatus'] as String).toSiparisStatus,
      kayitTarihi: map['kayitTarihi'],
      siparisTarihi: map['siparisTarihi'],
      personelId: map['personelId'],
      aciklama: map['aciklama'],
      siparisKalemleri: (map['siparisKalemleri'] as List?) != null
          ? List<SiparisKalemModel>.from((map['siparisKalemleri'] as List)
              .map((x) => SiparisKalemModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SiparisModel.fromJson(String source) =>
      SiparisModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SiparislerModel(id: $id, cariId: $cariId, cariAdi: $cariAdi, cariIslemTuru: $cariIslemTuru, siparisStatus: $siparisStatus,kayitTarihi: $kayitTarihi, siparisTarihi :$siparisTarihi, personelId: $personelId, aciklama: $aciklama, siparisKalemleri: $siparisKalemleri)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SiparisModel &&
        other.id == id &&
        other.cariId == cariId &&
        other.cariAdi == cariAdi &&
        other.siparisStatus == siparisStatus &&
        other.kayitTarihi == kayitTarihi &&
        other.siparisTarihi == siparisTarihi &&
        other.aciklama == aciklama &&
        listEquals(other.siparisKalemleri, siparisKalemleri);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      cariId.hashCode ^
      cariAdi.hashCode ^
      siparisStatus.hashCode ^
      cariIslemTuru.hashCode ^
      kayitTarihi.hashCode ^
      siparisTarihi.hashCode ^
      aciklama.hashCode ^ 
      siparisKalemleri.hashCode;

  @override
  SiparisModel? fromMap(Map<String, dynamic> map) {
    return fromMap(map);
  }
}

class SiparisKalemModel {
  String? id;
  String? urunId;
  String? urunAdi;
  num? urunMiktari;
  String? birim;

  removeFields() {
    id = urunAdi = urunId = birim = urunMiktari = null;
  }

  SiparisKalemModel({
    this.id,
    this.urunId,
    this.urunAdi,
    this.urunMiktari,
    this.birim,
  });

  SiparisKalemModel copyWith({
    String? id,
    String? urunId,
    String? urunAdi,
    num? urunMiktari,
    String? birim,
  }) {
    return SiparisKalemModel(
      id: id ?? this.id,
      urunId: urunId ?? this.urunId,
      urunAdi: urunAdi ?? this.urunAdi,
      urunMiktari: urunMiktari ?? this.urunMiktari,
      birim: birim ?? this.birim,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urunId': urunId,
      'urunAdi': urunAdi,
      'urunMiktari': urunMiktari,
      'birim': birim,
    };
  }

  factory SiparisKalemModel.fromMap(Map<String, dynamic> map) {
    return SiparisKalemModel(
      id: map['id'],
      urunId: map['urunId'],
      urunAdi: map['urunAdi'],
      urunMiktari: map['urunMiktari'],
      birim: map['birim'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SiparisKalemModel.fromJson(String source) =>
      SiparisKalemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SiparisKalemModel(id: $id, urunId: $urunId, urunAdi: $urunAdi, urunMiktari: $urunMiktari, birim: $birim) \n';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SiparisKalemModel &&
        other.id == id &&
        other.urunId == urunId &&
        other.urunAdi == urunAdi &&
        other.urunMiktari == urunMiktari &&
        other.birim == birim;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        urunId.hashCode ^
        urunAdi.hashCode ^
        urunMiktari.hashCode ^
        birim.hashCode;
  }
}
