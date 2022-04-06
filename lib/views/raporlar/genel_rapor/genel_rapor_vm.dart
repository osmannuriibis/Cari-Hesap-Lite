import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/views/raporlar/rapor_view_model.dart';
import 'package:flutter/material.dart';

class GenelRaporViewModel extends ChangeNotifier {
 late int _dropdownValue;
  int get dropdownValue => this._dropdownValue;

  set dropdownValue(int value) {
    _dropdownValue = value;
    notifyListeners();
  }

  RaporViewModel? viewModelBase;
 late List<QueryDocumentSnapshot> tumIslemList;

  GenelRaporViewModel(this.tumIslemList) {
    dropdownValue = aylikIslemlerInYil.keys.firstWhere(
      (element) => element == DateTime.now().year,
      orElse: () => aylikIslemlerInYil.keys.first,
    );
  }
  num get toplamByYil => toplamSatisByYil[dropdownValue] ?? 0;

  Map<int, Map<int, List<QueryDocumentSnapshot>>>? _aylikIslemlerInYil;

  Map<int, Map<int, List<QueryDocumentSnapshot>>> get aylikIslemlerInYil =>
      _aylikIslemlerInYil ?? _getAylikIslemlerInYil();

  List<int>? _yillar;
  List<int> get yillar {
    if (_yillar != null) return _yillar!;

    _yillar = (aylikIslemlerInYil).keys.toList();
    return _yillar!;
  }

  Map<int, num>? _toplamSatisByYil;
  Map<int, num> get toplamSatisByYil =>
      _toplamSatisByYil ?? _getToplamSatis();

  num get aylikOrtalamaSatisByYil =>
      toplamByYil /
      ((aylikIslemlerInYil[dropdownValue] )?.keys.length ?? 1);

  num get gunlukOrtSatis => toplamByYil / 360;

  int get satisMiktari {
    int result = 0;
    if(aylikIslemlerInYil[dropdownValue] != null)
    for (var item in aylikIslemlerInYil[dropdownValue]!.values) {
      result += item.length;
    }
    return result;
  }

  Map<int, num> get aylikSatisInAyByYil {
    Map<int, num> _aylikSatisInAyByYil = {};

    for (var item in aylikIslemlerInYil[dropdownValue]!.entries) {
      num toplam = 0;

      for (var item in item.value) {
        toplam += item.get("sonToplam") as num;
      }
      _aylikSatisInAyByYil.addAll({item.key: toplam});
    }
    return _aylikSatisInAyByYil;
  }

  Map<int, num> _getToplamSatis() {
    _toplamSatisByYil = <int,num>{};
    for (var yil in (yillar)) {
      num _toplamSatis = 0.0;

      for (var snapshot in (tumIslemList)) {
        if (yil == snapshot.getDuzenlemeTarihi.year) {
          _toplamSatis += snapshot.get("sonToplam") as num;
        }
      }
      _toplamSatisByYil!.addAll({yil: _toplamSatis});
    }

    return _toplamSatisByYil!;
  }

  Map<int, Map<int, List<QueryDocumentSnapshot>>> _getAylikIslemlerInYil() {
    bas("ifdenönce");
    if (_aylikIslemlerInYil != null) return _aylikIslemlerInYil!;
    bas("ifden sonra");

    _aylikIslemlerInYil = {};
    for (var snapshot in (tumIslemList)) {
      _aylikIslemlerInYil!.update(
        snapshot.getDuzenlemeTarihi.year,
        (_aylikMap) {
          if (_aylikMap == null) _aylikMap = {};
          _aylikMap.update(
            snapshot.getDuzenlemeTarihi.month,
            (value) {
              if (value == null) value = [];
              value.add(snapshot);
              return value;
            },
            ifAbsent: () {
              return [snapshot];
            },
          );
          return _aylikMap;
        },
        ifAbsent: () {
          return {
            snapshot.getDuzenlemeTarihi.month: [snapshot]
          };
        },
      );
    }

    bas("_aylikIslemlerByYil");
    bas(_aylikIslemlerInYil);
    return _aylikIslemlerInYil!;
  }
}

extension QueryDocumentSnapshotExtens on QueryDocumentSnapshot {
  DateTime get getDuzenlemeTarihi =>
      (this.get("islemTarihi") as Timestamp).toDate();
}
