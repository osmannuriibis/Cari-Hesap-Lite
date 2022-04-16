import 'dart:async';

import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cari_hesapp_lite/models/islemler_model.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/kartlar/cari_kart.dart';

import 'package:flutter/material.dart';

class CariViewModel extends ChangeNotifier {
  var dbUtil = DBUtils();
  CariKart _cariKart;
  CariKart get cariKart => _cariKart;
  late StreamSubscription<CariKart?> listenCariKart;

  late StreamSubscription<List<CariIslemModel>> listenCariIslem;
  late StreamSubscription<List<HesapHareketModel>> listenHesapHareket;

  List<CariIslemModel> _listCariIslem = [];
  List<HesapHareketModel> _listHesapHareket = [];

  List<CariIslemModel> get listCariIslem => _listCariIslem;

  set listCariIslem(List<CariIslemModel> value) {
    _listCariIslem = value;
    notifyListeners();
  }

  List<HesapHareketModel> get listHesapHareket => _listHesapHareket;

  set listHesapHareket(List<HesapHareketModel> value) {
    _listHesapHareket = value;
    notifyListeners();
  }

  set cariKart(CariKart value) {
    _cariKart = value;
    notifyListeners();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  CariViewModel(this._cariKart) {
    fetchTransactionList();
  }

  Query<Map<String, dynamic>> getCariIslemlerQuery() {
    return DBUtils()
        .getClassReference<CariIslemModel>()
        .where("cariId", isEqualTo: cariKart.id);
  }

  void makeCall() {
    var tel = _cariKart.telNo?.first;
    if (tel.isNotEmptyOrNull) {
      canLaunch('tel').then((value) => null);
      // launch('tel:${_cariKart.telNo!.first!}');
      launch(Uri(scheme: 'tel', path: tel).toString());
    }
  }

  void getDirection() {
    var latitude = _cariKart.konum?.latitude;
    var longitude = _cariKart.konum?.longitude;
    if (latitude.isNotNullOrEmpty && latitude.isNotNullOrEmpty) {
      // ignore: unused_local_variable
      String googleMapslocationUrl =
          "https://www.google.com/maps/search/?api=1&query=${latitude.toString()},${longitude.toString()}";

      launch(Uri(
          scheme: 'geo',
          host: '0,0',
          queryParameters: {'q': '$latitude,$longitude'}).toString());
    }
  }

  void openEmail() {
    var mail = _cariKart.email;
    if (mail.isNotEmptyOrNull) {
      canLaunch('mailto:').then((value) {
        if (value) {
          launch("mailto:$mail");
        }
      });
    }
  }

  List<Islemler> get getlist {
    var _list = [...(listCariIslem), ...(listHesapHareket)];

    _list.sort((e, y) {
      DateTime _e = e.islemTarihi!.toDate(), _y = y.islemTarihi!.toDate();

      return _e.compareTo(_y);
    });

    return _list;
  }

  void fetchTransactionList() {
    listenCariIslem = dbUtil.getModelListAsStream<CariIslemModel>([
      MapEntry(MapEntry("cariId", cariKart.id!), FirestoreClause.isEqualTo)
    ]).call(
      (event) {
        listCariIslem.clear();
        listCariIslem = event;
      },
    );

    listenHesapHareket = dbUtil.getModelListAsStream<HesapHareketModel>([
      MapEntry(MapEntry("cariId", cariKart.id!), FirestoreClause.isEqualTo)
    ]).call(
      (event) {
        listHesapHareket.clear();
        listHesapHareket = event;
      },
    );
    listenCariKart =
        dbUtil.getModelAsStream<CariKart>(cariKart.id!).call(((event) {
      if (event != null) cariKart = event;
    }));
  }

  void notify() {
    notifyListeners();
  }

  @override
  void dispose() {
    listenCariIslem.cancel();
    listenHesapHareket.cancel();
    listenCariKart.cancel();
    super.dispose();
  }
}
