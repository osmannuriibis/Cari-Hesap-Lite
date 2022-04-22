import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/views/raporlar/rapor_view_model.dart';
import 'package:flutter/material.dart';

class GenelRaporViewModel extends ChangeNotifier {
  late int _dropdownValue;

  var tumHareketList = <HesapHareketModel>[];
  int get dropdownValue => _dropdownValue;

  set dropdownValue(int value) {
    _dropdownValue = value;
    notifyListeners();
  }

  RaporViewModel? viewModelBase;
  late List<CariIslemModel> tumCariIslemList;

  GenelRaporViewModel(this.tumCariIslemList, this.tumHareketList) {
    dropdownValue = aylikIslemlerInYil.keys.firstWhere(
      (element) => element == DateTime.now().year,
      orElse: () => aylikIslemlerInYil.keys.first,
    );
  }
  num get toplamByYil => toplamSatisByYil[dropdownValue] ?? 0;

  Map<int, Map<int, List<CariIslemModel>>>? _aylikIslemlerInYil;

  Map<int, Map<int, List<CariIslemModel>>> get aylikIslemlerInYil =>
      _aylikIslemlerInYil ?? _getAylikIslemlerInYil();

  List<int>? _yillar;
  List<int> get yillar {
    if (_yillar != null) return _yillar!;

    _yillar = (aylikIslemlerInYil).keys.toList();
    return _yillar!;
  }

  Map<int, num>? _toplamSatisByYil;
  Map<int, num> get toplamSatisByYil => _toplamSatisByYil ?? _getToplamSatis();

  num get aylikOrtalamaSatisByYil =>
      toplamByYil / ((aylikIslemlerInYil[dropdownValue])?.keys.length ?? 1);

  int getYilIcindekiIlkSatisinGectigiGunSayisi() {
    var list = tumCariIslemList
        .where((element) =>
            element.islemTarihi!.toDate().isAfter(DateTime(dropdownValue)))
        .toList();
    list.sort((e, y) => e.islemTarihi!.compareTo(y.islemTarihi!));

    return list.isNotEmpty
        ? list.first.islemTarihi!
            .toDate()
            .difference(
                //Seçili yıl geçmiş yıl ise yılın son gününü baz alıyor
                //yoksam içinde bulunduğumuz günün farkını alıyor
                DateTime.now().year > dropdownValue
                    ? DateTime(dropdownValue + 1)
                    : DateTime.now())
            .inDays
            .abs()
        : 1;
  }

  num get gunlukOrtSatis {
    return toplamByYil / (getYilIcindekiIlkSatisinGectigiGunSayisi() + 1);
  }

  int get satisMiktari {
    int result = 0;
    if (aylikIslemlerInYil[dropdownValue] != null) {
      for (var item in aylikIslemlerInYil[dropdownValue]!.values) {
        result += item.length;
      }
    }
    return result;
  }

  Map<int, num> get aylikSatisInAyByYil {
    Map<int, num> _aylikSatisInAyByYil = {};

    for (var item in aylikIslemlerInYil[dropdownValue]!.entries) {
      num toplam = 0;

      for (var item in item.value) {
        toplam += item.toplamTutar ?? 0;
      }
      _aylikSatisInAyByYil.addAll({item.key: toplam});
    }
    return _aylikSatisInAyByYil;
  }

  Map<int, num> _getToplamSatis() {
    _toplamSatisByYil = <int, num>{};
    for (var yil in (yillar)) {
      num _toplamSatis = 0.0;

      for (var cariIslem in (tumCariIslemList)) {
        if (yil == cariIslem.islemTarihi!.toDate().year) {
          _toplamSatis += cariIslem.toplamTutar!;
        }
      }
      _toplamSatisByYil!.addAll({yil: _toplamSatis});
    }

    return _toplamSatisByYil!;
  }

  Map<int, Map<int, List<CariIslemModel>>> _getAylikIslemlerInYil() {
    if (_aylikIslemlerInYil != null) return _aylikIslemlerInYil!;

    _aylikIslemlerInYil = {};
    for (var cariIslem in (tumCariIslemList)) {
      _aylikIslemlerInYil!.update(
        cariIslem.islemTarihi!.toDate().year,
        (_aylikMap) {
          _aylikMap;
          _aylikMap.update(
            cariIslem.islemTarihi!.toDate().month,
            (value) {
              value;
              value.add(cariIslem);
              return value;
            },
            ifAbsent: () {
              return [cariIslem];
            },
          );
          return _aylikMap;
        },
        ifAbsent: () {
          return {
            cariIslem.islemTarihi!.toDate().month: [cariIslem]
          };
        },
      );
    }

    return _aylikIslemlerInYil!;
  }

/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
  ///

  num get son30GunlukSatis => tumCariIslemList
      .where((element) => element.islemTarihi!
          .toDate()
          .isAfter(DateTime.now().subtract(const Duration(days: 30))))
      .toList()
      .fold<num>(
          0,
          (previousValue, element) =>
              previousValue + (element.toplamTutar ?? 0));

  num get son7GunlukSatis => tumCariIslemList
      .where((element) => element.islemTarihi!
          .toDate()
          .isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList()
      .fold<num>(
          0,
          (previousValue, element) =>
              previousValue + (element.toplamTutar ?? 0));

  num get son30GunlukTahsilat => tumHareketList
      .where((element) => element.islemTarihi!
          .toDate()
          .isAfter(DateTime.now().subtract(const Duration(days: 30))))
      .toList()
      .fold<num>(
          0,
          (previousValue, element) =>
              previousValue + (element.toplamTutar ?? 0));

  num get son7GunlukTahsilat => tumHareketList
      .where((element) => element.islemTarihi!
          .toDate()
          .isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList()
      .fold<num>(
          0,
          (previousValue, element) =>
              previousValue + (element.toplamTutar ?? 0));
}

extension QueryDocumentSnapshotExtens on QueryDocumentSnapshot {
  DateTime get getDuzenlemeTarihi => (get("islemTarihi") as Timestamp).toDate();
}
