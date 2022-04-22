import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/enums/miktar_degisim.dart';
import 'package:cari_hesapp_lite/utils/catch.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../enums/gelir_gider_turu.dart';
import '../../../enums/hesap_hareket_turu.dart';
import '../../../models/cari_islem.dart';
import '../../../models/kartlar/cari_kart.dart';
import '../../../models/hesap_hareket.dart';

import '../../../services/firebase/auth/service/auth_service.dart';
import '../../../utils/date_format.dart';
import 'package:flutter/material.dart';

class AccountTransactionAddViewModel extends ChangeNotifier {
  late bool isNewAdding;
  bool _isAllowedAdjust = true;
  CariKart? cariKart;
  late GelirGiderTuru gelirGiderTuru;

  late HesapHareketModel model;
  late DBUtils dbutil;

  CariIslemModel? sonCariIslem;
  /////////////////////////////
  ///
  ///
  var formKey = GlobalKey<FormState>();

  var controllerBelgeNo = TextEditingController();
  var controllerIslemTarihi =
      TextEditingController(text: dateFormatterToString(Timestamp.now()));
  var controllerAciklama = TextEditingController();
  var controllerTutar = TextEditingController();

  late HesapHareketTuru _hesapHareketTuru;

  HesapHareketTuru get hesapHareketTuru => _hesapHareketTuru;
  set hesapHareketTuru(HesapHareketTuru value) {
    notifyListeners();
    _hesapHareketTuru = value;
  }

  num get tutar => controllerTutar.text != ""
      ? (num.tryParse(controllerTutar.text) ?? 0)
      : 0;

  bool get isAllowedAdjust => _isAllowedAdjust;
  set isAllowedAdjust(bool value) {
    _isAllowedAdjust = value;
    notifyListeners();
  }

  AccountTransactionAddViewModel.addNew({
    required this.cariKart,
    required this.gelirGiderTuru,
    required HesapHareketTuru hesapHareketTuru,
  }) {
    isNewAdding = true;
    this.hesapHareketTuru = hesapHareketTuru;
    model = HesapHareketModel();

    init();
  }

  AccountTransactionAddViewModel.showExist(this.model, {this.cariKart}) {
    isNewAdding = false;
    isAllowedAdjust = false;
    gelirGiderTuru = model.gelirGiderTuru!;
    hesapHareketTuru = model.hesapHareketTuru!;
    if (cariKart == null) {
      DBUtils().getCariKartById(model.gidenId!).then((cariKart) {
        this.cariKart = cariKart;
        notifyListeners();
      });
    }

    init();
  }

  void init() {
    dbutil = DBUtils();
    setControllers();
    fetchSonCariIslem();
  }

  void setControllers() {
    if (!isNewAdding) {
      bas(model);
      controllerBelgeNo = TextEditingController(text: model.evrakNo);
      controllerIslemTarihi = TextEditingController(
          text: dateFormatterToString(model.islemTarihi!));
      controllerAciklama = TextEditingController(text: model.aciklama);
      controllerTutar = TextEditingController(
          text: model.toplamTutar?.toStringAsFixed(2) ?? "0");
    }
  }

  ///İşlem Türüne(Tahsilat&Ödeme) göre son satış veya alış işlemini getirme...
  Future<void> fetchSonCariIslem() async {
    if (sonCariIslem != null) return;
    String islemTuru = (gelirGiderTuru == GelirGiderTuru.gelir)
        ? CariIslemTuru.satis.stringValue
        : CariIslemTuru.alis.stringValue;
    if (cariKart != null) {
      await DBUtils().getModelListAsFuture<CariIslemModel>([
        MapEntry("islemTuru", islemTuru),
        MapEntry("cariId", cariKart!.id!),
      ]).then((snapshot) {
        snapshot.sort((e, y) => e.islemTarihi!.compareTo(y.islemTarihi!));
        if (snapshot.isNotEmpty) {
          sonCariIslem = snapshot.first;
          notifyListeners();
        }
      });
    }
  }

  ///////////
  ///////////
  ///////////  SAVE
  ///////////    |
  ///////////    |
  ///////////    |
  ///////////   \ /
  ///////////    V

  Future<String?> save() async {
    modeliHazirla();
    if (await modeliYaz() == null) {
      return await bakiyeleriGuncelle();
    }
    return fetchCatch(Exception("modeliyaz hatalı"), this);
  }

  modeliHazirla() {
    try {
      model = model.copyWith(
        aciklama: controllerAciklama.text.trim(),
        cariId: cariKart?.id,
        cariUnvani: cariKart?.unvani ?? "",
        gidenAdi: gelirGiderTuru == GelirGiderTuru.gider
            ? cariKart!.unvani
            : "mainKasa",
        gidenId:
            gelirGiderTuru == GelirGiderTuru.gider ? cariKart!.id : "kasa1",
        gelenAdi: gelirGiderTuru == GelirGiderTuru.gider
            ? "mainKasa"
            : cariKart!.unvani,
        gelenID:
            gelirGiderTuru == GelirGiderTuru.gider ? "kasa1" : cariKart!.id,
        evrakNo: controllerBelgeNo.text.trim(),
        gelirGiderTuru: gelirGiderTuru,
        hesapHareketTuru: hesapHareketTuru,
        islemTarihi: dateFormatterFromString(controllerIslemTarihi.text),
        kayitTarihi: Timestamp.now(),
        kullaniciId: AuthService().currentUserId,
        toplamTutar: tutar, /* */
      );
    } on Exception catch (err) {
      fetchCatch(err, this);
    }
  }

  Future<String?> modeliYaz() async {
    return dbutil.addOrSetModel(model);
  }

  Future<String?> bakiyeleriGuncelle({bool reverse = false}) async {
    try {
      dbutil.updateCariBakiye(
        cariKart!.id!,
        tutar,
        gelirGiderTuru == GelirGiderTuru.gelir
            ? (reverse ? Degisim.artir : Degisim.azalt)
            : (reverse ? Degisim.azalt : Degisim.artir),
      );
/*        if (hesapModel.runtimeType == KasaModel) {
        try {
          dbutil
            ..updateCariBakiye(
                cariKart!.id!,
                tutar,
                (gelirGiderTuru == GelirGiderTuru.gelir)
                    ? CariIslemTuru.alis
                    : CariIslemTuru.satis)
            ..updateKasaBakiye(
                hesapModel as KasaModel,
                tutar,
                gelirGiderTuru == GelirGiderTuru.gelir
                    ? Degisim.artir
                    : Degisim.azalt);
          return true;
        } on Exception catch (e) {
          return fetchCatch(e, this);
        }
      } else if (hesapModel.runtimeType == PosHesap) {
        return dbutil.moneyTransferHesapToCari<CariKart, PosHesap>(
            kartModel: cariKart!,
            hesapModel: hesapModel! as PosHesap,
            tutar: tutar,
            isToKart: (gelirGiderTuru == GelirGiderTuru.gelir) ? false : true);
      } else if (hesapModel.runtimeType == BankaHesap) {
        bas("Banka İçi", this);
        var model = hesapModel as BankaHesap;
        return dbutil.moneyTransferHesapToCari<CariKart, BankaHesap>(
            kartModel: cariKart!,
            hesapModel: model,
            toplamTutar: tutar,
            isToKart: (gelirGiderTuru == GelirGiderTuru.gelir) ? false : true);
      } else if (hesapModel.runtimeType == KartHesap) {
        return dbutil.moneyTransferHesapToCari<CariKart, KartHesap>(
            kartModel: cariKart!,
            hesapModel: hesapModel! as KartHesap,
            toplamTutar: tutar,
            isToKart: (gelirGiderTuru == GelirGiderTuru.gelir) ? false : true);
      } else {
        throw Exception();
      }  */
    } on Exception catch (err) {
      return fetchCatch(err, this);
    }
    return null;
  }
}
