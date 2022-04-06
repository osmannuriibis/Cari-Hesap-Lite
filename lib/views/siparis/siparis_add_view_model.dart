import 'package:cari_hesapp_lite/enums/siparis_status.dart';
import 'package:cari_hesapp_lite/models/kartlar/stok_kart.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../enums/cari_islem_turu.dart';
import '../../models/kartlar/cari_kart.dart';
import '../../models/siparis_model.dart';
import '../../utils/print.dart';
import 'package:flutter/material.dart';

class SiparisAddViewModel extends ChangeNotifier {
  late CariIslemTuru cariIslemTuru;
  late CariKart cariKart;

  SiparisModel _siparisModel = SiparisModel();

  SiparisKalemModel kalemModel = SiparisKalemModel();

  var controllerMiktari = TextEditingController(text: "");

  var controllerAdi = TextEditingController(text: "");
  var controllerAciklama = TextEditingController(text: "");

  String? _birim;

  Timestamp _tarih = Timestamp.now();

  Timestamp get tarih => _tarih;

  set tarih(Timestamp value) {
    controllerTarih.text = dateFormatterToString(_tarih = value);
  }

  var controllerTarih =
      TextEditingController(text: dateTimeFormatterToString(DateTime.now()));

  SiparisAddViewModel.addNew(
      {required this.cariIslemTuru, required this.cariKart}) {
    init();
  }

  ////////
  //////// SETTERS
  //////// GETTERS
  ////////

  SiparisModel get siparis {
    return _siparisModel;
  }

  set siparis(SiparisModel value) {
    _siparisModel = value;
    bas("Notify");

    notifyListeners();
  }

  String? get birim => _birim;

  set birim(String? value) {
    _birim = value;
    notifyListeners();
    bas("notify");
  }
  //setters & getters
  ////////////////////////////////////////////////////////////

  @override
  void dispose() {
    super.dispose();
  }

  deleteItem(int i) {
    siparis.siparisKalemleri.removeAt(i);
    notifyListeners();
  }

  selectStok(StokKart stokKart) {
    kalemModel
      ..urunAdi = controllerAdi.text = (stokKart.adi ?? "")
      ..urunId = stokKart.id
      ..birim = birim = stokKart.birim;

    notify();
  }

  addItem() {
    kalemModel = kalemModel.copyWith(
      urunMiktari: num.tryParse(controllerMiktari.text),
    );

    siparis.siparisKalemleri.add(kalemModel);

    notifyListeners();
    controllerAdi.text = controllerMiktari.text = "";
    kalemModel = SiparisKalemModel();
    birim = null;
  }

  void notify() {
    notifyListeners();
  }

  void init() {
    siparis
      ..cariId = cariKart.id
      ..cariIslemTuru = cariIslemTuru;
  }
  ////////
  //////// SAVE
  ////////
  ////////

  Future<String?> save() async {
    siparis = siparis.copyWith(
      siparisStatus: SiparisStatus.olusturuldu,
      siparisTarihi: tarih,
      kayitTarihi: Timestamp.now(),
      cariAdi: cariKart.unvani,
      aciklama: controllerAciklama.text,
    );

    return await DBUtils().addOrSetModel(siparis);
  }
}
