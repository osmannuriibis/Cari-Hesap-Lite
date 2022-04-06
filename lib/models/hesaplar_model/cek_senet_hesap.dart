import 'dart:convert';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../enums/cek_senet/cek_senet_durumu.dart';
import '../../enums/cek_senet/cek_senet_turu.dart';

class CekSenet extends BaseModel {
  String? id;

  CekSenetTuru? belgeTuru;
  CekSenetDurumu? durumu;

  String? kesideciAdi;
  String? hamilAdi;
  Timestamp? kesideTarihi;
  String? belgeNo;

  String? borclu;
  String? alacakli;

  String? bankaAdi;
  String? subeAdi;
  String? iban;

  Timestamp? vadeTarihi;
  num? tutar;
  String? paraBirimi;

  String? kefil;
  String? kefilNo;

  String? aciklama;
  CekSenet({
    String? id,
    this.kesideciAdi,
    this.hamilAdi,
    this.kesideTarihi,
    this.belgeNo,
    this.borclu,
    this.alacakli,
    this.bankaAdi,
    this.subeAdi,
    this.iban,
    this.vadeTarihi,
    this.tutar,
    this.paraBirimi,
    this.kefil,
    this.kefilNo,
    this.aciklama,
  });

  CekSenet copyWith({
    String? id,
    String? kesideciAdi,
    String? hamilAdi,
    Timestamp? kesideTarihi,
    String? belgeNo,
    String? borclu,
    String? alacakli,
    String? bankaAdi,
    String? subeAdi,
    String? iban,
    Timestamp? vadeTarihi,
    num? tutar,
    String? paraBirimi,
    String? kefil,
    String? kefilNo,
    String? aciklama,
  }) {
    return CekSenet(
      id: id ?? this.id,
      kesideciAdi: kesideciAdi ?? this.kesideciAdi,
      hamilAdi: hamilAdi ?? this.hamilAdi,
      kesideTarihi: kesideTarihi ?? this.kesideTarihi,
      belgeNo: belgeNo ?? this.belgeNo,
      borclu: borclu ?? this.borclu,
      alacakli: alacakli ?? this.alacakli,
      bankaAdi: bankaAdi ?? this.bankaAdi,
      subeAdi: subeAdi ?? this.subeAdi,
      iban: iban ?? this.iban,
      vadeTarihi: vadeTarihi ?? this.vadeTarihi,
      tutar: tutar ?? this.tutar,
      paraBirimi: paraBirimi ?? this.paraBirimi,
      kefil: kefil ?? this.kefil,
      kefilNo: kefilNo ?? this.kefilNo,
      aciklama: aciklama ?? this.aciklama,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kesideciAdi': kesideciAdi,
      'hamilAdi': hamilAdi,
      'kesideTarihi': kesideTarihi ,
      'belgeNo': belgeNo,
      'borclu': borclu,
      'alacakli': alacakli,
      'bankaAdi': bankaAdi,
      'subeAdi': subeAdi,
      'iban': iban,
      'vadeTarihi': vadeTarihi ,
      'tutar': tutar,
      'paraBirimi': paraBirimi,
      'kefil': kefil,
      'kefilNo': kefilNo,
      'aciklama': aciklama,
    };
  }

  factory CekSenet.fromMap(Map<String, dynamic> map) {
    

    return CekSenet(
      id: map['id'],
      kesideciAdi: map['kesideciAdi'],
      hamilAdi: map['hamilAdi'],
      kesideTarihi: map['kesideTarihi'],
      belgeNo: map['belgeNo'],
      borclu: map['borclu'],
      alacakli: map['alacakli'],
      bankaAdi: map['bankaAdi'],
      subeAdi: map['subeAdi'],
      iban: map['iban'],
      vadeTarihi: map['vadeTarihi'],
      tutar: map['tutar'],
      paraBirimi: map['paraBirimi'],
      kefil: map['kefil'],
      kefilNo: map['kefilNo'],
      aciklama: map['aciklama'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CekSenet.fromJson(String source) =>
      CekSenet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CekSenet(id: $id, kesideciAdi: $kesideciAdi, hamilAdi: $hamilAdi, kesideTarihi: $kesideTarihi, belgeNo: $belgeNo, borclu: $borclu, alacakli: $alacakli, bankaAdi: $bankaAdi, subeAdi: $subeAdi, iban: $iban, vadeTarihi: $vadeTarihi, tutar: $tutar, paraBirimi: $paraBirimi, kefil: $kefil, kefilNo: $kefilNo, aciklama: $aciklama)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CekSenet &&
        o.id == id &&
        o.kesideciAdi == kesideciAdi &&
        o.hamilAdi == hamilAdi &&
        o.kesideTarihi == kesideTarihi &&
        o.belgeNo == belgeNo &&
        o.borclu == borclu &&
        o.alacakli == alacakli &&
        o.bankaAdi == bankaAdi &&
        o.subeAdi == subeAdi &&
        o.iban == iban &&
        o.vadeTarihi == vadeTarihi &&
        o.tutar == tutar &&
        o.paraBirimi == paraBirimi &&
        o.kefil == kefil &&
        o.kefilNo == kefilNo &&
        o.aciklama == aciklama;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        kesideciAdi.hashCode ^
        hamilAdi.hashCode ^
        kesideTarihi.hashCode ^
        belgeNo.hashCode ^
        borclu.hashCode ^
        alacakli.hashCode ^
        bankaAdi.hashCode ^
        subeAdi.hashCode ^
        iban.hashCode ^
        vadeTarihi.hashCode ^
        tutar.hashCode ^
        paraBirimi.hashCode ^
        kefil.hashCode ^
        kefilNo.hashCode ^
        aciklama.hashCode;
  }

  @override
  BaseModel fromMap(Map<String,dynamic> map) {
    return CekSenet.fromMap(map);
  }
}
