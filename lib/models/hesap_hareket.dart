import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/islemler_model.dart';
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';

import '../enums/gelir_gider_turu.dart';
import '../enums/hesap_hareket_turu.dart';

class HesapHareketModel implements Islemler {
  @override
  String? id;

  ///para'nın geldiği birim; firma, cari veya herhangi bir hesap olabilir
  String? gelenID;

  ///para'nın geldiği birim; firma, cari veya herhangi bir hesap olabilir
  String? gelenAdi;

  ///para'nın gittiği birim Id'si; firma, cari veya herhangi bir hesap olabilir
  String? gidenId;

  ///para'nın gittiği birim adi; firma, cari veya herhangi bir hesap olabilir
  String? gidenAdi;

  ///İşlem bir [CariKart]'a aitse veri tutulur

  @override
  String? cariId;
  @override
  String? cariUnvani;

  HesapHareketTuru? hesapHareketTuru;

  @override
  ParaBirimi paraBirimi = ParaBirimi.TRY;

  GelirGiderTuru? gelirGiderTuru;

  @override
  num? toplamTutar;

  @override
  Timestamp? islemTarihi;

  @override
  Timestamp? kayitTarihi;

  @override
  String? evrakNo;

  @override
  String? personelId;

  @override
  String? kullaniciId;
  String? islemNoktasi;

  @override
  String? aciklama;

  @override
  num? kurOrani;

  @override
  String? islemKodu;
  HesapHareketModel({
    this.id,
    this.gelenID,
    this.gelenAdi,
    this.gidenId,
    this.gidenAdi,
    this.cariId,
    this.cariUnvani,
    this.gelirGiderTuru,
    this.hesapHareketTuru,
    this.toplamTutar,
    this.islemTarihi,
    this.kayitTarihi,
    this.evrakNo,
    this.personelId,
    this.kullaniciId,
    this.islemNoktasi,
    this.aciklama,
    this.kurOrani,
    this.islemKodu,
  });

  HesapHareketModel copyWith({
    String? id,
    String? gelenID,
    String? gelenAdi,
    String? gidenId,
    String? gidenAdi,
    String? cariId,
  required String? cariUnvani,
    GelirGiderTuru? gelirGiderTuru,
    HesapHareketTuru? hesapHareketTuru,
    num? toplamTutar,
    Timestamp? islemTarihi,
    Timestamp? kayitTarihi,
    String? evrakNo,
    String? personelId,
    String? kullaniciId,
    String? islemNoktasi,
    String? aciklama,
    num? kurOrani,
    String? islemKodu,
  }) {
    return HesapHareketModel(
      id: id ?? this.id,
      gelenID: gelenID ?? this.gelenID,
      gelenAdi: gelenAdi ?? this.gelenAdi,
      gidenId: gidenId ?? this.gidenId,
      gidenAdi: gidenAdi ?? this.gidenAdi,
      cariId: cariId ?? this.cariId,
      cariUnvani: cariUnvani ?? this.cariUnvani,
      gelirGiderTuru: gelirGiderTuru ?? this.gelirGiderTuru,
      toplamTutar: toplamTutar ?? this.toplamTutar,
      islemTarihi: islemTarihi ?? this.islemTarihi,
      hesapHareketTuru: hesapHareketTuru ?? this.hesapHareketTuru,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      evrakNo: evrakNo ?? this.evrakNo,
      personelId: personelId ?? this.personelId,
      kullaniciId: kullaniciId ?? this.kullaniciId,
      islemNoktasi: islemNoktasi ?? this.islemNoktasi,
      aciklama: aciklama ?? this.aciklama,
      kurOrani: kurOrani ?? this.kurOrani,
      islemKodu: islemKodu ?? this.islemKodu,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gelenID': gelenID,
      'gelenAdi': gelenAdi,
      'gidenId': gidenId,
      'gidenAdi': gidenAdi,
      'cariId': cariId,
      'cariUnvani': cariUnvani,
      'gelirGiderTuru': gelirGiderTuru?.toMap(),
      'hesapHareketTuru': hesapHareketTuru!.stringValue,
      'paraBirimi': paraBirimi.toMap(),
      'toplamTutar': toplamTutar,
      'islemTarihi': Timestamp.fromDate(islemTarihi?.toDate().add(const Duration(hours: 12)) ?? DateTime.now()),
      'kayitTarihi': kayitTarihi,
      'evrakNo': evrakNo,
      'personelId': personelId,
      'kullaniciId': kullaniciId,
      'islemNoktasi': islemNoktasi,
      'aciklama': aciklama,
      'kurOrani': kurOrani,
      'islemKodu': islemKodu,
    };
  }

  factory HesapHareketModel.fromMap(Map<String, dynamic> map) {
    return HesapHareketModel(
      id: map['id'],
      gelenID: map['gelenID'],
      gelenAdi: map['gelenAdi'],
      gidenId: map['gidenId'],
      gidenAdi: map['gidenAdi'],
      cariId: map['cariId'],
      cariUnvani: map['cariUnvani'],
      gelirGiderTuru: (map['gelirGiderTuru'] as String).toGelirGiderTuru,
      hesapHareketTuru: (map['hesapHareketTuru'] as String).toHesapHareketTuru,
      toplamTutar: map['toplamTutar'],
      islemTarihi: map['islemTarihi'],
      kayitTarihi: map['kayitTarihi'],
      evrakNo: map['evrakNo'],
      personelId: map['personelId'],
      kullaniciId: map['kullaniciId'],
      islemNoktasi: map['islemNoktasi'],
      aciklama: map['aciklama'],
      kurOrani: map['kurOrani'],
      islemKodu: map['islemKodu'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HesapHareketModel.fromJson(String source) =>
      HesapHareketModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HesapHareket(id: $id, gelenID: $gelenID, gelenAdi: $gelenAdi, gidenId: $gidenId, gidenAdi: $gidenAdi, cariId: $cariId, cariUnvani: $cariUnvani, gelirGiderTuru: $gelirGiderTuru, hesapHareketTuru: $hesapHareketTuru, toplamTutar: $toplamTutar, islemTarihi: $islemTarihi, kayitTarihi: $kayitTarihi, evrakNo: $evrakNo, personelId: $personelId, kullaniciId: $kullaniciId, islemNoktasi: $islemNoktasi, aciklama: $aciklama, kurOrani: $kurOrani, islemKodu: $islemKodu)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HesapHareketModel &&
        other.id == id &&
        other.gelenID == gelenID &&
        other.gelenAdi == gelenAdi &&
        other.gidenId == gidenId &&
        other.gidenAdi == gidenAdi &&
        other.cariId == cariId &&
        other.cariUnvani == cariUnvani &&
        other.gelirGiderTuru == gelirGiderTuru &&
        other.hesapHareketTuru == hesapHareketTuru &&
        other.toplamTutar == toplamTutar &&
        other.islemTarihi == islemTarihi &&
        other.kayitTarihi == kayitTarihi &&
        other.evrakNo == evrakNo &&
        other.personelId == personelId &&
        other.kullaniciId == kullaniciId &&
        other.islemNoktasi == islemNoktasi &&
        other.aciklama == aciklama &&
        other.kurOrani == kurOrani &&
        other.islemKodu == islemKodu;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gelenID.hashCode ^
        gelenAdi.hashCode ^
        gidenId.hashCode ^
        gidenAdi.hashCode ^
        cariId.hashCode ^
        cariUnvani.hashCode ^
        gelirGiderTuru.hashCode ^
        hesapHareketTuru.hashCode ^
        toplamTutar.hashCode ^
        islemTarihi.hashCode ^
        kayitTarihi.hashCode ^
        evrakNo.hashCode ^
        personelId.hashCode ^
        kullaniciId.hashCode ^
        islemNoktasi.hashCode ^
        aciklama.hashCode ^
        kurOrani.hashCode ^
        islemKodu.hashCode;
  }

  @override
  HesapHareketModel fromMap(Map<String, dynamic> map) {
    return fromMap(map);
  }
}
