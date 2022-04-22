import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cari_hesapp_lite/models/islemler_model.dart';

import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:flutter/material.dart';

class RaporViewModel extends ChangeNotifier {
  DBUtils dbutil = DBUtils();

  List<CariIslemModel>? cariIslemList;
  List<HesapHareketModel>? hesapHareketList;

  var tabController = GlobalKey<State>();

  String? alis;

  String? gelir;

  String? gider;

  bool? satis = false;

  RaporViewModel() {
    getData();
  }

  void getData() async {
    await _getTumList();
  }

  Future<List<Islemler>> get tumIslemList async {
    return (cariIslemList == null || hesapHareketList == null)
        ? await _getTumList()
        : [...cariIslemList!, ...hesapHareketList!];
  }

  Future<List<Islemler>> _getTumList() async {
    var _list = [
      ...await dbutil.getModelListAsFuture<CariIslemModel>(),
      ...await dbutil.getModelListAsFuture<HesapHareketModel>()
    ];
    _list.sort((e, y) => (e.islemTarihi!.compareTo(y.islemTarihi!)));
    bas("_list.length");
    bas(_list.length);
    return _list;
  }
}
