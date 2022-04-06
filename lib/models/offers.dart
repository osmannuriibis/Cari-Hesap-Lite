import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/kullanici_yetki_turu.dart';
import '../enums/user_request_status.dart';
import '../utils/date_format.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

class Offers extends BaseModel {
  String? id;
  String? sirketId;
  String? kimdenEmail;
  String? kimeEmail;
  KullaniciYetkiTuru? yetki;

  Timestamp? gondermeTarihi;
  UserRequestStatus? onayDurumu;

  Offers({
    this.id,
    this.sirketId,
    this.kimdenEmail,
    this.kimeEmail,
    this.yetki,
    this.gondermeTarihi,
    this.onayDurumu,
  });

  Offers copyWith({
    String? id,
    String? kimdenId,
    String? kimdenEmail,
    String? kimeEmail,
    KullaniciYetkiTuru? yetki,
    Timestamp? gondermeTarihi,
    UserRequestStatus? onayDurumu,
  }) {
    return Offers(
      id: id ?? this.id,
      sirketId: kimdenId ?? this.sirketId,
      kimdenEmail: kimdenEmail ?? this.kimdenEmail,
      kimeEmail: kimeEmail ?? this.kimeEmail,
      yetki: yetki ?? this.yetki,
      gondermeTarihi: gondermeTarihi ?? this.gondermeTarihi,
      onayDurumu: onayDurumu ?? this.onayDurumu,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sirketId': sirketId,
      'kimdenEmail': kimdenEmail,
      'kimeEmail': kimeEmail,
      'yetki': yetki?.stringValue,
      'gondermeTarihi': gondermeTarihi,
      'onayDurumu': onayDurumu?.statusValueInt,
    };
  }

  @override
  Offers fromMap(Map<String, dynamic> map) {
    return Offers.fromMap(map);
  }

  factory Offers.fromMap(Map<String, dynamic> map) {
    return Offers(
      id: map['id'],
      sirketId: map['sirketId'],
      kimdenEmail: map['kimdenEmail'],
      kimeEmail: map['kimeEmail'],
      yetki: ((map['yetki'] as String) == KullaniciYetkiTuru.admin.stringValue)
          ? KullaniciYetkiTuru.admin
          : KullaniciYetkiTuru.sefil,
      gondermeTarihi: map['gondermeTarihi'],
      onayDurumu: getUserRequestStatusByValue(map['onayDurumu']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Offers.fromJson(String source) => Offers.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Offers(id: $id, sirketId: $sirketId, kimdenEmail: $kimdenEmail, kimeEmail: $kimeEmail, yetki: $yetki, gondermeTarihi: $gondermeTarihi, onayDurumu: $onayDurumu)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Offers &&
        o.id == id &&
        o.sirketId == sirketId &&
        o.kimdenEmail == kimdenEmail &&
        o.kimeEmail == kimeEmail &&
        o.yetki == yetki &&
        o.gondermeTarihi == gondermeTarihi &&
        o.onayDurumu == onayDurumu;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sirketId.hashCode ^
        kimdenEmail.hashCode ^
        kimeEmail.hashCode ^
        yetki.hashCode ^
        gondermeTarihi.hashCode ^
        onayDurumu.hashCode;
  }
}
