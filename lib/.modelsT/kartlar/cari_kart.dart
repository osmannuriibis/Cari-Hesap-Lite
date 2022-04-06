import 'dart:convert';

import 'package:cari_hesapp_lite/enums/cari_turu.dart';
import 'package:cari_hesapp_lite/models/base_model/bakiyeli_model.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

import 'package:cari_hesapp_lite/models/konum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

class CariKart extends BakiyeliBaseModel {
  String? id;
  String? unvani;
  String? imagePath;

  Timestamp? kayitTarihi;

  CariTuru? cariTuru;

  List<String?>? telNo;
  String? email;
  Konum? konum;

  String? adres;
  String? sehir;
  String? ilce;
  num? bakiye;


  String? vergiDairesi;
  String? vergiNo;
  String? ekBilgi;
  String? cariGrup;
  String? siniflandirma;
  num? riskLimiti;
  String? uyariMesaji;
  String? aciklama;

  CariKart(
      {this.cariTuru,
      this.id,
      this.unvani = "",
      this.imagePath,
      this.kayitTarihi,
      this.telNo,
      this.email,
      this.konum,
      this.adres,
      this.sehir,
      this.ilce,
      this.bakiye = 0,
      this.vergiDairesi,
      this.vergiNo,
      this.ekBilgi,
      this.cariGrup,
      this.siniflandirma,
      this.riskLimiti,
      this.uyariMesaji,
      this.aciklama,});

  /* CariKart copyWith({
    String cariId,
    String unvani,
    String kayitTarihi,
    CariTuru cariTuru,
    List<String> telNo,
    String email,
    String konum,
    String adres,
    String sehir,
    String ilce,
    double bakiye,
    String vergiDairesi,
    String vergiNo,
    String ekBilgi,
    String cariGrup,
    String siniflandirma,
    double riskLimiti,
    String uyariMesaji,
    String aciklama,
  }) {
    return CariKart(
      cariId: cariId ?? this.cariId,
      unvani: unvani ?? this.unvani,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      //todo cariTuru: ,
      telNo: telNo ?? this.telNo,
      email: email ?? this.email,
      konum: konum ?? this.konum,
      adres: adres ?? this.adres,
      sehir: sehir ?? this.sehir,
      ilce: ilce ?? this.ilce,
      bakiye: bakiye ?? this.bakiye,
      vergiDairesi: vergiDairesi ?? this.vergiDairesi,
      vergiNo: vergiNo ?? this.vergiNo,
      ekBilgi: ekBilgi ?? this.ekBilgi,
      cariGrup: cariGrup ?? this.cariGrup,
      siniflandirma: siniflandirma ?? this.siniflandirma,
      riskLimiti: riskLimiti ?? this.riskLimiti,
      uyariMesaji: uyariMesaji ?? this.uyariMesaji,
      aciklama: aciklama ?? this.aciklama,
    );
  } */

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unvani': unvani,
      'imagePath': imagePath,
      'kayitTarihi': kayitTarihi ,
      'cariTuru': cariTuru?.toMap(),
      'telNo': telNo,
      'email': email,
      'konum': konum?.toMap(),
      'adres': adres,
      'sehir': sehir,
      'ilce': ilce,
      'bakiye': bakiye,
      'vergiDairesi': vergiDairesi,
      'vergiNo': vergiNo,
      'ekBilgi': ekBilgi,
      'cariGrup': cariGrup,
      'siniflandirma': siniflandirma,
      'riskLimiti': riskLimiti,
      'uyariMesaji': uyariMesaji,
      'aciklama': aciklama,
    };
  }

  @override
  CariKart fromMap(Map<String, dynamic> map) {
    return CariKart.fromMap(map);
  } 

  
   factory  CariKart.fromMap(Map<String, dynamic> map) {
  

    return CariKart(
      id: map['id'],
      unvani: map['unvani'],
      imagePath: map['imagePath'],
      kayitTarihi: map['kayitTarihi'] ,
      cariTuru: (map['cariTuru'] as String).toCariTuru,
      telNo: List<String>.from(map['telNo']),
      email: map['email'],
      konum: Konum.fromMap(map['konum']),
      adres: map['adres'],
      sehir: map['sehir'],
      ilce: map['ilce'],
      bakiye: map['bakiye'],
      vergiDairesi: map['vergiDairesi'],
      vergiNo: map['vergiNo'],
      ekBilgi: map['ekBilgi'],
      cariGrup: map['cariGrup'],
      siniflandirma: map['siniflandirma'],
      riskLimiti: map['riskLimiti'],
      uyariMesaji: map['uyariMesaji'],
      aciklama: map['aciklama'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CariKart.fromJson(String source) =>
      CariKart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CariKart(id: $id, unvani: $unvani, imagePath: $imagePath, kayitTarihi: $kayitTarihi, cariTuru: $cariTuru, telNo: $telNo, email: $email, konum: $konum, adres: $adres, sehir: $sehir, ilce: $ilce, bakiye: $bakiye, vergiDairesi: $vergiDairesi, vergiNo: $vergiNo, ekBilgi: $ekBilgi, cariGrup: $cariGrup, siniflandirma: $siniflandirma, riskLimiti: $riskLimiti, uyariMesaji: $uyariMesaji, aciklama: $aciklama)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CariKart &&
        o.id == id &&
        o.unvani == unvani &&
        o.imagePath == imagePath &&
        o.kayitTarihi == kayitTarihi &&
        o.cariTuru == cariTuru &&
        listEquals(o.telNo, telNo) &&
        o.email == email &&
        o.konum == konum &&
        o.adres == adres &&
        o.sehir == sehir &&
        o.ilce == ilce &&
        o.bakiye == bakiye &&
        o.vergiDairesi == vergiDairesi &&
        o.vergiNo == vergiNo &&
        o.ekBilgi == ekBilgi &&
        o.cariGrup == cariGrup &&
        o.siniflandirma == siniflandirma &&
        o.riskLimiti == riskLimiti &&
        o.uyariMesaji == uyariMesaji &&
        o.aciklama == aciklama;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unvani.hashCode ^
        imagePath.hashCode ^
        kayitTarihi.hashCode ^
        cariTuru.hashCode ^
        telNo.hashCode ^
        email.hashCode ^
        konum.hashCode ^
        adres.hashCode ^
        sehir.hashCode ^
        ilce.hashCode ^
        bakiye.hashCode ^
        vergiDairesi.hashCode ^
        vergiNo.hashCode ^
        ekBilgi.hashCode ^
        cariGrup.hashCode ^
        siniflandirma.hashCode ^
        riskLimiti.hashCode ^
        uyariMesaji.hashCode ^
        aciklama.hashCode;
  }

  /*  CariKart.fromSnapshot(DataSnapshot snapshot) {
    /*  cariId: map['cariId'],
      unvani: map['unvani'],
      kayitTarihi: map['kayitTarihi'],
      cariTuru: map['cariTuru'],
      telNo: List<String>.from(map['telNo']),
      email: map['email'],
      konum: map['konum'],
      adres: map['adres'],
      sehir: map['sehir'],
      ilce: map['ilce'],
      bakiye: map['bakiye'],
      vergiDairesi: map['vergiDairesi'],
      vergiNo: map['vergiNo'],
      ekBilgi: map['ekBilgi'],
      cariGrup: map['cariGrup'],
      siniflandirma: map['siniflandirma'],
      riskLimiti: map['riskLimiti'],
      uyariMesaji: map['uyariMesaji'],
      aciklama: map['aciklama'], */

    this.cariId = snapshot.key;
    this.unvani = snapshot.value['unvani'];
    this.kayitTarihi = snapshot.value['kayitTarihi'];
    this.cariTuru = "cari"; // snapshot.value['cariTuru'];
    this.telNo = snapshot.value['telNo'];
    this.email = snapshot.value['email'];
    this.konum = snapshot.value['konum'];
    this.adres = snapshot.value['adres'];
    this.sehir = snapshot.value['sehir'];
    this.ilce = snapshot.value['ilce'];

    this.bakiye = snapshot.value['bakiye'];
    this.vergiDairesi = snapshot.value['vergiDairesi'];
    this.vergiNo = snapshot.value['vergiNo'];
    this.ekBilgi = snapshot.value['ekBilgi'];
    this.cariGrup = snapshot.value['cariGrup'];
    this.siniflandirma = snapshot.value['siniflandirma'];

    this.riskLimiti = snapshot.value['riskLimiti'];
    this.uyariMesaji = snapshot.value['uyariMesaji'];
    this.aciklama = snapshot.value['aciklama'];
  } */

  CariKart copyWith(
      {String? id,
      String? unvani,
      String? imagePath,
      Timestamp? kayitTarihi,
      CariTuru? cariTuru,
      List<String>? telNo,
      String? email,
      Konum? konum,
      String? adres,
      String? sehir,
      String? ilce,
      num? bakiye,
      String? vergiDairesi,
      String? vergiNo,
      String? ekBilgi,
      String? cariGrup,
      String? siniflandirma,
      num? riskLimiti,
      String? uyariMesaji,
      String? aciklama,}) {
    return CariKart(
        id: id ?? this.id,
        unvani: unvani ?? this.unvani,
        imagePath: imagePath ?? this.imagePath,
        kayitTarihi: kayitTarihi ?? this.kayitTarihi,
        cariTuru: cariTuru ?? this.cariTuru,
        telNo: telNo ?? this.telNo,
        email: email ?? this.email,
        konum: konum ?? this.konum,
        adres: adres ?? this.adres,
        sehir: sehir ?? this.sehir,
        ilce: ilce ?? this.ilce,
        bakiye: bakiye ?? this.bakiye,
        vergiDairesi: vergiDairesi ?? this.vergiDairesi,
        vergiNo: vergiNo ?? this.vergiNo,
        ekBilgi: ekBilgi ?? this.ekBilgi,
        cariGrup: cariGrup ?? this.cariGrup,
        siniflandirma: siniflandirma ?? this.siniflandirma,
        riskLimiti: riskLimiti ?? this.riskLimiti,
        uyariMesaji: uyariMesaji ?? this.uyariMesaji,
        aciklama: aciklama ?? this.aciklama,
        );
  }
}
