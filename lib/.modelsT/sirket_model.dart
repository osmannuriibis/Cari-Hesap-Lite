import 'dart:convert';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

class SirketModel extends BaseModel {
  @override
  String? id;

  String? unvani;
  String? ticariAdi;
  String? tel;
  String? email;
  String? adres;
  String? ilce;
  String? sehir;
  String? ulke;
  String? imagePath;

  String? vDairesi;
  String? vNo;
  SirketModel({
    this.id,
    this.unvani,
    this.ticariAdi,
    this.tel,
    this.email,
    this.adres,
    this.ilce,
    this.sehir,
    this.ulke,
    this.imagePath,
    this.vDairesi,
    this.vNo,
  });

  SirketModel copyWith({
    String? id,
    String? unvani,
    String? ticariAdi,
    String? tel,
    String? email,
    String? adres,
    String? ilce,
    String? sehir,
    String? imagePath,
    String? vDairesi,
    String? vNo,
  }) {
    return SirketModel(
      id: id ?? this.id,
      unvani: unvani ?? this.unvani,
      ticariAdi: ticariAdi ?? this.ticariAdi,
      tel: tel ?? this.tel,
      email: email ?? this.email,
      adres: adres ?? this.adres,
      ilce: ilce ?? this.ilce,
      sehir: sehir ?? this.sehir,
      ulke: ulke ?? this.ulke,
      imagePath: imagePath ?? this.imagePath,
      vDairesi: vDairesi ?? this.vDairesi,
      vNo: vNo ?? this.vNo,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unvani': unvani,
      'ticariAdi': ticariAdi,
      'tel': tel,
      'email': email,
      'adres': adres,
      'ilce': ilce,
      'sehir': sehir,
      'ulke': ulke,
      'imagePath': imagePath,
      'vDairesi': vDairesi,
      'vNo': vNo,
    };
  }

  @override
  SirketModel fromMap(Map<String, dynamic> map) {
    return SirketModel.fromMap(map);
  }

  factory SirketModel.fromMap(Map<String, dynamic> map) {
    return SirketModel(
      id: map['id'],
      unvani: map['unvani'],
      ticariAdi: map['ticariAdi'],
      tel: map['tel'],
      email: map['email'],
      adres: map['adres'],
      ilce: map['ilce'],
      sehir: map['sehir'],
      ulke: map['ulke'],
      imagePath: map['imagePath'],
      vDairesi: map['vDairesi'],
      vNo: map['vNo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SirketModel.fromJson(String source) =>
      SirketModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SirketModel(id: $id, unvani: $unvani, ticariAdi: $ticariAdi, tel: $tel, email: $email, adres: $adres, ilce: $ilce, sehir: $sehir, ulke: $ulke, imagePath: $imagePath, vDairesi: $vDairesi, vNo: $vNo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SirketModel &&
        other.id == id &&
        other.unvani == unvani &&
        other.ticariAdi == ticariAdi &&
        other.tel == tel &&
        other.email == email &&
        other.adres == adres &&
        other.ilce == ilce &&
        other.sehir == sehir &&
        other.ulke == ulke &&
        other.imagePath == imagePath &&
        other.vDairesi == vDairesi &&
        other.vNo == vNo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        unvani.hashCode ^
        ticariAdi.hashCode ^
        tel.hashCode ^
        email.hashCode ^
        adres.hashCode ^
        ilce.hashCode ^
        sehir.hashCode ^
        ulke.hashCode ^
        imagePath.hashCode ^
        vDairesi.hashCode ^
        vNo.hashCode;
  }
}
