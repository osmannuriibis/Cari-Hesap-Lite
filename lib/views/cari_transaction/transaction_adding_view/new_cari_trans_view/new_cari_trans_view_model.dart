import 'dart:math';

import 'package:cari_hesapp_lite/enums/siparis_status.dart';
import 'package:cari_hesapp_lite/models/siparis_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/enums/miktar_degisim.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';

import '../../../../enums/cari_islem_turu.dart';
import '../../../../enums/irsaliye_turu_enum.dart';
import '../../../../models/cari_islem.dart';
import '../../../../models/kartlar/cari_kart.dart';
import '../../../../models/islemler_model.dart';
import '../../../../models/stok_hareket.dart';
import '../../../../services/firebase/auth/service/auth_service.dart';
import '../../../../utils/catch.dart';
import '../../../../utils/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/* Bu  işlem sonunda oluşturulacak (yazılacak) veriler;
CariIslem
Islemler;
StokHareketleri;
*/

class CariTransactionAddViewModel extends ChangeNotifier {
  late DBUtils dbutil;

  late bool isNew = true;
  bool _isAllowedToAdjust = false;

  late CariIslemModel cariIslem;
  CariIslemModel? _cariIslemIlkHali;

  late CariKart cariKart;

  SiparisModel? siparisModel;

  bool _isSiparisShowing = true;
  bool get isSiparisShowing => _isSiparisShowing;

  set isSiparisShowing(bool value) {
    _isSiparisShowing = value;
    notifyListeners();
  }

  MapEntry<IrsaliyeTuru, String> _evrakTuru = MapEntry(
      IrsaliyeTuru.irsaliyeliFatura, IrsaliyeTuru.irsaliyeliFatura.stringValue);
  MapEntry<IrsaliyeTuru, String> get evrakTuru => _evrakTuru;

  set evrakTuru(MapEntry<IrsaliyeTuru, String> value) {
    _evrakTuru = value;
    setNumFields();
    notifyListeners();
  }

  late String cariIslemKodu;

  var formKey = GlobalKey<FormState>();

  bool _isEvrakFieldOpen = true;
  bool get isEvrakFieldOpen => _isEvrakFieldOpen;

  set isEvrakFieldOpen(bool value) {
    _isEvrakFieldOpen = value;
    notifyListeners();
  }
  //GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  List<StokHareket> hareketListesiIlkHali = [];

  List<StokHareket> get hareketListesiSonHali => _hareketListesi;
  List<StokHareket> _hareketListesi = [];

  set hareketListesiSonHali(List<StokHareket> value) {
    _hareketListesi = value;
    notifyListeners();
  }

  late TextEditingController controllerDuzenlemeTarihi;
  late TextEditingController controllerSevkTarihi;
  late TextEditingController controllerDuzenlemeSaati;
  late TextEditingController controllerAciklama;

  late TextEditingController controllerBelgeNo;

  TextEditingController get controllerToplam =>
      TextEditingController(text: toplamTutar.toStringAsFixed(2));

  TextEditingController get controllerKdvTutar =>
      TextEditingController(text: kdvTutar.toStringAsFixed(2));

  TextEditingController get controllerTutar =>
      TextEditingController(text: tutar.toStringAsFixed(2));

  CariTransactionAddViewModel.addNewHareket({
    required this.cariKart,
    required CariIslemTuru cariIslemTuru,
    this.siparisModel,
  }) {
    cariIslem = CariIslemModel();
    init();
    isAllowedToAdjust = true;
    isNew = true;
    setControllers();

    cariIslem.islemTuru = cariIslemTuru;
    cariIslemKodu = dbutil.getClassReference<Islemler>().doc().id;

    cariIslem.islemKodu = cariIslemKodu;

    _evrakTuru = MapEntry(IrsaliyeTuru.irsaliyeliFatura,
        IrsaliyeTuru.irsaliyeliFatura.stringValue);
  }

  CariTransactionAddViewModel.showExistHareket(this.cariIslem, this.cariKart) {
    init();
    _cariIslemIlkHali = cariIslem;
    isNew = false;
    isAllowedToAdjust = false;

    cariIslemKodu = cariIslem.islemKodu!;

    _evrakTuru =
        MapEntry(cariIslem.evrakTuru!, cariIslem.evrakTuru!.stringValue);
    setHareketListByFirebase(cariIslemKodu);
    setControllers();
    firebaseSorgulari(cariIslemKodu, cariIslem.cariId!);
  }
  init() {
    dbutil = DBUtils();
  }

  bool get isAllowedToAdjust => _isAllowedToAdjust;

  set isAllowedToAdjust(bool value) {
    _isAllowedToAdjust = value;
    notifyListeners();
  }

  //

  ///////////
  ///////////TUTAR
  ///////////KDV TOPLAM
  ///////////TOPLAM
  ///////////    |
  ///////////    |
  ///////////    |
  ///////////   \ /
  ///////////    V

  num _tutar = 0;

  num _iskontoTutar = 0;
  num _netTutar = 0;
  num _kdvTutar = 0;
  num _toplamTutar = 0;

  get tutar => _tutar;

  set tutar(value) => _tutar = value;

  get iskontoTutar => _iskontoTutar;

  set iskontoTutar(value) => _iskontoTutar = value;

  get netTutar => _netTutar;

  set netTutar(value) => _netTutar = value;

  get kdvTutar => _kdvTutar;

  set kdvTutar(value) => _kdvTutar = value;

  get toplamTutar => _toplamTutar;

  set toplamTutar(value) => _toplamTutar = value;

  setNumFields() {
    tutar = 0;
    iskontoTutar = 0;
    netTutar = 0;
    kdvTutar = 0;
    toplamTutar = 0;

    for (var hareket in hareketListesiSonHali) {
      tutar += hareket.tutar;
      iskontoTutar += hareket.iskontoTutar;
      netTutar += hareket.netTutar;
      //Evrak Turu Makbuz olduğunda kdv hesaplanmıyor..
      if (evrakTuru.key != IrsaliyeTuru.makbuz) {
        kdvTutar += hareket.kdvTutar;
      } else {
        kdvTutar = 0;
      }

      if (evrakTuru.key != IrsaliyeTuru.makbuz) {
        toplamTutar += hareket.toplamTutar;
      } else {
        toplamTutar = netTutar;
      }
    }
    notifyListeners();
  }

  //(tutar - iskontoTutar) işleminin sonucu

  //id'si verilen nesnelere ulaşmak için...
  firebaseSorgulari(String cariIslemKodu, String cariId) {
    /*  Map map;
        CariIslem cariIslem;
        try {
          await dbServiceCariIslem
              .getClassReference()
              .orderByChild("islemKodu")
              .equalTo(cariIslemKodu)
              .reference()
              .once()
              .then((snapshot) {
            map = snapshot.value;
            var key = map.keys.first.toString();
            map = map[key];
            cariIslem = CariIslem.fromMap(map);
          
          });
        } catch (err) {
          isCatched = true;
         
        } finally {
          if (!isCatched || cariIslem != null) {
            controllerDuzenlemeTarihi.text =
                dateFormatterToString(cariIslem.duzenlemeTarihi);
            controllerDuzenlemeSaati.text =
                timeFormatterToString(cariIslem.duzenlemeSaati);
            controllerSevkTarihi.text = dateFormatterToString(cariIslem.sevkTarihi);
            controllerBelgeNo.text = cariIslem.evrakNo;
            controllerAciklama.text = cariIslem.aciklama;
            notifyListeners();
          }
        } */
  }

  void setControllers() {
    dateFormatterToString(cariIslem.islemTarihi ?? Timestamp.now());

    controllerDuzenlemeTarihi = TextEditingController(
        text: dateFormatterToString(cariIslem.islemTarihi ?? Timestamp.now()));

    controllerSevkTarihi = TextEditingController(
        text: dateFormatterToString((cariIslem.sevkTarihi) ?? Timestamp.now()));

    controllerDuzenlemeSaati = TextEditingController(
        text: timeFormatterToString(cariIslem.islemTarihi ?? Timestamp.now()));

    controllerAciklama = TextEditingController(text: cariIslem.aciklama ?? "");

    controllerBelgeNo = TextEditingController(text: cariIslem.evrakNo ?? "");
  }

  setHareketListByFirebase(String cariIslemKodu) async {
    var list = await dbutil.getModelListAsFuture<StokHareket>(
        [MapEntry("cariIslemKodu", cariIslemKodu)]);

    if (list.isNotEmpty) {
      for (var item in list) {
        addOrUpdateHareketToList(item);
      }

      hareketListesiIlkHali = hareketListesiSonHali.toList();
      notifyListeners();
    }
  }

  ///if [index] isn't null, this means Update
  ///,otherwise is Add
  void addOrUpdateHareketToList(StokHareket? value, {int? index}) {
    if (value != null) {
      if (index != null) {
        hareketListesiSonHali[index] = value;
      } else {
        hareketListesiSonHali.add(value);
      }

      notifyListeners();
      setNumFields();
    }
  }

  void removeItem(int index) {
    hareketListesiSonHali.removeAt(index);

    setNumFields();
    notifyListeners();
  }

  ///////////
  ///////////
  ///////////KAYIT İŞLEMİ
  ///////////
  ///////////    |
  ///////////    |
  ///////////    |
  ///////////   \ /
  ///////////    V

  Future<String?> save() async {
    setNumFields();
    try {
      var val = modelleriHazirla();
      val ??= await modelleriYaz();

      return val;
    } on Exception catch (err) {
      return fetchCatch(err, this);
    }
  }

  String? modelleriHazirla() {
    if (cariIslemVerileriniHazirla() == null &&
        islemVerileriniHazirla() == null &&
        stokHareketVerileriniHazirla() == null) {
      return null;
    } else {
      return "hata";
    }
  }

  Future<String?> modelleriYaz() async {
    var cariIslemYazVal = await cariIslemYaz();

    var stokHareketVerileriniyazVal = await stokHareketVerileriniyaz();

    var bakiyeGuncelleVal = await bakiyeGuncelle();

    if (siparisModel != null) {
      siparisModel!.siparisStatus = SiparisStatus.islemeCevrildi;
      dbutil.addOrSetModel(siparisModel!);
    }

    if (cariIslemYazVal == null &&
        stokHareketVerileriniyazVal == null &&
        bakiyeGuncelleVal == null) {
      return null;
    } else {
      return "hata";
    }
  }

  String? cariIslemVerileriniHazirla() {
    try {
      cariIslem = cariIslem.copyWith(
        aciklama: controllerAciklama.text,
        cariUnvani: cariKart.unvani,
        cariId: cariKart.id,
        islemKodu: cariIslemKodu,
        // islemSaati: timeFormatterFromString(controllerDuzenlemeSaati.text),
        islemTarihi: dateAndTimeFormatterFromString(
            controllerDuzenlemeTarihi.text.trim() +
                " " +
                controllerDuzenlemeSaati.text.trim()),
        evrakNo: controllerBelgeNo.text,
        evrakTuru: evrakTuru.key,
        iskontoTutar: iskontoTutar,
        kayitTarihi: Timestamp.now(),
        kdvTutar:
            (evrakTuru.value != IrsaliyeTuru.makbuz.stringValue) ? kdvTutar : 0,
        net: netTutar,
        sevkTarihi: dateFormatterFromString(controllerSevkTarihi.text),
        toplamTutar: (evrakTuru.value != IrsaliyeTuru.makbuz.stringValue)
            ? toplamTutar
            : netTutar,
        toplam: (evrakTuru.value != IrsaliyeTuru.makbuz.stringValue)
            ? toplamTutar
            : netTutar,
        tutar: tutar,
        kullaniciId: AuthService().currentUserId,
      );
      return null;
    } on Exception catch (err) {
      return fetchCatch(err, this);
    }
  }

  String? islemVerileriniHazirla() {
    return null;
  }

  String? stokHareketVerileriniHazirla() {
    return null;
  }

  Future<String?> cariIslemYaz() async {
    if (cariIslem == _cariIslemIlkHali) return null;

    return dbutil.addOrSetModel(cariIslem).getBoolResultForFirebase();

    /*  return await getModelReference<CariIslem>()
        .child(cariIslem.id)
        .set(cariIslem.toMap())
        .then((value) => true)
        .catchError((onError) {
      fetchCatch(this, onError);
      return false;
    }); */
  }

  /*  Future<bool> islemYaz() async {
    return dbutil.addOrSetModel(islem).getBoolResultFromString();
  } */

  Future<String?> stokHareketVerileriniyaz() async {
    try {
      var minVal =
          min(hareketListesiIlkHali.length, hareketListesiSonHali.length);
      var maxVal =
          max(hareketListesiIlkHali.length, hareketListesiSonHali.length);

      for (var i = 0; i < (minVal); i++) {
        if (hareketListesiIlkHali[i] != hareketListesiSonHali[i]) {
          var ilk = hareketListesiIlkHali[i];
          var son = hareketListesiSonHali[i];
          ilk.islemTarihi = cariIslem.islemTarihi;
          await dbutil.deleteModel(ilk);
          await dbutil.addOrSetModel(son);
        }
      }
      for (var i = minVal; i < maxVal; i++) {
        var ilkHaliBuyuk =
            hareketListesiIlkHali.length > hareketListesiSonHali.length;
        var hareket =
            ilkHaliBuyuk ? hareketListesiIlkHali[i] : hareketListesiSonHali[i];

        if (ilkHaliBuyuk) {
          dbutil.deleteModel(hareket);
        } else {
          hareket.islemTarihi = cariIslem.islemTarihi;
          dbutil.addOrSetModel(hareket);
        }
      }

      /* if (true /* listEquals(hareketListesiIlkHali, hareketListesi) */) {
        //eski hareketleri iptal et(database'den sil ve stokları eski haline getir)
        for (var hareketIlkHali in hareketListesiIlkHali) {
          await dbutil.deleteModel<StokHareket>(hareketIlkHali);
          //  reference.doc(hareketIlkHali.id).delete();

          await dbutil.updateStokQuantity(
              hareketIlkHali.depoId!,
              hareketIlkHali.urunId!,
              hareketIlkHali.miktar!,
              (cariIslem.islemTuru == CariIslemTuru.satis)
                  ? CariIslemTuru.alis
                  : CariIslemTuru.satis,
              "ilk hali");
        }
        bas("delete");
        //yeni hareketleri yaz ve stokları güncelle
        for (var hareket in hareketListesiSonHali) {
          await dbutil.addOrSetModel(hareket);

          await dbutil.updateStokQuantity(hareket.depoId!, hareket.urunId!,
              hareket.miktar!, (cariIslem.islemTuru!), "son hali");
        }
        bas("add");
      } */

      return null;
    } on Exception catch (err) {
      return fetchCatch(err, this);
    }
  }

  Future<String?> bakiyeGuncelle() async {
    if (isNew) {
      return await dbutil.updateCariBakiye(
          cariKart.id!,
          toplamTutar,
          cariIslem.islemTuru! == CariIslemTuru.satis
              ? Degisim.artir
              : Degisim.azalt);
    } else {
      if (cariIslem.toplamTutar! != _cariIslemIlkHali!.toplamTutar!) {
        //var olan işlemde toplam işlem tutarları farkı kadasr güncelliyor
        return await dbutil.updateCariBakiye(
            cariKart.id!,
            cariIslem.toplamTutar! - _cariIslemIlkHali!.toplamTutar!,
            cariIslem.islemTuru! == CariIslemTuru.satis
                ? Degisim.artir
                : Degisim.azalt);
      } else {
        //var olan işlemde toplam işlem tutarları aynı ise güncelleme yapmıyor

        return null;
      }
    }
  }

  void notify() {
    notifyListeners();
  }

  Future<String?> deleteAll() async {
    //Stokları eski haline getirme
    try {
      for (var item in hareketListesiSonHali) {
        dbutil.deleteModel(item);
      }

      //Cari bakiye eski haline getirme
      dbutil.updateCariBakiye(
          cariKart.id!,
          toplamTutar,
          cariIslem.islemTuru! == CariIslemTuru.satis
              ? Degisim.azalt
              : Degisim.artir);
      dbutil.deleteModel(cariIslem);
      return null;
    } on FirebaseException catch (err) {
      return fetchCatch(err, this);
    }
  }
}


/*  if (_cariIslemIlkHali == null) {
      return await dbutil.updateCariBakiye(
          cariKart.id!,
          cariIslem.toplamTutar!,
          cariIslem.islemTuru! == CariIslemTuru.satis
              ? Degisim.artir
              : Degisim.azalt);
    } else {
      if (_cariIslemIlkHali!.toplamTutar! != cariIslem.toplamTutar!) {
        return await dbutil.updateCariBakiye(
            cariKart.id!,
            _cariIslemIlkHali!.toplamTutar!,
            //güncelleme durumunda eski işlemin değeri iptal ediliyor
            (cariIslem.islemTuru == CariIslemTuru.satis)
                ? CariIslemTuru.alis
                : CariIslemTuru.satis);
      } else {
        return null;
      }
    } */