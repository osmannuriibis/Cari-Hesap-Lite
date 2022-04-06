import 'dart:convert';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends BaseModel {
  String? adi;
  String? soyadi;

  String? id;

  String? email;
  String? phoneNumber;

  UyelikTipi? uyelikTipi = UyelikTipi.free;

  Timestamp? kayitTarihi;

  String? photoURL;

  UserModel({
    this.adi,
    this.soyadi,
    this.id,
    this.email,
    this.phoneNumber,
    this.kayitTarihi,
    this.photoURL,
  });

  UserModel copyFromAuth(User user) {
    return UserModel(
      adi: user.displayName ?? adi,
      soyadi: soyadi,
      email: user.email ?? email,
      id: id,
      photoURL: user.photoURL ?? photoURL,
      kayitTarihi:  user.metadata.creationTime != null ? Timestamp .fromDate(user.metadata.creationTime!) : kayitTarihi,
      phoneNumber: user.phoneNumber ?? phoneNumber,
    );
  }

  UserModel copyWith({
    String? adi,
    String? soyadi,
    String? id,
    String? email,
    String? phoneNumber,
    UyelikTipi? uyelikTipi,
    Timestamp? kayitTarihi,
    String? photoURL,
  }) {
    return UserModel(
      adi: adi ?? this.adi,
      soyadi: soyadi ?? this.soyadi,
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      kayitTarihi: kayitTarihi ?? this.kayitTarihi,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'adi': adi,
      'soyadi': soyadi,
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'kayitTarihi': kayitTarihi ,
      'photoURL': photoURL,
    };
  }

  @override
  UserModel fromMap(Map<String, dynamic> map) {
    return UserModel.fromMap(map);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      adi: map['adi'],
      soyadi: map['soyadi'],
      id: map['id'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      kayitTarihi: map['kayitTarihi'],
      photoURL: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(adi: $adi, soyadi: $soyadi, id: $id, email: $email, phoneNumber: $phoneNumber, kayitTarihi: $kayitTarihi, photoURL: $photoURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.adi == adi &&
        other.soyadi == soyadi &&
        other.id == id &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.kayitTarihi == kayitTarihi &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return adi.hashCode ^
        soyadi.hashCode ^
        id.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        kayitTarihi.hashCode ^
        photoURL.hashCode;
  }
}

enum UyelikTipi {
  free,
  paid,
}

extension UyelikTipiValues on UyelikTipi {
  static const map = {
    UyelikTipi.free: "free",
    UyelikTipi.paid: "paid",
  };

  String? toMap() => map[this];

  String get getUyelikTipiBaslik {
    switch (this) {
      case UyelikTipi.free:
        return "Ücretsiz";
      case UyelikTipi.paid:
        return "Ucretli";

      default:
        throw RangeError("$this is out of the values of UyelikTipi ");
    }
  }
}

extension UyelikTipiStrings on String {
  UyelikTipi get getUyelikTipi {
    switch (this) {
      case "free":
        return UyelikTipi.free;
      case "paid":
        return UyelikTipi.paid;

      default:
        throw RangeError("$this is out of the values of UyelikTipi ");
    }
  }
}
