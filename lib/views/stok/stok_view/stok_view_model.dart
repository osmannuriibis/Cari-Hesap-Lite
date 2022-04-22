import 'dart:async';
import 'package:cari_hesapp_lite/models/stok_hareket.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:flutter/material.dart';

import '../../../models/kartlar/stok_kart.dart';

class StokViewModel extends ChangeNotifier {
  var dbUtil = DBUtils();
  StokKart stokKart;
  List<StokHareket> listStokHareket = [];

  late StreamSubscription<List<StokHareket>> listenMovement;

  StokViewModel(this.stokKart) {
    init();
  }

  void fetchMovement() {
    listenMovement = dbUtil.getModelListAsStream<StokHareket>([
      MapEntry(MapEntry("urunId", stokKart.id!), FirestoreClause.isEqualTo)
    ]).call((event) {
      listStokHareket.clear();
      for (var item in event) {
        listStokHareket.add(item);
      }
      listStokHareket.sort((e, y) => e.islemTarihi!.compareTo(y.islemTarihi!));
      notifyListeners();
    });
  }

  void init() {
    fetchMovement();
  }

  void deleteStok() {
    dbUtil.deleteModel(stokKart);
  }
}
