import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/enums/gelir_gider_turu.dart';
import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cari_hesapp_lite/models/islemler_model.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:flutter/material.dart';

class DetayRaporViewModel extends ChangeNotifier {
  DateTime selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<Islemler> list;

  List filterList;
  DetayRaporViewModel(this.list,this.filterList);

  List<Islemler> getList() {
    bas("list.length");
    bas(list.length);

    var _list = list.where((element) {
      var islemDay = element.islemTarihi?.toDate();

      if (islemDay == null) return false;
      if (islemDay.isAfter(selectedDay.subtract(const Duration(seconds: 1))) &&
          islemDay.isBefore(selectedDay.add(const Duration(days: 1)))) {
        return true;
      }
      return false;
    }).toList();

    _list = filter(_list);

    return _list;
  }

  num verTot = 0;
  String toplamVerilen() {
    verTot = 0;
    for (var item in getList()) {
      if (item.runtimeType == CariIslemModel &&
          (item as CariIslemModel).islemTuru == CariIslemTuru.satis) {
        verTot += item.toplamTutar ?? 0;
      } else if ((item as HesapHareketModel).gelirGiderTuru ==
          GelirGiderTuru.gider) {
        verTot += item.toplamTutar ?? 0;
      }
    }
    return verTot.toStringAsFixed(2) + "₺";
  }

  num alTot = 0;
  String toplamAlinan() {
    alTot = 0;
    for (var item in getList()) {
      bas("for =>>>>>>");
      bas(item);
      if (item.runtimeType == CariIslemModel &&
          (item as CariIslemModel).islemTuru == CariIslemTuru.alis) {
        alTot += item.toplamTutar ?? 0;
      } else if (item.runtimeType == HesapHareketModel &&
          (item as HesapHareketModel).gelirGiderTuru == GelirGiderTuru.gelir) {
        alTot += item.toplamTutar ?? 0;
      }
    }
    return alTot.toStringAsFixed(2) + "₺";
  }

  num get farkTot => alTot - verTot;
  void previousDay() {
    selectedDay = selectedDay.subtract(const Duration(days: 1));
    notifyListeners();
  }

  void nextDay() {
    selectedDay = selectedDay.add(const Duration(days: 1));
    notifyListeners();
  }

  List<Islemler> filter(List<Islemler> list) {
    return list;
  }
}
