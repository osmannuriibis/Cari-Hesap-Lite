import 'dart:convert';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



class StokKart extends BaseModel {
  String? id;
  String? adi;
  bool? stokTipi;
  String? kategori;
  String? barkod;
  String? urunKodu;
  num? alisFiyati;
  num? satisFiyati;
  int? kdv;
  
  String? birim;
  num? emniyetStok;
  num? giren;
  num? cikan;
  String? imagePath;
  Timestamp? kayitTarihi;
  String? aciklama;

  StokKart({
    this.id,
    this.adi,
    this.stokTipi,
    this.kategori,
    this.barkod,
    this.urunKodu,
    this.alisFiyati = 0,
    this.satisFiyati = 0,
    this.kdv = 0,
    
    this.birim,
    this.emniyetStok = 0,
    this.giren = 0,
    this.cikan = 0,
    this.imagePath,
    this.kayitTarihi,
    this.aciklama = "",
  });

  StokKart copyWith({
       String? id,
       String? adi,
    bool? stokTipi,
       String? kategori,
       String? barkod,
       String? urunKodu,
       num? alisFiyati,
       num? satisFiyati,
       int? kdv,   
    String? birim,
       num? emniyetStok,
       num? giren,
       num? cikan,
       String? imagePath,
       Timestamp? kayitTarihi,
       String? aciklama,
  }) {
    return StokKart(
      id: id ?? this.id,
      adi: adi ?? this.adi,
      stokTipi: stokTipi ?? this.stokTipi,
      kategori: kategori ?? this.kategori,
      barkod: barkod ?? this.barkod,
      urunKodu: urunKodu ?? this.urunKodu,
      alisFiyati: alisFiyati ?? this.alisFiyati,
      satisFiyati: satisFiyati ?? this.satisFiyati,
      kdv: kdv ?? this.kdv,
     
      birim: birim ?? this.birim,
      emniyetStok: emniyetStok ?? this.emniyetStok,
      giren: giren ?? this.giren,
      cikan: cikan ?? this.cikan,
      imagePath: imagePath ?? this.imagePath,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      aciklama: aciklama ?? this.aciklama,
    );
  }

  Map<String, dynamic> toMap() {
    
    return {
      'id': id,
      'adi': adi,
      'stokTipi': stokTipi,
      'kategori': kategori,
      'barkod': barkod,
      'urunKodu': urunKodu,
      'alisFiyati': alisFiyati,
      'satisFiyati': satisFiyati,
      'kdv': kdv,
   
      'birim': birim,
      'emniyetStok': emniyetStok,
      'giren': giren,
      'cikan': cikan,
      'imagePath': imagePath,
      'kayitTarihi': kayitTarihi,
      'aciklama': aciklama,
    };
  }
 @override
  fromMap(Map<String?,dynamic> map) {
    // TODO: implement fromMap
    return StokKart.fromMap(map);
  }
  factory StokKart.fromMap(Map<String?, dynamic> map) {
    

    return StokKart(
      id: map['id'],
      adi: map['adi'],
      stokTipi: map['stokTipi'],
      kategori: map['kategori'],
      barkod: map['barkod'],
      urunKodu: map['urunKodu'],
      alisFiyati: map['alisFiyati'] ?? 0,
      satisFiyati: map['satisFiyati'] ?? 0,
      kdv: map['kdv'] ?? 0,
   
      birim: map['birim'],
      emniyetStok: map['emniyetStok'],
      giren: map['giren'],
      cikan: map['cikan'],
      imagePath: map['imagePath'],
      kayitTarihi: map['kayitTarihi'] ,
      aciklama: map['aciklama'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StokKart.fromJson(String source) =>
      StokKart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StokKart(id: $id, adi: $adi, stokTipi: $stokTipi, kategori: $kategori, barkod: $barkod, urunKodu: $urunKodu, alisFiyati: $alisFiyati, satisFiyati: $satisFiyati, kdv: $kdv,  birim: $birim, emniyetStok: $emniyetStok, giren: $giren, cikan: $cikan, imagePath: $imagePath, kayitTarihi: $kayitTarihi, aciklama: $aciklama)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StokKart &&
        o.id == id &&
        o.adi == adi &&
        o.stokTipi == stokTipi &&
        o.kategori == kategori &&
        o.barkod == barkod &&
        o.urunKodu == urunKodu &&
        o.alisFiyati == alisFiyati &&
        o.satisFiyati == satisFiyati &&
        o.kdv == kdv &&
     
        o.birim == birim &&
        o.emniyetStok == emniyetStok &&
        o.giren == giren &&
        o.cikan == cikan &&
        o.imagePath == imagePath &&
        o.kayitTarihi == kayitTarihi &&
        o.aciklama == aciklama;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        adi.hashCode ^
        stokTipi.hashCode ^
        kategori.hashCode ^
        barkod.hashCode ^
        urunKodu.hashCode ^
        alisFiyati.hashCode ^
        satisFiyati.hashCode ^
        kdv.hashCode ^
      
        birim.hashCode ^
        emniyetStok.hashCode ^
        giren.hashCode ^
        cikan.hashCode ^
        imagePath.hashCode ^
        kayitTarihi.hashCode ^
        aciklama.hashCode;
  }
}
