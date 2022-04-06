import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/hesaplar_model/kasa/kasa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../aaa_main/hesap_abstract.dart';

///güncel toplam borcunu gösterir
/*  num? bakiye; */
class KartHesap implements BankaHesaplarBaseModel {
  @override
  String? aciklama;

  @override
  String? bagliBankaAdi;

  @override
  String? bagliBankaId;

  @override
  num? bakiye;

  @override
  String? hesapAdi;

  @override
  String? id;

  @override
  late ParaBirimi paraBirimi;

  Timestamp? ekstreTarihi;
  KartHesap({
    this.aciklama = "",
    this.bagliBankaAdi = "",
    this.bagliBankaId,
    this.bakiye = 0,
    this.hesapAdi = "",
    this.id,
    this.paraBirimi = ParaBirimi.TRY,
    this.ekstreTarihi,
  });

  @override
  KasaModel fromMap(Map<String, dynamic> map) {
    return KasaModel.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'aciklama': aciklama,
      'bagliHesapAdi': bagliBankaAdi,
      'bagliHesapId': bagliBankaId,
      'bakiye': bakiye,
      'hesapAdi': hesapAdi,
      'id': id,
      'paraBirimi': paraBirimi.getKodu,
      'ekstreTarihi': ekstreTarihi,
    };
  }

  KartHesap copyWith({
    String? aciklama,
    String? bagliHesapAdi,
  required  String? bagliHesapId,
    num? bakiye,
    String? hesapAdi,
    String? id,
    ParaBirimi? paraBirimi,
    Timestamp? ekstreTarihi,
  }) {
    return KartHesap(
      aciklama: aciklama ?? this.aciklama,
      bagliBankaAdi: bagliHesapAdi ?? bagliBankaAdi,
      bagliBankaId: bagliHesapId ?? bagliBankaId,
      bakiye: bakiye ?? this.bakiye,
      hesapAdi: hesapAdi ?? this.hesapAdi,
      id: id ?? this.id,
      paraBirimi: paraBirimi ?? this.paraBirimi,
      ekstreTarihi: ekstreTarihi ?? this.ekstreTarihi,
    );
  }

  factory KartHesap.fromMap(Map<String, dynamic> map) {
    return KartHesap(
      aciklama: map['aciklama'],
      bagliBankaAdi: map['bagliHesapAdi'],
      bagliBankaId: map['bagliHesapId'],
      bakiye: map['bakiye'],
      hesapAdi: map['hesapAdi'],
      id: map['id'],
      paraBirimi: (map['paraBirimi'] as String).toParaBirimiFromKodu,
      ekstreTarihi: map['ekstreTarihi'] 
    );
  }

  String toJson() => json.encode(toMap());

  factory KartHesap.fromJson(String source) =>
      KartHesap.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KartHesap(aciklama: $aciklama, bagliHesapAdi: $bagliBankaAdi, bagliHesapId: $bagliBankaId, bakiye: $bakiye, hesapAdi: $hesapAdi, id: $id, paraBirimi: $paraBirimi, ekstreTarihi: $ekstreTarihi)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KartHesap &&
        other.aciklama == aciklama &&
        other.bagliBankaAdi == bagliBankaAdi &&
        other.bagliBankaId == bagliBankaId &&
        other.bakiye == bakiye &&
        other.hesapAdi == hesapAdi &&
        other.id == id &&
        other.paraBirimi == paraBirimi &&
        other.ekstreTarihi == ekstreTarihi;
  }

  @override
  int get hashCode {
    return aciklama.hashCode ^
        bagliBankaAdi.hashCode ^
        bagliBankaId.hashCode ^
        bakiye.hashCode ^
        hesapAdi.hashCode ^
        id.hashCode ^
        paraBirimi.hashCode ^
        ekstreTarihi.hashCode;
  }

  
}
