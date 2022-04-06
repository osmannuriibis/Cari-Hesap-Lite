import 'dart:convert';

import 'package:cari_hesapp_lite/enums/kullanici_yetki_turu.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Personel extends BaseModel {
  String? id;

  String? adi;
  String? soyadi;
  String? cinsiyet;
  String? tel;
  String? email;
  String? adres;
  String? yakini;
  String? yakiniTel;
  String? imagePath;

  String? gorevTanimi;
  num? maas;
  Timestamp? girisTarihi;

  String? kullaniciId;

  bool? isUser;
  KullaniciYetkiTuru? yetkiTuru;

  String? kaydedenId;
  Timestamp? kayitTarihi;

  Personel({
    this.id,
    this.adi,
    this.soyadi,
    this.cinsiyet,
    this.tel,
    this.email,
    this.adres,
    this.yakini,
    this.yakiniTel,
    this.imagePath,
    this.gorevTanimi,
    this.maas,
    this.girisTarihi,
    this.kullaniciId,
    this.isUser,
    this.yetkiTuru,
    this.kaydedenId,
    this.kayitTarihi,
  });

  Personel copyWith({
    String? id,
    String? adi,
    String? soyadi,
    String? cinsiyet,
    String? tel,
    String? email,
    String? adres,
    String? yakini,
    String? yakiniTel,
    String? imagePath,
    String? gorevTanimi,
    num? maas,
    Timestamp? girisTarihi,
    String? kullaniciId,
    bool? isUser,
    KullaniciYetkiTuru? yetkiTuru,
    String? kaydedenId,
    Timestamp? kayitTarihi,
  }) {
    return Personel(
      id: id ?? this.id,
      adi: adi ?? this.adi,
      soyadi: soyadi ?? this.soyadi,
      cinsiyet: cinsiyet ?? this.cinsiyet,
      tel: tel ?? this.tel,
      email: email ?? this.email,
      adres: adres ?? this.adres,
      yakini: yakini ?? this.yakini,
      yakiniTel: yakiniTel ?? this.yakiniTel,
      imagePath: imagePath ?? this.imagePath,
      gorevTanimi: gorevTanimi ?? this.gorevTanimi,
      maas: maas ?? this.maas,
      girisTarihi: girisTarihi ?? this.girisTarihi,
      kullaniciId: kullaniciId ?? this.kullaniciId,
      isUser: isUser ?? this.isUser,
      yetkiTuru: yetkiTuru ?? this.yetkiTuru,
      kaydedenId: kaydedenId ?? this.kaydedenId,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adi': adi,
      'soyadi': soyadi,
      'cinsiyet': cinsiyet,
      'tel': tel,
      'email': email,
      'adres': adres,
      'yakini': yakini,
      'yakiniTel': yakiniTel,
      'imagePath': imagePath,
      'gorevTanimi': gorevTanimi,
      'maas': maas,
      'girisTarihi': girisTarihi,
      'kullaniciId': kullaniciId,
      'isUser': isUser,
      'yetkiTuru': yetkiTuru?.stringValue,
      'kaydedenId': kaydedenId,
      'kayitTarihi': kayitTarihi,
    };
  }

  factory Personel.fromMap(Map<dynamic, dynamic> map) {
    return Personel(
      id: map['id'],
      adi: map['adi'],
      soyadi: map['soyadi'],
      cinsiyet: map['cinsiyet'],
      tel: map['tel'],
      email: map['email'],
      adres: map['adres'],
      yakini: map['yakini'],
      yakiniTel: map['yakiniTel'],
      imagePath: map['imagePath'],
      gorevTanimi: map['gorevTanimi'],
      maas: map['maas'],
      girisTarihi: map['girisTarihi'],
      kullaniciId: map['kullaniciId'],
      isUser: map['isUser'],
      yetkiTuru: KullaniciYetkiTuru.admin == (map['yetkiTuru'])
          ? KullaniciYetkiTuru.admin
          : KullaniciYetkiTuru.sefil,
      kaydedenId: map['kaydedenId'],
      kayitTarihi: map['kayitTarihi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Personel.fromJson(String source) =>
      Personel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Personel(id: $id, adi: $adi, soyadi: $soyadi, cinsiyet: $cinsiyet, tel: $tel, email: $email, adres: $adres, yakini: $yakini, yakiniTel: $yakiniTel, imagePath: $imagePath, gorevTanimi: $gorevTanimi, maas: $maas, girisTarihi: $girisTarihi, kullaniciId: $kullaniciId, isUser: $isUser, yetkiTuru: $yetkiTuru, kaydedenId: $kaydedenId, kayitTarihi: $kayitTarihi)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Personel &&
        o.id == id &&
        o.adi == adi &&
        o.soyadi == soyadi &&
        o.cinsiyet == cinsiyet &&
        o.tel == tel &&
        o.email == email &&
        o.adres == adres &&
        o.yakini == yakini &&
        o.yakiniTel == yakiniTel &&
        o.imagePath == imagePath &&
        o.gorevTanimi == gorevTanimi &&
        o.maas == maas &&
        o.girisTarihi == girisTarihi &&
        o.kullaniciId == kullaniciId &&
        o.isUser == isUser &&
        o.yetkiTuru == yetkiTuru &&
        o.kaydedenId == kaydedenId &&
        o.kayitTarihi == kayitTarihi;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        adi.hashCode ^
        soyadi.hashCode ^
        cinsiyet.hashCode ^
        tel.hashCode ^
        email.hashCode ^
        adres.hashCode ^
        yakini.hashCode ^
        yakiniTel.hashCode ^
        imagePath.hashCode ^
        gorevTanimi.hashCode ^
        maas.hashCode ^
        girisTarihi.hashCode ^
        kullaniciId.hashCode ^
        isUser.hashCode ^
        yetkiTuru.hashCode ^
        kaydedenId.hashCode ^
        kayitTarihi.hashCode;
  }

  @override
  Personel fromMap(Map map) {
    return Personel.fromMap(map);
  }
}
