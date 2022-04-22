import 'dart:math';

import 'package:cari_hesapp_lite/utils/place_picker_package/lib/place_picker.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class KonumService extends ChangeNotifier {
  int deger = Random().nextInt(40);

  Position? _lastLocation;
  Position? _currentLocation;
  Stream<Position> get streamLocation => Geolocator.getPositionStream();
  static final KonumService _konumService = KonumService._internal();

  KonumService._internal() {
    init();
    requestPermission();
  }
  factory KonumService() {
    return _konumService;
  }

  requestPermission() {
    Geolocator.isLocationServiceEnabled().then((value) {
      bas("isLocationServiceEnabled");
      bas(value);
      if (value) {
        Geolocator.checkPermission().then((value) {
          bas("checkPermission");
          bas(value);
          if (value.index < 2) {
            Geolocator.requestPermission().then((value) {
              if (value.index > 1) {
                Geolocator.getCurrentPosition().then((value) {
                  currentPosition = value;
                });
                Geolocator.getLastKnownPosition().then((value) {
                  lastLocation = value;
                });
              }
            });
          }
        });
      } else {
        Geolocator.openAppSettings();
      }
    });
  }

  Position? get currentPosition {
    init();
    return _currentLocation;
  }

  set currentPosition(Position? value) {
    _currentLocation = _lastLocation = value;
    notifyListeners();
  }

  Position? get lastLocation {
    init();
    return currentPosition ?? _lastLocation;
  }

  set lastLocation(Position? value) {
    _lastLocation = value;
    notifyListeners();
  }

  void init() {
    Geolocator.getCurrentPosition().then((value) {
      _lastLocation = currentPosition = value;
    });
    streamLocation.listen((event) {
      currentPosition = event;
    });
    Geolocator.getLastKnownPosition().then((value) {
      if (value != null) lastLocation = value;
    });
  }
}

void asd() {}

extension SetLatLng on Position {
  get toLatLng => LatLng(latitude, longitude);
  get toGeoPoint => GeoPoint(latitude, longitude);
}
