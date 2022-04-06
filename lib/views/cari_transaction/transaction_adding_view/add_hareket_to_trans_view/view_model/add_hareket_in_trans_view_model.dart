import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/print.dart';

import '../../../../../models/fiyatlar.dart';
import '../../../../../utils/catch.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../enums/cari_islem_turu.dart';
import '../../../../../models/stok_hareket.dart';
import '../../../../../models/kartlar/stok_kart.dart';
import 'package:flutter/material.dart';

/* Bu  işlem sonunda oluşturulacak (yazılacak) veriler;
StokHareket,

*/

class AddHareketInTransViewModel extends ChangeNotifier {
//  AddCariTransactionViewModel viewModelAddCari;
  late DBUtils dbutil;

  StokKart stokKart;
  late bool isNewLine;
  bool isSiparis = false;
  late StokHareket stokHareket;
  late CariIslemTuru cariIslemTuru;
  late String cariIslemKodu;
  late CariKart cariKart;
  CariIslemModel? cariIslem;

  var controllerBirimFiyat = TextEditingController(text: "0.00");

  var controllerMiktar = TextEditingController(text: "0");
  var controllerTutar = TextEditingController(text: "0.00");
  var controllerIskontoOrani = TextEditingController(text: "0");
  var controllerIskontoTutar = TextEditingController(text: "0");
  var controllerKdvOran = TextEditingController(text: "0");
  var controllerKdvTutar = TextEditingController(text: "0");
  var controllerToplam = TextEditingController(text: "0");
  var controllerAciklama = TextEditingController();
  var controllerDepo = TextEditingController();

  var formKey = GlobalKey<FormState>();

  AddHareketInTransViewModel.newAdding(
      {required this.cariIslem,
      required this.stokKart,
      required this.cariKart,
      this.isSiparis = false}) {
    init();
    isNewLine = true;

    stokHareket = StokHareket();

    stokHareket.cariIslemTuru = cariIslemTuru = cariIslem!.islemTuru!;

    stokHareket.cariIslemKodu = cariIslemKodu = cariIslem!.islemKodu!;

    bas(getStokFiyatByIslemTuru(cariIslemTuru));
    // lastTransValue =>

    // if (stokKart != null) getBirimFiyatInitialText();
  }

  AddHareketInTransViewModel.showExistHareket({
    required this.stokKart,
    required this.stokHareket,
    required this.cariKart,
  }) {
    init();
    isNewLine = false;
    isSiparis = stokHareket.isSiparis!;
    cariIslemTuru = stokHareket.cariIslemTuru!;
    cariIslemKodu = stokHareket.cariIslemKodu!;
    setControllers();
  }
  init() {
    dbutil = DBUtils();
  }

  //view'da futureBuilder'dan çağırılıyor
  Future<num> getBirimFiyatInitialText() async {
    if (!isNewLine) return stokHareket.islemFiyati!;

    try {
      Map<String, dynamic>? map = await dbutil
          .getClassReference<Fiyatlar>()
          .where('cariId', isEqualTo: cariKart.id)
          .where('stokId', isEqualTo: stokKart.id)
          .get()
          .then<Map<String, dynamic>?>((value) {
        if (value.docs.isNotEmpty) {
          return value.docs.first.data();
        }
      });

      if (map != null) {
        var fiyatObject = Fiyatlar.fromMap(map);

        return fiyatObject.getIslemFiyatiByCariIslemTuru(cariIslemTuru)!;
      } else {
        /*   await dbutil
            .getClassReference<StokHareket>()
            .where("cariId", isEqualTo: cariKart.id)
            .where("cariIslemTuru",
                isEqualTo:
                    (cariIslemTuru == CariIslemTuru.satis) ? "Satış" : "Alış")
            .where('urunId', isEqualTo: stokKart.id).
      
            get()
            .then((value) {
          
      
      
        }); */

        return getStokFiyatByIslemTuru(cariIslemTuru);
      }
    } on Exception catch (e) {
      fetchCatch(e, this);
      return getStokFiyatByIslemTuru(cariIslemTuru);
    }
  }

  ///////////
  ///////////SET FIELDS
  ///////////    |
  ///////////    |
  ///////////    |
  ///////////   \ /
  ///////////    V

//ilk kdv ataması...
  void setKdvOrani() {
    controllerKdvOran.text = stokKart.kdv.toString();
  }

  setTumAlanlar() {
    setTutar();

    setKdvTutar();
    setToplam();
  }

  void setTutar() {
    num val1, val2;
    val1 = birimFiyat;
    val2 = miktar;

    num value = (val1 * val2);
    // controllerTutar.text = value;

    controllerTutar.text = value.toStringAsFixed(2);
  }

  void setIskontoOran() {
    controllerIskontoOrani.text =
        ((iskontoTutar / tutar) * 100).toStringAsFixed(2);
  }

  void setIskontoTutar() {
    controllerIskontoTutar.text =
        (tutar * iskontoOran / 100).toStringAsFixed(2);
  }

  void setKdvTutar() {
    controllerKdvTutar.text =
        ((((tutar - iskontoTutar) * (kdvOran.toDouble())) / 100)).toString();
  }

  void setToplam() {
    controllerToplam.text =
        (tutar - iskontoTutar + kdvTutar).toStringAsFixed(2);
  }

  num getStokFiyatByIslemTuru(CariIslemTuru cariIslemTuru) {
    if (cariIslemTuru == CariIslemTuru.satis) {
      return stokKart.satisFiyati!;
    } else if (cariIslemTuru == CariIslemTuru.alis) {
      return stokKart.alisFiyati!;
    }
    throw Exception("cariIslemTuru değeri girilmemiş");
  }

  ///////////
  ///////////FOCUS EVENTS
  ///////////    |
  ///////////    |
  ///////////    |
  ///////////   \ /
  ///////////    V
  final _focusNodeFiyat = FocusNode();
  final _focusNodeMiktar = FocusNode();
  final _focusNodeKdvOran = FocusNode();
  final _focusNodeIskontoOran = FocusNode();
  final _focusNodeIskontoTutar = FocusNode();

  FocusNode get focusNodeFiyat => _focusNodeFiyat;
  FocusNode get focusNodeMiktar => _focusNodeMiktar;
  FocusNode get focusNodeKdvOran => _focusNodeKdvOran;
  FocusNode get focusNodeIskontoOran => _focusNodeIskontoOran;
  FocusNode get focusNodeIskontoTutar => _focusNodeIskontoTutar;

  addFocusListener(FocusNode focusNode) {
    focusNode.addListener(() {
      setTumAlanlar();
    });
  }

  num get birimFiyat => (controllerBirimFiyat.text != "")
      ? double.tryParse(controllerBirimFiyat.text) ?? 0
      : 0;

  num get miktar => (controllerMiktar.text != "")
      ? double.tryParse(controllerMiktar.text) ?? 0
      : 0;
  get tutar => (controllerTutar.text != "")
      ? double.tryParse(controllerTutar.text) ?? 0
      : 0;

  num get iskontoOran => (controllerIskontoOrani.text != "")
      ? double.tryParse(controllerIskontoOrani.text) ?? 0
      : 0;

  num get iskontoTutar => (controllerIskontoTutar.text != "")
      ? double.tryParse(controllerIskontoTutar.text) ?? 0
      : 0;

  /* set iskontoTutar(num value) => value;
 */
  get kdvOran => (controllerKdvOran.text.isNotEmptyOrNull)
      ? int.tryParse(controllerKdvOran.text)!
      : 0;

  num get kdvTutar => (controllerKdvTutar.text.isNotEmptyOrNull)
      ? double.tryParse(controllerKdvTutar.text)!
      : 0;

  num get toplam => (controllerToplam.text.isNotEmptyOrNull)
      ? double.tryParse(controllerToplam.text)!
      : 0;

  ///////////
  /////////// onChange's
  ///////////    |
  ///////////    |
  ///////////    |
  ///////////   \ /
  ///////////    V

  void onChange(String? typed) {
    if (formKey.currentState!.validate()) {
      setTumAlanlar();
    }
  }

  onChangeIskontoTutar(String? value) {
    setIskontoOran();
  }

  onChangeIskontoOran(String? value) {
    setIskontoTutar();
  }

  ///////////
  /////////// ONSAVED
  ///////////    |
  ///////////    |
  ///////////    |
  ///////////   \ /
  ///////////    V

//son kayıt butonu

  Future<String?> save() async {
  

    if (formKey.currentState!.validate()) {
      try {
        stokHareket = stokHareket.copyWith(
          isSiparis: isSiparis,
          cariIslemTuru: cariIslemTuru,
          cariId: cariKart.id,
          cariAdi: cariKart.unvani,
          urunId: stokKart.id,
          urunAdi: stokKart.adi,
          islemFiyati: birimFiyat,
          miktar: miktar,
          islemTarihi: cariIslem?.islemTarihi ?? stokHareket.islemTarihi,
          tutar: tutar,
          iskontoOrani: iskontoOran,
          iskontoTutar: iskontoTutar,
          netTutar: tutar - iskontoTutar,
          kdvOran: kdvOran,
          kdvTutar: kdvTutar,
          toplamTutar: toplam,
        );
      } on Exception catch (e) {
        // fetchCatch(this, e);
        
        return fetchCatch(e, this);
      } finally {}
    } else {
      return "validation err";
    }
  }

  void setControllers() {
    controllerBirimFiyat =
        TextEditingController(text: stokHareket.islemFiyati.toString());

    controllerMiktar.text = stokHareket.miktar.toString();
    controllerTutar.text = stokHareket.tutar.toString();
    controllerIskontoOrani.text = stokHareket.iskontoOrani.toString();
    controllerIskontoTutar.text = stokHareket.iskontoTutar.toString();
    controllerKdvOran.text = stokHareket.kdvOran.toString();
    controllerKdvTutar.text = stokHareket.kdvTutar.toString();
    controllerToplam.text = stokHareket.toplamTutar.toString();
    //setTumAlanlar();
  }
}
