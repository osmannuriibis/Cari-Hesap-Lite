import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Taksit extends BaseModel {
  String? id;
  String? islemKodu;
  Timestamp? odemeTarihi; //microsecond
  num? tutar;
  ParaBirimi paraBirimi;
  bool? odenmeDurumu;
  int? taksitSirasi;
  int? toplamTaksitSayisi;
  String? altKalem;
  String? anaKalem;

  String? hesapId;
  String? hesadAdi;

  Taksit({
    String? id,
    this.islemKodu,
    this.odemeTarihi,
    this.tutar,
    this.paraBirimi = ParaBirimi.TRY
    ,
    this.odenmeDurumu,
    this.taksitSirasi,
    this.toplamTaksitSayisi,
    this.altKalem,
    this.anaKalem,
    this.hesapId,
    this.hesadAdi,
  });

  Taksit copyWith({
    String? id,
    String? islemKodu,
    Timestamp? odemeTarihi,
    num? tutar,
    ParaBirimi? paraBirimi,
    bool? odenmeDurumu,
    int? taksitSirasi,
    int? toplamTaksitSayisi,
    String? altKalem,
    String? anaKalem,
    String? hesapId,
    String? hesadAdi,
  }) {
    return Taksit(
      id: id ?? this.id,
      islemKodu: islemKodu ?? this.islemKodu,
      odemeTarihi: odemeTarihi ?? this.odemeTarihi,
      tutar: tutar ?? this.tutar,
      paraBirimi: paraBirimi ?? this.paraBirimi,
      odenmeDurumu: odenmeDurumu ?? this.odenmeDurumu,
      taksitSirasi: taksitSirasi ?? this.taksitSirasi,
      toplamTaksitSayisi: toplamTaksitSayisi ?? this.toplamTaksitSayisi,
      altKalem: altKalem ?? this.altKalem,
      anaKalem: anaKalem ?? this.anaKalem,
      hesapId: hesapId ?? this.hesapId,
      hesadAdi: hesadAdi ?? this.hesadAdi,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'islemKodu': islemKodu,
      'odemeTarihi': odemeTarihi ,
      'tutar': tutar,
      'paraBirimi': paraBirimi.toMap(),
      'odenmeDurumu': odenmeDurumu,
      'taksitSirasi': taksitSirasi,
      'toplamTaksitSayisi': toplamTaksitSayisi,
      'altKalem': altKalem,
      'anaKalem': anaKalem,
      'hesapId': hesapId,
      'hesadAdi': hesadAdi,
    };
  }

  factory Taksit.fromMap(Map<String, dynamic> map) {
    return Taksit(
      id: map['id'],
      islemKodu: map['islemKodu'],
      odemeTarihi: map['odemeTarihi'],
      tutar: map['tutar'],
      paraBirimi: (map['paraBirimi'] as String ) .toParaBirimiFromKodu,
      odenmeDurumu: map['odenmeDurumu'],
      taksitSirasi: map['taksitSirasi']?.toInt(),
      toplamTaksitSayisi: map['toplamTaksitSayisi']?.toInt(),
      altKalem: map['altKalem'],
      anaKalem: map['anaKalem'],
      hesapId: map['hesapId'],
      hesadAdi: map['hesadAdi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Taksit.fromJson(String source) => Taksit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Taksit(id: $id, islemKodu: $islemKodu, odemeTarihi: $odemeTarihi, tutar: $tutar, paraBirimi: $paraBirimi, odenmeDurumu: $odenmeDurumu, taksitSirasi: $taksitSirasi, toplamTaksitSayisi: $toplamTaksitSayisi, altKalem: $altKalem, anaKalem: $anaKalem, hesapId: $hesapId, hesadAdi: $hesadAdi)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Taksit &&
      other.id == id &&
      other.islemKodu == islemKodu &&
      other.odemeTarihi == odemeTarihi &&
      other.tutar == tutar &&
      other.paraBirimi == paraBirimi &&
      other.odenmeDurumu == odenmeDurumu &&
      other.taksitSirasi == taksitSirasi &&
      other.toplamTaksitSayisi == toplamTaksitSayisi &&
      other.altKalem == altKalem &&
      other.anaKalem == anaKalem &&
      other.hesapId == hesapId &&
      other.hesadAdi == hesadAdi;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      islemKodu.hashCode ^
      odemeTarihi.hashCode ^
      tutar.hashCode ^
      paraBirimi.hashCode ^
      odenmeDurumu.hashCode ^
      taksitSirasi.hashCode ^
      toplamTaksitSayisi.hashCode ^
      altKalem.hashCode ^
      anaKalem.hashCode ^
      hesapId.hashCode ^
      hesadAdi.hashCode;
  }

  @override
  Taksit fromMap(Map<String, dynamic> map) {
    return Taksit.fromMap(map);
  }
}
