import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/date_format.dart';

class Masraf extends BaseModel {
  String? id;
  String? islemKodu;

  int? taksitSayisi;
  Timestamp? ilkTaksitTarihi;
  Timestamp? sonTaksitTarihi;

  num? toplamTutar;
  num? kalanTutar;
  num? kdv;

  String? anaKalemAdi;
  String? altKalemAdi;
  String? belgeNo;
  Timestamp? tarih;
  String? aciklama;

  String? hesapId;
  String? kullaniciId;

  ParaBirimi paraBirimi;
  Masraf({
    this.id,
    this.islemKodu,
    this.taksitSayisi,
    this.ilkTaksitTarihi,
    this.sonTaksitTarihi,
    this.toplamTutar,
    this.kalanTutar,
    this.kdv,
    this.anaKalemAdi,
    this.altKalemAdi,
    this.belgeNo,
    this.tarih,
    this.aciklama,
    this.hesapId,
    this.kullaniciId,
    this.paraBirimi = ParaBirimi.TRY,
  });

  Masraf copyWith({
    String? id,
    String? islemKodu,
    int? taksitSayisi,
    Timestamp? ilkTaksitTarihi,
    Timestamp? sonTaksitTarihi,
    num? toplamTutar,
    num? kalanTutar,
    num? kdv,
    String? anaKalemAdi,
    String? altKalemAdi,
    String? belgeNo,
    Timestamp? tarih,
    String? aciklama,
    String? hesapId,
    String? kullaniciId,
    ParaBirimi? paraBirimi,
  }) {
    return Masraf(
      id: id ?? this.id,
      islemKodu: islemKodu ?? this.islemKodu,
      taksitSayisi: taksitSayisi ?? this.taksitSayisi,
      ilkTaksitTarihi: ilkTaksitTarihi ?? this.ilkTaksitTarihi,
      sonTaksitTarihi: sonTaksitTarihi ?? this.sonTaksitTarihi,
      toplamTutar: toplamTutar ?? this.toplamTutar,
      kalanTutar: kalanTutar ?? this.kalanTutar,
      kdv: kdv ?? this.kdv,
      anaKalemAdi: anaKalemAdi ?? this.anaKalemAdi,
      altKalemAdi: altKalemAdi ?? this.altKalemAdi,
      belgeNo: belgeNo ?? this.belgeNo,
      tarih: tarih ?? this.tarih,
      aciklama: aciklama ?? this.aciklama,
      hesapId: hesapId ?? this.hesapId,
      kullaniciId: kullaniciId ?? this.kullaniciId,
      paraBirimi: paraBirimi ?? this.paraBirimi,
    );
  }

  String toJson() => json.encode(toMap());

  factory Masraf.fromJson(String source) => Masraf.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Masraf(id: $id, islemKodu: $islemKodu, taksitSayisi: $taksitSayisi, ilkTaksitTarihi: $ilkTaksitTarihi, sonTaksitTarihi: $sonTaksitTarihi, toplamTutar: $toplamTutar, kalanTutar: $kalanTutar, kdv: $kdv, anaKalemAdi: $anaKalemAdi, altKalemAdi: $altKalemAdi, belgeNo: $belgeNo, tarih: $tarih, aciklama: $aciklama, hesapId: $hesapId, kullaniciId: $kullaniciId, paraBirimi: $paraBirimi)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Masraf &&
      other.id == id &&
      other.islemKodu == islemKodu &&
      other.taksitSayisi == taksitSayisi &&
      other.ilkTaksitTarihi == ilkTaksitTarihi &&
      other.sonTaksitTarihi == sonTaksitTarihi &&
      other.toplamTutar == toplamTutar &&
      other.kalanTutar == kalanTutar &&
      other.kdv == kdv &&
      other.anaKalemAdi == anaKalemAdi &&
      other.altKalemAdi == altKalemAdi &&
      other.belgeNo == belgeNo &&
      other.tarih == tarih &&
      other.aciklama == aciklama &&
      other.hesapId == hesapId &&
      other.kullaniciId == kullaniciId &&
      other.paraBirimi == paraBirimi;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      islemKodu.hashCode ^
      taksitSayisi.hashCode ^
      ilkTaksitTarihi.hashCode ^
      sonTaksitTarihi.hashCode ^
      toplamTutar.hashCode ^
      kalanTutar.hashCode ^
      kdv.hashCode ^
      anaKalemAdi.hashCode ^
      altKalemAdi.hashCode ^
      belgeNo.hashCode ^
      tarih.hashCode ^
      aciklama.hashCode ^
      hesapId.hashCode ^
      kullaniciId.hashCode ^
      paraBirimi.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'islemKodu': islemKodu,
      'taksitSayisi': taksitSayisi,
      'ilkTaksitTarihi': ilkTaksitTarihi ,
      'sonTaksitTarihi': sonTaksitTarihi ,
      'toplamTutar': toplamTutar,
      'kalanTutar': kalanTutar,
      'kdv': kdv,
      'anaKalemAdi': anaKalemAdi,
      'altKalemAdi': altKalemAdi,
      'belgeNo': belgeNo,
      'tarih': tarih ,
      'aciklama': aciklama,
      'hesapId': hesapId,
      'kullaniciId': kullaniciId,
      'paraBirimi': paraBirimi.toMap(),
    };
  }

  @override
  Masraf fromMap(Map<String, dynamic>  map) {
    return Masraf.fromMap(map);
  }

  factory Masraf.fromMap(Map<String, dynamic> map) {
    return Masraf(
      id: map['id'],
      islemKodu: map['islemKodu'],
      taksitSayisi: map['taksitSayisi']?.toInt(),
      ilkTaksitTarihi: map['ilkTaksitTarihi'] ,
      sonTaksitTarihi: map['sonTaksitTarihi'] ,
      toplamTutar: map['toplamTutar'],
      kalanTutar: map['kalanTutar'],
      kdv: map['kdv'],
      anaKalemAdi: map['anaKalemAdi'],
      altKalemAdi: map['altKalemAdi'],
      belgeNo: map['belgeNo'],
      tarih: map['tarih'] ,
      aciklama: map['aciklama'],
      hesapId: map['hesapId'],
      kullaniciId: map['kullaniciId'],
      paraBirimi: (map['paraBirimi'] as String).toParaBirimiFromKodu,
    );
  }
}
