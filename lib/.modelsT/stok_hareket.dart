import 'dart:convert';
import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/* 
 this.id = 
        this.cariIslemKodu = cariIslemKodu;
        this.islemTuru = islemTuru;
        this.cariId = cariId;
        this.cadiAdi = cadiAdi;
        this.urunId = urunId;
        this.urunAdı = urunAdı;
        this.miktar = miktar;
        this.islemFiyati = islemFiyati;
        this.tutar = tutar;
        this.iskontoOranı = iskontoOranı;
        this.iskontoTutar = iskontoTutar;
        this.netTutar = netTutar;
        this.kdvOran = kdvOran;
        this.kdvTutar = kdvTutar;
        this.toplam = toplam;
        this.islemTarihi = islemTarihi;
        this.aciklama = aciklama;
    
 */

class StokHareket extends BaseModel {
  @override
  // ignore: overridden_fields
  String? id;

  String? cariIslemKodu;
  CariIslemTuru? cariIslemTuru;
  bool? isSiparis;

  String? cariId;
  String? cariAdi;

  String? urunId;
  String? urunAdi;

  String? depoId;

  num? miktar;
  num? islemFiyati;

  num? tutar; //ürünün değer tutarı ->  miktar X islemFiyati

  num?
      iskontoOrani; // ToDo: 10.12.2020 List yapmak gerekebilir ->isk1, isk2 vs.

  num? iskontoTutar; //  -> tutar X (iskonto / 100)

  num? netTutar; // tutar - iskontoTutar

  int? kdvOran; //Örn 8

  num? kdvTutar; //ürünün sadece kdv tutarı -> netTutar  X (kdvOran /100)

  Timestamp? islemTarihi;

  num? toplamTutar;

  StokHareket({
    this.id,
    this.cariIslemKodu,
    this.cariIslemTuru,
    this.isSiparis,
    this.cariId,
    this.cariAdi,
    this.urunId,
    this.depoId,
    this.urunAdi,
    this.miktar,
    this.islemFiyati,
    this.tutar,
    this.iskontoOrani,
    this.iskontoTutar,
    this.netTutar,
    this.kdvOran,
    this.kdvTutar,
    this.islemTarihi,
    this.toplamTutar,
  });

  StokHareket copyWith({
    String? id,
    String? cariIslemKodu,
    CariIslemTuru? cariIslemTuru,
    bool? isSiparis,
    String? cariId,
    String? cariAdi,
    String? urunId,
    String? urunAdi,
    String? depoId,
    num? miktar,
    num? islemFiyati,
    num? tutar,
    num? iskontoOrani,
    num? iskontoTutar,
    num? netTutar,
    int? kdvOran,
    num? kdvTutar,
    required Timestamp? islemTarihi,
    num? toplamTutar,
  }) {
    return StokHareket(
      id: id ?? this.id,
      cariIslemKodu: cariIslemKodu ?? this.cariIslemKodu,
      cariIslemTuru: cariIslemTuru ?? this.cariIslemTuru,
      isSiparis: isSiparis ?? this.isSiparis,
      cariId: cariId ?? this.cariId,
      cariAdi: cariAdi ?? this.cariAdi,
      urunId: urunId ?? this.urunId,
      urunAdi: urunAdi ?? this.urunAdi,
      depoId: depoId ?? this.depoId,
      miktar: miktar ?? this.miktar,
      islemFiyati: islemFiyati ?? this.islemFiyati,
      tutar: tutar ?? this.tutar,
      iskontoOrani: iskontoOrani ?? this.iskontoOrani,
      iskontoTutar: iskontoTutar ?? this.iskontoTutar,
      islemTarihi: islemTarihi ?? this.islemTarihi,
      netTutar: netTutar ?? this.netTutar,
      kdvOran: kdvOran ?? this.kdvOran,
      kdvTutar: kdvTutar ?? this.kdvTutar,
      toplamTutar: toplamTutar ?? this.toplamTutar,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cariIslemKodu': cariIslemKodu,
      'cariIslemTuru': cariIslemTuru?.stringValue,
      'isSiparis': isSiparis,
      'cariId': cariId,
      'cariAdi': cariAdi,
      'urunId': urunId,
      'urunAdi': urunAdi,
      'depoId': depoId,
      'miktar': miktar,
      'islemFiyati': islemFiyati,
      'tutar': tutar,
      'iskontoOrani': iskontoOrani,
      'iskontoTutar': iskontoTutar,
      'netTutar': netTutar,
      'kdvOran': kdvOran,
      'kdvTutar': kdvTutar,
      'islemTarihi': islemTarihi,
      'toplamTutar': toplamTutar,
    };
  }

  @override
  StokHareket fromMap(Map<String, dynamic> map) {
    return StokHareket.fromMap(map);
  }

  factory StokHareket.fromMap(Map<String, dynamic> map) {
    return StokHareket(
      id: map['id'],
      cariIslemKodu: map['cariIslemKodu'],
      cariIslemTuru: (map['cariIslemTuru'] as String).toCariIslemTuru,
      isSiparis: map['isSiparis'],
      cariId: map['cariId'],
      cariAdi: map['cariAdi'],
      urunId: map['urunId'],
      urunAdi: map['urunAdi'],
      depoId: map['depoId'],
      miktar: map['miktar'],
      islemFiyati: map['islemFiyati'],
      tutar: map['tutar'],
      iskontoOrani: map['iskontoOrani'],
      iskontoTutar: map['iskontoTutar'],
      netTutar: map['netTutar'],
      kdvOran: map['kdvOran'],
      kdvTutar: map['kdvTutar'],
      islemTarihi: map['islemTarihi'],
      toplamTutar: map['toplamTutar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StokHareket.fromJson(String source) =>
      StokHareket.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StokHareket(id: $id, cariIslemKodu: $cariIslemKodu, cariIslemTuru: $cariIslemTuru, isSiparis: $isSiparis, cariId: $cariId, cariAdi: $cariAdi, urunId: $urunId, urunAdi: $urunAdi, depoId : $depoId, miktar: $miktar, islemFiyati: $islemFiyati, tutar: $tutar, iskontoOrani: $iskontoOrani, iskontoTutar: $iskontoTutar, netTutar: $netTutar, kdvOran: $kdvOran, kdvTutar: $kdvTutar, toplamTutar: $toplamTutar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StokHareket &&
        other.id == id &&
        other.cariIslemKodu == cariIslemKodu &&
        other.cariIslemTuru == cariIslemTuru &&
        other.isSiparis == isSiparis &&
        other.cariId == cariId &&
        other.cariAdi == cariAdi &&
        other.urunId == urunId &&
        other.urunAdi == urunAdi &&
        other.depoId == depoId &&
        other.miktar == miktar &&
        other.islemFiyati == islemFiyati &&
        other.tutar == tutar &&
        other.iskontoOrani == iskontoOrani &&
        other.iskontoTutar == iskontoTutar &&
        other.netTutar == netTutar &&
        other.kdvOran == kdvOran &&
        other.kdvTutar == kdvTutar &&
        other.toplamTutar == toplamTutar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cariIslemKodu.hashCode ^
        cariIslemTuru.hashCode ^
        isSiparis.hashCode ^
        cariId.hashCode ^
        cariAdi.hashCode ^
        urunId.hashCode ^
        urunAdi.hashCode ^
        depoId.hashCode ^
        miktar.hashCode ^
        islemFiyati.hashCode ^
        tutar.hashCode ^
        iskontoOrani.hashCode ^
        iskontoTutar.hashCode ^
        netTutar.hashCode ^
        kdvOran.hashCode ^
        kdvTutar.hashCode ^
        toplamTutar.hashCode;
  }
}// iskonto düşülmüş kdvliTutar -> netTutar + kdvTutar = son fiyat


