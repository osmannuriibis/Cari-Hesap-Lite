import 'dart:math';

import 'package:cari_hesapp_lite/utils/place_picker_package/lib/place_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class KonumService extends ChangeNotifier {
  int deger = Random().nextInt(40);

  late Position _lastLocation;
  Position? _currentLocation;
  Stream<Position> get streamLocation => Geolocator.getPositionStream();
  static final KonumService _konumService = KonumService._internal();

  KonumService._internal() {
    init();
  }
  factory KonumService() {
    return _konumService;
  }

  requestPermission() {
    Geolocator.isLocationServiceEnabled().then((value) {
      if (value) {
        Geolocator.checkPermission().then((value) {
          if (value.index < 2) {
            Geolocator.requestPermission().then((value) {
              if (value.index > 1) {
                Geolocator.getCurrentPosition().then((value) {
                });
                Geolocator.getLastKnownPosition().then((value) {
                  if (value != null) lastLocation = value;
                });
              }
            });
          }
        });
      }
    });
  }

  Position get currentPosition {
    init();
    return _currentLocation ?? _lastLocation;
  }

  set currentPosition(Position value) {
    _currentLocation = value;
    notifyListeners();
  }

  Position get lastLocation {
    init();
    return _lastLocation;
  }

  set lastLocation(Position value) {
    _lastLocation = value;
    notifyListeners();
  }

  void init() {
    Geolocator.getCurrentPosition().then((value) {
      currentPosition = value;
    });

    Geolocator.getLastKnownPosition().then((value) {
      if (value != null) lastLocation = value;
    });
  }
}

extension SetLatLng on Position {
  get toLatLng => LatLng(latitude, longitude);
  get toGeoPoint => GeoPoint(latitude, longitude);
}
