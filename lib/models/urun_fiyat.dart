import 'dart:convert';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:flutter/material.dart';

class UrunFiyat extends BaseModel {
  String? id;
  num? aylikFiyat;
  num? ucAylikFiyat;
  num? altiAylikFiyat;
  num? yillikFiyat;
  UrunFiyat({
     this.id,
     this.aylikFiyat,
     this.ucAylikFiyat,
     this.altiAylikFiyat,
     this.yillikFiyat,
  });

  UrunFiyat copyWith({
    String? id,
    num? aylikFiyat,
    num? ucAylikFiyat,
    num? altiAylikFiyat,
    num? yillikFiyat,
  }) {
    return UrunFiyat(
      id: id ?? this.id,
      aylikFiyat: aylikFiyat ?? this.aylikFiyat,
      ucAylikFiyat: ucAylikFiyat ?? this.ucAylikFiyat,
      altiAylikFiyat: altiAylikFiyat ?? this.altiAylikFiyat,
      yillikFiyat: yillikFiyat ?? this.yillikFiyat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aylikFiyat': aylikFiyat,
      'ucAylikFiyat': ucAylikFiyat,
      'altiAylikFiyat': altiAylikFiyat,
      'yillikFiyat': yillikFiyat,
    };
  }

  factory UrunFiyat.fromMap(Map<String, dynamic> map) {
    return UrunFiyat(
      id: map['id'],
      aylikFiyat: map['aylikFiyat'],
      ucAylikFiyat: map['ucAylikFiyat'],
      altiAylikFiyat: map['altiAylikFiyat'],
      yillikFiyat: map['yillikFiyat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UrunFiyat.fromJson(String source) => UrunFiyat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UrunFiyat(id: $id, aylikFiyat: $aylikFiyat, ucAylikFiyat: $ucAylikFiyat, altiAylikFiyat: $altiAylikFiyat, yillikFiyat: $yillikFiyat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UrunFiyat &&
      other.id == id &&
      other.aylikFiyat == aylikFiyat &&
      other.ucAylikFiyat == ucAylikFiyat &&
      other.altiAylikFiyat == altiAylikFiyat &&
      other.yillikFiyat == yillikFiyat;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      aylikFiyat.hashCode ^
      ucAylikFiyat.hashCode ^
      altiAylikFiyat.hashCode ^
      yillikFiyat.hashCode;
  }

  @override
  UrunFiyat fromMap(Map<String,dynamic> map) {
  
   return UrunFiyat.fromMap(map);
  }
}
