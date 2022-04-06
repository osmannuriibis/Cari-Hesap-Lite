import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/models/hesaplar_model/banka/aaa_main/hesap_abstract.dart';

class BankaHesap implements BankaHesaplarBaseModel {
  String? hesapNo;
  String? subeAdi;
  String? iban;

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
  BankaHesap({
    this.hesapNo = "",
    this.subeAdi = "",
    this.iban = "",
    this.aciklama = "",
    this.bagliBankaAdi = "",
    this.bagliBankaId,
    this.bakiye = 0,
    this.hesapAdi = "",
    this.id,
    this.paraBirimi = ParaBirimi.TRY,
  });

  @override
  BaseModel? fromMap(Map<String, dynamic> map) {
    return fromMap(map);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'hesapNo': hesapNo,
      'subeAdi': subeAdi,
      'iban': iban,
      'aciklama': aciklama,
      'bagliHesapAdi': bagliBankaAdi,
      'bagliHesapId': bagliBankaId,
      'bakiye': bakiye,
      'hesapAdi': hesapAdi,
      'id': id,
      'paraBirimi': paraBirimi.getKodu,
    };
  }

  BankaHesap copyWith({
    String? hesapNo,
    String? subeAdi,
    String? iban,
    String? aciklama,
    String? bagliHesapAdi,
   required String? bagliHesapId,
    num? bakiye,
    String? hesapAdi,
    String? id,
    ParaBirimi? paraBirimi,
  }) {
    return BankaHesap(
      hesapNo: hesapNo ?? this.hesapNo,
      subeAdi: subeAdi ?? this.subeAdi,
      iban: iban ?? this.iban,
      aciklama: aciklama ?? this.aciklama,
      bagliBankaAdi: bagliHesapAdi ?? this.bagliBankaAdi,
      bagliBankaId: bagliHesapId ?? this.bagliBankaId,
      bakiye: bakiye ?? this.bakiye,
      hesapAdi: hesapAdi ?? this.hesapAdi,
      id: id ?? this.id,
      paraBirimi: paraBirimi ?? this.paraBirimi,
    );
  }

  factory BankaHesap.fromMap(Map<String, dynamic> map) {
    return BankaHesap(
      hesapNo: map['hesapNo'],
      subeAdi: map['subeAdi'],
      iban: map['iban'],
      aciklama: map['aciklama'],
      bagliBankaAdi: map['bagliHesapAdi'],
      bagliBankaId: map['bagliHesapId'],
      bakiye: map['bakiye'],
      hesapAdi: map['hesapAdi'],
      id: map['id'],
      paraBirimi: (map['paraBirimi'] as String).toParaBirimiFromKodu,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankaHesap.fromJson(String source) =>
      BankaHesap.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BankaHesapModel(hesapNo: $hesapNo, subeAdi: $subeAdi, iban: $iban, aciklama: $aciklama, bagliHesapAdi: $bagliBankaAdi, bagliHesapId: $bagliBankaId, bakiye: $bakiye, hesapAdi: $hesapAdi, id: $id, paraBirimi: $paraBirimi)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BankaHesap &&
        other.hesapNo == hesapNo &&
        other.subeAdi == subeAdi &&
        other.iban == iban &&
        other.aciklama == aciklama &&
        other.bagliBankaAdi == bagliBankaAdi &&
        other.bagliBankaId == bagliBankaId &&
        other.bakiye == bakiye &&
        other.hesapAdi == hesapAdi &&
        other.id == id &&
        other.paraBirimi == paraBirimi;
  }

  @override
  int get hashCode {
    return hesapNo.hashCode ^
        subeAdi.hashCode ^
        iban.hashCode ^
        aciklama.hashCode ^
        bagliBankaAdi.hashCode ^
        bagliBankaId.hashCode ^
        bakiye.hashCode ^
        hesapAdi.hashCode ^
        id.hashCode ^
        paraBirimi.hashCode;
  }
}
