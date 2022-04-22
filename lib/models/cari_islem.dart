import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/islemler_model.dart';

import '../enums/cari_islem_turu.dart';
import '../enums/irsaliye_turu_enum.dart';

class CariIslemModel implements Islemler {
  @override
  String? id;

  @override
  String? cariId;

  @override
  String? cariUnvani;

  @override
  String? islemKodu;

  // Cari İslem altındaki işlemlerle(Stok Hareket, Kasa Hareket vs) ortak ID'si
  CariIslemTuru? islemTuru; //"satis", "alis",// "sayim", "fire" vs

  num? tutar; //->ürünlerin toplam tutarı
  num? iskontoTutar; //-> ürünlerin iskontoTutar toplamları
  num? net; //->  tutar - iskontoUrunlerTutar
  num? kdvTutar; //->ürünlerin kdv toplamları
  num? toplam; // net + kdvUrunlerTutar

  num? iskontoFaturaAltiOran;
  num? iskontoFaturaAltiTutar;
  @override
  num? toplamTutar; // toplam - iskontoFaturaAltiTutar

  @override
  Timestamp? kayitTarihi; // saatli tarih

  @override
  Timestamp? islemTarihi;
  Timestamp? sevkTarihi;
  @override
  ParaBirimi paraBirimi = ParaBirimi.TRY;

  IrsaliyeTuru? evrakTuru; //F veya M
  @override
  String? evrakNo;

  @override
  String? personelId;
  @override
  String? kullaniciId;
  String? hesapID;

  @override
  String? aciklama;

  /// Döviz/TL
  @override
  num? kurOrani;
  CariIslemModel({
    this.id,
    this.cariId,
    this.cariUnvani,
    this.islemKodu,
    this.islemTuru,
    this.tutar,
    this.iskontoTutar,
    this.net,
    this.kdvTutar,
    this.toplam,
    this.iskontoFaturaAltiOran,
    this.iskontoFaturaAltiTutar,
    this.toplamTutar,
    this.kayitTarihi,
    this.islemTarihi,
    this.sevkTarihi,
    this.evrakTuru,
    this.evrakNo,
    this.personelId,
    this.kullaniciId,
    this.hesapID,
    this.aciklama,
    this.kurOrani,
  });

  CariIslemModel copyWith({
    String? id,
    String? cariId,
    String? cariUnvani,
  required String? islemKodu,
    CariIslemTuru? islemTuru,
    num? tutar,
    num? iskontoTutar,
    num? net,
    num? kdvTutar,
    num? toplam,
    num? iskontoFaturaAltiOran,
    num? iskontoFaturaAltiTutar,
  required  num? toplamTutar,
    Timestamp? kayitTarihi,
    Timestamp? islemTarihi,
    Timestamp? sevkTarihi,
    IrsaliyeTuru? evrakTuru,
    String? evrakNo,
    String? personelId,
    String? kullaniciId,
    String? hesapID,
    String? aciklama,
    num? kurOrani,
  }) {
    return CariIslemModel(
      id: id ?? this.id,
      cariId: cariId ?? this.cariId,
      cariUnvani: cariUnvani ?? this.cariUnvani,
      islemKodu: islemKodu ?? this.islemKodu,
      islemTuru: islemTuru ?? this.islemTuru,
      tutar: tutar ?? this.tutar,
      iskontoTutar: iskontoTutar ?? this.iskontoTutar,
      net: net ?? this.net,
      kdvTutar: kdvTutar ?? this.kdvTutar,
      toplam: toplam ?? this.toplam,
      iskontoFaturaAltiOran:
          iskontoFaturaAltiOran ?? this.iskontoFaturaAltiOran,
      iskontoFaturaAltiTutar:
          iskontoFaturaAltiTutar ?? this.iskontoFaturaAltiTutar,
      toplamTutar: toplamTutar ?? this.toplamTutar,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      islemTarihi: islemTarihi ?? this.islemTarihi,
      sevkTarihi: sevkTarihi ?? this.sevkTarihi,
      evrakTuru: evrakTuru ?? this.evrakTuru,
      evrakNo: evrakNo ?? this.evrakNo,
      personelId: personelId ?? this.personelId,
      kullaniciId: kullaniciId ?? this.kullaniciId,
      hesapID: hesapID ?? this.hesapID,
      aciklama: aciklama ?? this.aciklama,
      kurOrani: kurOrani ?? this.kurOrani,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cariId': cariId,
      'cariUnvani': cariUnvani,
      'islemKodu': islemKodu,
      'islemTuru': islemTuru?.toMap(),
      'tutar': tutar,
      'iskontoTutar': iskontoTutar,
      'net': net,
      'kdvTutar': kdvTutar,
      'toplam': toplam,
      'iskontoFaturaAltiOran': iskontoFaturaAltiOran,
      'iskontoFaturaAltiTutar': iskontoFaturaAltiTutar,
      'toplamTutar': toplamTutar,
      'kayitTarihi': kayitTarihi,
      'islemTarihi': islemTarihi,
      'sevkTarihi': sevkTarihi,
      'paraBirimi': paraBirimi.toMap(),
      'evrakTuru': evrakTuru?.toMap(),
      'evrakNo': evrakNo,
      'personelId': personelId,
      'kullaniciId': kullaniciId,
      'hesapID': hesapID,
      'aciklama': aciklama,
      'kurOrani': kurOrani,
    };
  }

  factory CariIslemModel.fromMap(Map<String, dynamic> map) {
    return CariIslemModel(
      id: map['id'],
      cariId: map['cariId'],
      cariUnvani: map['cariUnvani'],
      islemKodu: map['islemKodu'],
      islemTuru: (map['islemTuru'] as String).toCariIslemTuru,
      tutar: map['tutar'],
      iskontoTutar: map['iskontoTutar'],
      net: map['net'],
      kdvTutar: map['kdvTutar'],
      toplam: map['toplam'],
      iskontoFaturaAltiOran: map['iskontoFaturaAltiOran'],
      iskontoFaturaAltiTutar: map['iskontoFaturaAltiTutar'],
      toplamTutar: map['toplamTutar'],
      kayitTarihi: map['kayitTarihi'],
      islemTarihi: map['islemTarihi'],
      sevkTarihi: map['sevkTarihi'],
      evrakTuru: (map['evrakTuru'] as String).toIrsaliyeTuru,
      evrakNo: map['evrakNo'],
      personelId: map['personelId'],
      kullaniciId: map['kullaniciId'],
      hesapID: map['hesapID'],
      aciklama: map['aciklama'],
      kurOrani: map['kurOrani'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CariIslemModel.fromJson(String source) =>
      CariIslemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CariIslemModel(id: $id, cariId: $cariId, cariUnvani: $cariUnvani, islemKodu: $islemKodu, islemTuru: $islemTuru, tutar: $tutar, iskontoTutar: $iskontoTutar, net: $net, kdvTutar: $kdvTutar, toplam: $toplam, iskontoFaturaAltiOran: $iskontoFaturaAltiOran, iskontoFaturaAltiTutar: $iskontoFaturaAltiTutar, toplamTutar: $toplamTutar, kayitTarihi: $kayitTarihi, islemTarihi: $islemTarihi, sevkTarihi: $sevkTarihi, evrakTuru: $evrakTuru, evrakNo: $evrakNo, personelId: $personelId, kullaniciId: $kullaniciId, hesapID: $hesapID, aciklama: $aciklama, kurOrani: $kurOrani)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CariIslemModel &&
        other.id == id &&
        other.cariId == cariId &&
        other.cariUnvani == cariUnvani &&
        other.islemKodu == islemKodu &&
        other.islemTuru == islemTuru &&
        other.tutar == tutar &&
        other.iskontoTutar == iskontoTutar &&
        other.net == net &&
        other.kdvTutar == kdvTutar &&
        other.toplam == toplam &&
        other.iskontoFaturaAltiOran == iskontoFaturaAltiOran &&
        other.iskontoFaturaAltiTutar == iskontoFaturaAltiTutar &&
        other.toplamTutar == toplamTutar &&
        other.kayitTarihi == kayitTarihi &&
        other.islemTarihi == islemTarihi &&
        other.sevkTarihi == sevkTarihi &&
        other.evrakTuru == evrakTuru &&
        other.evrakNo == evrakNo &&
        other.personelId == personelId &&
        other.kullaniciId == kullaniciId &&
        other.hesapID == hesapID &&
        other.aciklama == aciklama &&
        other.kurOrani == kurOrani;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cariId.hashCode ^
        cariUnvani.hashCode ^
        islemKodu.hashCode ^
        islemTuru.hashCode ^
        tutar.hashCode ^
        iskontoTutar.hashCode ^
        net.hashCode ^
        kdvTutar.hashCode ^
        toplam.hashCode ^
        iskontoFaturaAltiOran.hashCode ^
        iskontoFaturaAltiTutar.hashCode ^
        toplamTutar.hashCode ^
        kayitTarihi.hashCode ^
        islemTarihi.hashCode ^
        sevkTarihi.hashCode ^
        evrakTuru.hashCode ^
        evrakNo.hashCode ^
        personelId.hashCode ^
        kullaniciId.hashCode ^
        hesapID.hashCode ^
        aciklama.hashCode ^
        kurOrani.hashCode;
  }

  @override
  CariIslemModel fromMap(Map<String, dynamic> map) {
    return fromMap(map);
  }
}
