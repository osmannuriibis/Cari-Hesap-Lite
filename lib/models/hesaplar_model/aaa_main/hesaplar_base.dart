import 'dart:convert';

import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

abstract class HesaplarBaseModel extends BaseModel {
  String? id;
  String? hesapAdi;
  num? bakiye;
  late ParaBirimi paraBirimi;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hesapAdi': hesapAdi,
      'bakiye': bakiye,
      'paraBirimi': paraBirimi,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'HesaplarBaseModel(id: $id, hesapAdi: $hesapAdi, bakiye: $bakiye, paraBirimi: $paraBirimi)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HesaplarBaseModel &&
        other.id == id &&
        other.hesapAdi == hesapAdi &&
        other.bakiye == bakiye &&
        other.paraBirimi == paraBirimi;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        hesapAdi.hashCode ^
        bakiye.hashCode ^
        paraBirimi.hashCode;
  }


}
