import 'package:cari_hesapp_lite/utils/catch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../enums/cari_turu.dart';
import '../../../../models/bilgiler/bilgiler.dart';
import '../../../../models/kartlar/cari_kart.dart';
import '../../../../models/konum.dart';
import '../../../../services/firebase/database/service/database_service.dart';
import '../../../../services/firebase/database/utils/database_utils.dart';
import '../../../../utils/extensions.dart';
import '../../../../utils/konum_service/konum_service.dart';
import '../../../../utils/place_picker_package/lib/entities/entities.dart';
import '../../../../utils/print.dart';

class CariAddViewModel extends ChangeNotifier {
  // ignore: unused_field
  late CariKart _cariKart;
  late bool isNewAdding;

  DBUtils dbutil = DBUtils();

  bool _isSwitchDisable = true;

  bool borclu = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var controllerCariGrupDialog = TextEditingController();

  var konumService = KonumService();

  Konum? _konum;

  Konum get konum =>
      _konum ?? Konum.fromPosition(konumService.lastLocation);

  set konum(Konum value) => _konum = value;

  // var controllerCariGrup = TextEditingController();

////////////////////////////////////////////
////////////////CONTROLLERS/////////////////
  TextEditingController controllerUnvani = TextEditingController();
  //TextEditingController controllerCariTuru;
  TextEditingController controllerCariGrup = TextEditingController();
  TextEditingController controllerSemtBilgisi = TextEditingController();
  TextEditingController controllerTelefon = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerAdres = TextEditingController();
  TextEditingController controllerSehir = TextEditingController();
  TextEditingController controllerIlce = TextEditingController();
  TextEditingController controllerBakiye = TextEditingController();
  TextEditingController controllerVDairesi = TextEditingController();
  TextEditingController controllerVNo = TextEditingController();
  TextEditingController controllerSiniflandirma = TextEditingController();
  TextEditingController controllerRiskLimiti = TextEditingController();
  TextEditingController controllerUyariMesaji = TextEditingController();
  TextEditingController controllerAciklama = TextEditingController();
  TextEditingController controllerParaBirimi = TextEditingController();

////////////////////////////////////////////
////////////////DATABASE_SERVICES///////////

  late CariTuru _cariTuru;

  set cariTuru(CariTuru tur) {
    _cariTuru = tur;
    notifyListeners();
  }

  CariTuru get cariTuru => _cariTuru;
  TextEditingController get controllerCariTuru =>
      TextEditingController(text: _cariTuru.stringValue);

  int _initialIndex = 0;
  int get initialIndex => _initialIndex;
  set initialIndex(int index) {
    _initialIndex = index;
    notifyListeners();
  }

  CariAddViewModel.addNewCari(this._cariTuru) {
    isNewAdding = true;
    _cariKart = CariKart();

    init();
    setControllers(isNewAdding: isNewAdding);
  }

  CariAddViewModel.showExistCari(
    CariKart model,
  ) {
    isNewAdding = false;
    _cariTuru = model.cariTuru!;
    _cariKart = model;
    setControllers(cariKart: model, isNewAdding: isNewAdding);
  }

/////////////        \ /
/////////////         V
/////////////    Set İl İlçe
/////////////         |
/////////////         |
/////////////        \ /
/////////////         V
  void setSehir(Map<String, String>? value) {
    if (value != null) {
      if (value.isNotEmpty) //listeden seçim
      {
        controllerSehir.text = value['name']!;
        controllerIlce.text = "";
        readOnlyIlce = true;
        readOnlySehir = true;
        selectedSehirId = value['id']!;
        notifyListeners();
      } else //elle yazım
      {
        controllerSehir.text = "";

        readOnlyIlce = false;
        readOnlySehir = false;
        selectedSehirId = "";
        notifyListeners();
      }
    }
  }

  setIlce(Map<String, String>? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        readOnlyIlce = true;
        controllerIlce.text = value['name']!;
        notifyListeners();
      } else {
        readOnlyIlce = false;
        controllerIlce.text = "";
        notifyListeners();
      }
    }
  }

  String selectedSehirId = "";

  bool readOnlyIlce = true;
  bool readOnlySehir = true;

/////////////       \   /
/////////////        \ /
/////////////         V
/////////////BAKIYE & DISABLE FILED
/////////////         |
/////////////         |
/////////////         |
/////////////       \   /
/////////////        \ /
/////////////         V
  void bakiyeOnChanced(String? value) {
    isSwitchDisable = (value != null)
        ? ((value != "")
            ? (num.tryParse(value) != 0)
                ? false
                : true
            : true)
        : true;
  }

  set isSwitchDisable(bool val) {
    _isSwitchDisable = val;
    notifyListeners();
  }

  bool get isSwitchDisable {
    return _isSwitchDisable;
  }

//////////////////////////////////
//////////////////////////////////
  CariKart get cariKart => _cariKart;

  set cariKart(CariKart model) {
    _cariKart = model;
  }

  void setControllers({CariKart? cariKart, required bool isNewAdding}) {
    controllerUnvani = TextEditingController(text: cariKart?.unvani ?? "");

    controllerCariGrup = TextEditingController(text: cariKart?.cariGrup ?? "");
    controllerSemtBilgisi =
        TextEditingController(text: cariKart?.ekBilgi ?? "");
    controllerTelefon =
        TextEditingController(text: cariKart?.telNo!.first.toString() ?? "");
    controllerEmail = TextEditingController(text: cariKart?.email ?? "");
    controllerAdres = TextEditingController(text: cariKart?.adres ?? "");
    controllerSehir = TextEditingController(text: cariKart?.sehir ?? "");
    controllerIlce = TextEditingController(text: cariKart?.ilce ?? "");
    controllerBakiye = TextEditingController(
        text: isNewAdding ? "" : cariKart!.bakiye!.toStringAsFixed(2));
    controllerVDairesi =
        TextEditingController(text: cariKart?.vergiDairesi ?? "");
    controllerVNo = TextEditingController(text: cariKart?.vergiNo ?? "");
    controllerSiniflandirma =
        TextEditingController(text: cariKart?.siniflandirma ?? "");
    controllerRiskLimiti = TextEditingController(
        text:
            isNewAdding ? "" : cariKart!.riskLimiti?.toStringAsFixed(2) ?? "");
    controllerUyariMesaji =
        TextEditingController(text: cariKart?.uyariMesaji ?? "");
    controllerAciklama = TextEditingController(text: cariKart?.aciklama ?? "");

    /*  controllerParaBirimi = TextEditingController(
        text: isNewAdding ? "TRY" : cariKart.paraBirimi.getParaBirimiAdi); */
  }

/////////////       \   /
/////////////        \ /
/////////////         V
///////////// CariGrup Select Field
/////////////         |
/////////////         |
/////////////         |
/////////////       \   /
/////////////        \ /
/////////////         V
  void deleteCariGrupFromList(MapEntry mapEntry) {
    var text = mapEntry.key.toString();

    dbutil
        .getClassReference<Bilgiler>()
        .doc(Bilgiler.cariGrup)
        .update({text: FieldValue.delete()});
  }

  void selectCariGrupFromList(MapEntry mapEntry) {
    controllerCariGrup.text = mapEntry.key.toString().trim().toCapitalize();
  }

  Future<bool> addCariGrup() async {
    if (controllerCariGrupDialog.text.trim().isNotEmpty) {
      var text = controllerCariGrupDialog.text.trim().toCapitalize();
      var doc = dbutil.getModelReference<Bilgiler>(Bilgiler.cariGrup);
      return await doc
          .set({text: text}, SetOptions(merge: true)).then<bool>((value) {
        controllerCariGrupDialog.text = "";
        return true;
      }).onError((error, stackTrace) {
        return false;
      });

/*       try { */
      //  updateModel<Bilgiler>({text: text}, Bilgiler.cariGrup);
      /* } catch (err) {
        fetchCatch(this, err);
      } */

    } else {
      return false;
    }
  }

/////////////       \   /
/////////////        \ /
/////////////         V
/////////////       SAVE
/////////////         |
/////////////         |
/////////////         |
/////////////       \   /
/////////////        \ /
/////////////         V

  Future<String?> save() async {
    if (formKey.currentState!.validate() && controllerUnvani.text.length > 3) {
      modeliHazirla();

      return await modeliYaz();
    } else {
      return "validation";
    }
  }

  String? modeliHazirla() {
    try {
      cariKart = cariKart.copyWith(
        aciklama: controllerAciklama.text.trim(),
        adres: controllerAdres.text.trim(),
        bakiye: num.tryParse(controllerBakiye.text.trim() != ""
                ? controllerBakiye.text
                : "0") ??
            0,
        cariGrup: controllerCariGrup.text.trim(),
        cariTuru: controllerCariTuru.text.trim().toCariTuru,
        ekBilgi: controllerSemtBilgisi.text.trim(),
        email: controllerEmail.text.trim(),
        ilce: controllerIlce.text.trim(),
        kayitTarihi: (isNewAdding) ? Timestamp.now() : null,
        riskLimiti: num.tryParse(controllerRiskLimiti.text.trim()),
        sehir: controllerSehir.text.trim(),
        siniflandirma: controllerSiniflandirma.text.trim(),
        telNo: [controllerTelefon.text.trim()],
        unvani: controllerUnvani.text.trim(),
        konum: konum,
        uyariMesaji: controllerUyariMesaji.text.trim(),
        vergiDairesi: controllerVDairesi.text.trim(),
        vergiNo: controllerVNo.text.trim(),
      );
    } on Exception catch (e) {
      return fetchCatch(e, this);
    }
  }

  Future<String?> modeliYaz() async {
    return await dbutil.addOrSetModel(cariKart).getBoolResultForFirebase();
  }

  void init() {

    if (KonumService().lastLocation != null) {
      konum = Konum.fromPosition(KonumService().lastLocation);
    }
  }

  void setKonumAyarlari(LocationResult? value) {
    if (value == null) return;
    controllerAdres.text = value.formattedAddress ?? "";
    controllerSehir.text = value.city?.name?.toUpperCase() ?? "";
    controllerIlce.text =
        value.administrativeAreaLevel2?.name?.toUpperCase() ?? "";
    konum = Konum.fromLatLng(value.latLng, isCertain: true);
  }

  notify() =>
    notifyListeners();
  
}
