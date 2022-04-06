import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/models/para_hareket.dart';

import '../aaa_main/hesap_abstract.dart';

class PosHesap implements  BankaHesaplarBaseModel {
  @override
  String? id;
  @override
  String? hesapAdi;
  @override
  num? bakiye;
  @override
  late ParaBirimi paraBirimi;
  @override
  String? aciklama;
  @override
  String? bagliBankaId;
  @override
  String? bagliBankaAdi;
  ///
  int? vadeSuresi;
  num? komisyonOrani;
  PosHesap({
    this.id,
    this.hesapAdi = "",
    this.bakiye = 0,
    this.paraBirimi = ParaBirimi.TRY
    ,
    this.aciklama = "" ,
    this.bagliBankaId,
    this.bagliBankaAdi = "",
    this.vadeSuresi = 0 ,
    this.komisyonOrani = 0,
  });

  PosHesap copyWith({
    String? id,
    String? hesapAdi,
    num? bakiye,
    ParaBirimi? paraBirimi,
    String? aciklama,
  required  String? bagliHesapId,
    String? bagliHesapAdi,
    int? vadeSuresi,
    double? komisyonOrani,
  }) {
    return PosHesap(
      id: id ?? this.id,
      hesapAdi: hesapAdi ?? this.hesapAdi,
      bakiye: bakiye ?? this.bakiye,
      paraBirimi: paraBirimi ?? this.paraBirimi,
      aciklama: aciklama ?? this.aciklama,
      bagliBankaId: bagliHesapId ?? this.bagliBankaId,
      bagliBankaAdi: bagliHesapAdi ?? this.bagliBankaAdi,
      vadeSuresi: vadeSuresi ?? this.vadeSuresi,
      komisyonOrani: komisyonOrani ?? this.komisyonOrani,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hesapAdi': hesapAdi,
      'bakiye': bakiye,
      'paraBirimi': paraBirimi.getKodu,
      'aciklama': aciklama,
      'bagliHesapId': bagliBankaId,
      'bagliHesapAdi': bagliBankaAdi,
      'vadeSuresi': vadeSuresi,
      'komisyonOrani': komisyonOrani,
    };
  }

  factory PosHesap.fromMap(Map<String, dynamic> map) {
    return PosHesap(
      id: map['id'],
      hesapAdi: map['hesapAdi'],
      bakiye: map['bakiye'],
      paraBirimi: (map['paraBirimi'] as String).toParaBirimiFromKodu,
      aciklama: map['aciklama'],
      bagliBankaId: map['bagliHesapId'],
      bagliBankaAdi: map['bagliHesapAdi'],
      vadeSuresi: map['vadeSuresi']?.toInt(),
      komisyonOrani: map['komisyonOrani']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PosHesap.fromJson(String source) =>
      PosHesap.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PosHesap(id: $id, hesapAdi: $hesapAdi, bakiye: $bakiye, paraBirimi: $paraBirimi, aciklama: $aciklama, bagliHesapId: $bagliBankaId, bagliHesapAdi: $bagliBankaAdi, vadeSuresi: $vadeSuresi, komisyonOrani: $komisyonOrani)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PosHesap &&
      other.id == id &&
      other.hesapAdi == hesapAdi &&
      other.bakiye == bakiye &&
      other.paraBirimi == paraBirimi &&
      other.aciklama == aciklama &&
      other.bagliBankaId == bagliBankaId &&
      other.bagliBankaAdi == bagliBankaAdi &&
      other.vadeSuresi == vadeSuresi &&
      other.komisyonOrani == komisyonOrani;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        hesapAdi.hashCode ^
        bakiye.hashCode ^
        paraBirimi.hashCode ^
        aciklama.hashCode ^
        bagliBankaId.hashCode ^
        bagliBankaAdi.hashCode ^
        vadeSuresi.hashCode ^
        komisyonOrani.hashCode;
  }

  @override
  BaseModel? fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }
}
