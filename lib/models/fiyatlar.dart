import 'dart:convert';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

import '../enums/cari_islem_turu.dart';



class Fiyatlar implements BaseModel {
  /// cariId
  String? cariId; 
//  String cariId;
  String? stokId;
  
  num? alis;
  num? satis;
  Fiyatlar({
    this.cariId,
    this.stokId,
    this.alis = 0,
    this.satis = 0,
  }) ;

  Fiyatlar copyWith({
    String? cariId,
    String? stokId,
    num? alis,
    num? satis,
  }) {
    return Fiyatlar(
      cariId: cariId ?? this.cariId,
      stokId: stokId ?? this.stokId,
      alis: alis ?? this.alis,
      satis: satis ?? this.satis,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'cariId': cariId,
      'stokId': stokId,
      'alis': alis,
      'satis': satis,
    };
  }

  @override
  Fiyatlar fromMap(Map<String,dynamic> map) {
    return Fiyatlar.fromMap(map);
  }

  factory Fiyatlar.fromMap(Map<String, dynamic> map) {
    return Fiyatlar(
      cariId: map['cariId'],
      stokId: map['stokId'],
      alis: map['alis'],
      satis: map['satis'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Fiyatlar.fromJson(String source) =>
      Fiyatlar.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fiyatlar(cariId: $cariId, stokId: $stokId, alis: $alis, satis: $satis)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Fiyatlar &&
      other.cariId == cariId &&
      other.stokId == stokId &&
      other.alis == alis &&
      other.satis == satis;
  }

  @override
  int get hashCode {
    return cariId.hashCode ^
      stokId.hashCode ^
      alis.hashCode ^
      satis.hashCode;
  }

  // ignore: missing_return
  num? getIslemFiyatiByCariIslemTuru(CariIslemTuru cariIslemTuru) {
    if (cariIslemTuru == CariIslemTuru.satis) {
      return satis;
    } else if (cariIslemTuru == CariIslemTuru.alis) {
      return alis;
    }
    return null;
  }

  @override
  String? id;
}
