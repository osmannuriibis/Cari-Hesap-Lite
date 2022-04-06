import 'dart:convert';

import 'package:cari_hesapp_lite/utils/place_picker_package/lib/place_picker.dart';
import 'package:geolocator/geolocator.dart';

class Konum {
  num? latitude;
  num? longitude;
  bool isCertain;
  Konum({
    this.latitude,
    this.longitude,
    this.isCertain = false,
  });

  Konum.fromLatLng(LatLng? latLng, {this.isCertain = false}) {
    if (latLng != null) {
      latitude = latLng.latitude;
      longitude = latLng.longitude;
    }
  }

  Konum.fromPosition(Position? position, {this.isCertain = false}) {
    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
    }
  }

//  LatLng getLatLng() => LatLng(latitude, longitude);

  Konum copyWith({
    num? latitude,
    num? longitude,
    bool? isCertain,
  }) {
    return Konum(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isCertain: isCertain ?? this.isCertain,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'isCertain': isCertain,
    };
  }

  factory Konum.fromMap(Map<dynamic, dynamic> map) {
    return Konum(
      latitude: map['latitude'],
      longitude: map['longitude'],
      isCertain: map['isCertain'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Konum.fromJson(String source) => Konum.fromMap(json.decode(source));

  @override
  String toString() =>
      'Konum(latitude: $latitude, longitude: $longitude, isCertain: $isCertain)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Konum &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isCertain == isCertain;
  }

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ isCertain.hashCode;
}
