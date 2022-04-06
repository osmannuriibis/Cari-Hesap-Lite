import 'dart:async';
import 'package:cari_hesapp_lite/models/stok_hareket.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:flutter/material.dart';

import '../../../models/kartlar/stok_kart.dart';

class StokViewModel extends ChangeNotifier {
  var dbUtil = DBUtils();
  StokKart stokKart;
  List<MapEntry<String, num>> depoList = [];
  List<StokHareket> listStokHareket = [];


  late StreamSubscription<List<StokHareket>> listenMovement;

  StokViewModel(this.stokKart) {
    init();
  }



  void fetchMovement() {
    listenMovement = dbUtil.getModelListAsStream<StokHareket>(
        [MapEntry("urunId", stokKart.id!)]).call((event) {
      bas("event.length");
      bas(event.length);
      listStokHareket.clear();
      for (var item in event) {
        listStokHareket.add(item);
      }
      notifyListeners();
    });
  }

  void init() {
    fetchMovement();
  }
}
