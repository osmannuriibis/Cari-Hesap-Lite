import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/models/hesaplar_model/aaa_main/hesaplar_base.dart';

///
/// PATH=> tablo[i]/hesaplar/kasa
///                         /banka
///                               /pos
///                               /kart

class KasaModel implements HesaplarBaseModel {
  // HesapTuru asd;
  @override
  num? bakiye;

  @override
  String? hesapAdi;

  @override
  String? id;

  @override
  ParaBirimi paraBirimi;
  String? aciklama;
  KasaModel({
    this.id,
    this.hesapAdi,
    this.bakiye,
    this.paraBirimi = ParaBirimi.TRY,
    this.aciklama,
  });

  KasaModel copyWith({
    String? id,
    String? hesapAdi,
    num? bakiye,
    ParaBirimi? paraBirimi,
    String? aciklama,
  }) {
    return KasaModel(
      id: id ?? this.id,
      hesapAdi: hesapAdi ?? this.hesapAdi,
      bakiye: bakiye ?? this.bakiye,
      paraBirimi: paraBirimi ?? this.paraBirimi,
      aciklama: aciklama ?? this.aciklama,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hesapAdi': hesapAdi,
      'bakiye': bakiye,
      'paraBirimi': paraBirimi,
      'aciklama': aciklama,
    };
  }

  factory KasaModel.fromMap(Map<String, dynamic> map) {
    return KasaModel(
      id: map['id'],
      hesapAdi: map['hesapAdi'],
      bakiye: map['bakiye'],
      paraBirimi: (map['paraBirimi'] as String).toParaBirimiFromKodu,
      aciklama: map['aciklama'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KasaModel.fromJson(String source) =>
      KasaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Kasa(id: $id, hesapAdi: $hesapAdi, bakiye: $bakiye, paraBirimi: $paraBirimi, aciklama: $aciklama)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KasaModel &&
        other.id == id &&
        other.hesapAdi == hesapAdi &&
        other.bakiye == bakiye &&
        other.paraBirimi == paraBirimi &&
        other.aciklama == aciklama;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        hesapAdi.hashCode ^
        bakiye.hashCode ^
        paraBirimi.hashCode ^
        aciklama.hashCode;
  }

  @override
  KasaModel fromMap(Map<String, dynamic> map) {
    return KasaModel.fromMap(map);
  }
}
