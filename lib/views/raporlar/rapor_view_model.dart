import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_vm.dart';
import 'package:flutter/material.dart';

class RaporViewModel extends ChangeNotifier {

   RaporViewModel() {
    getData();
  }

  void getData() async {
    await _getTumList();
    
  }


  List<CariIslemModel>? _tumIslemList;
  Future<List<CariIslemModel>> get tumIslemList async {
    return _tumIslemList ?? await _getTumList();
  }

    Future<List<CariIslemModel>> _getTumList() async {
    _tumIslemList =
        await DBUtils().
        getModelListAsFuture<CariIslemModel>();


    _tumIslemList!
        .sort((e, y) => (e.islemTarihi!.compareTo(y.islemTarihi!)));

    return _tumIslemList!;
  }

}
