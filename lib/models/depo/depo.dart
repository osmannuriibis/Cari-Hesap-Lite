import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../base_model/base_model.dart';

class DepoModel extends BaseModel {
  
  String? id;
  String? adi;
  String? adres;
  bool? isMain;
  /// String => ürün path , num => ürün miktar
  Map<String, num>? stokMiktar;
  DepoModel({
    this.id,
    this.adi,
    this.adres,
    this.isMain,
    this.stokMiktar,
  });

 

  DepoModel copyWith({
    String? id,
    String? adi,
    String? adres,
    bool? isMain,
    Map<String, num>? stokMiktar,
  }) {
    return DepoModel(
      id: id ?? this.id,
      adi: adi ?? this.adi,
      adres: adres ?? this.adres,
      isMain: isMain ?? this.isMain,
      stokMiktar: stokMiktar ?? this.stokMiktar,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adi': adi,
      'adres': adres,
      'isMain': isMain,
      'stokMiktar': stokMiktar,
    };
  }

  factory DepoModel.fromMap(Map<String, dynamic> map) {

    return DepoModel(
      id: map['id'],
      adi: map['adi'],
      adres: map['adres'],
      isMain: map['isMain'],
      stokMiktar: map['stokMiktar'] != null ? Map<String, num>.from(map['stokMiktar']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepoModel.fromJson(String source) => DepoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Depo(id: $id, adi: $adi, adres: $adres, isMain: $isMain, stokMiktar: $stokMiktar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DepoModel &&
      other.id == id &&
      other.adi == adi &&
      other.adres == adres &&
      other.isMain == isMain &&
      mapEquals(other.stokMiktar, stokMiktar);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      adi.hashCode ^
      adres.hashCode ^
      isMain.hashCode ^
      stokMiktar.hashCode;
  }

  @override
  DepoModel fromMap(Map<String, dynamic> map) {
    
   return DepoModel.fromMap(map);
  }

  /*  Depo({
    this.id,
    this.adi,
    this.adres,
    this.isMain,
    this.stokMiktar,
  });

  Depo copyWith({
    String? id,
    String? adi,
    String? adres,
    bool? isMain,
    Map<String, String>? stokMiktar,
  }) {
    return Depo(
      id: id ?? this.id,
      adi: adi ?? this.adi,
      adres: adres ?? this.adres,
      isMain: isMain ?? this.isMain,
      stokMiktar: stokMiktar ?? this.stokMiktar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adi': adi,
      'adres': adres,
      'isMain': isMain,
      'stokMiktar': stokMiktar,
    };
  }

  factory Depo.fromMap(Map<String, dynamic> map) {
    return Depo(
      id: map['id'],
      adi: map['adi'],
      adres: map['adres'],
      isMain: map['isMain'] as bool,
      stokMiktar: Map<String, num>.from(map['stokMiktar'] as Map<String, num>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Depo.fromJson(String source) => Depo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Depo(id: $id, adi: $adi, adres: $adres, isMain: $isMain, stokMiktar: $stokMiktar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Depo &&
        other.id == id &&
        other.adi == adi &&
        other.adres == adres &&
        other.isMain == isMain &&
        mapEquals(other.stokMiktar, stokMiktar);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        adi.hashCode ^
        adres.hashCode ^
        isMain.hashCode ^
        stokMiktar.hashCode;
  }

  @override
  Depo fromMap(Map? map) {
    return Depo.fromMap(map);
  } */
}
