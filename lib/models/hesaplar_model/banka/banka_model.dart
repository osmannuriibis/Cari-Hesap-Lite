import 'dart:convert';

import '../../base_model/base_model.dart';


class BankaModel extends BaseModel {
  String? id;
  String? adi;
  String? adres;
  String? aciklama;
  BankaModel({
    this.id,
    this.adi,
    this.adres,
    this.aciklama,
  });

  BankaModel copyWith({
    String? id,
required    String? adi,
    String? adres,
    String? aciklama,
  }) {
    return BankaModel(
      id: id ?? this.id,
      adi: adi ?? this.adi,
      adres: adres ?? this.adres,
      aciklama: aciklama ?? this.aciklama,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adi': adi,
      'adres': adres,
      'aciklama': aciklama,
    };
  }

  factory BankaModel.fromMap(Map<String, dynamic> map) {
    return BankaModel(
      id: map['id'],
      adi: map['adi'],
      adres: map['adres'],
      aciklama: map['aciklama'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BankaModel.fromJson(String source) =>
      BankaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BankaModel(id: $id, adi: $adi, adres: $adres, aciklama: $aciklama)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BankaModel &&
      other.id == id &&
      other.adi == adi &&
      other.adres == adres &&
      other.aciklama == aciklama;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      adi.hashCode ^
      adres.hashCode ^
      aciklama.hashCode;
  }

  @override
  BankaModel fromMap(Map<String, dynamic> map) {
    return fromMap(map);
  }
}
