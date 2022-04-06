
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../services/firebase/database/utils/database_utils.dart';
import '../../../../utils/print.dart';

import '../../../../models/bilgiler/bilgiler.dart';
import '../../../../models/kartlar/stok_kart.dart';
import '../../../../utils/barcode.dart';
import '../../../../utils/catch.dart';
import 'package:flutter/cupertino.dart';
import '../../../../utils/extensions.dart';

class StokAddViewModel extends ChangeNotifier {
  late StokKart stokKart;
  late bool isNewAdding;

  DBUtils dbutil = DBUtils();
  late String stokId;

  TextEditingController controllerStokAdi = TextEditingController();
  TextEditingController controllerKategori = TextEditingController();
  TextEditingController controllerBarkod = TextEditingController();
  TextEditingController controllerUrunKodu = TextEditingController();
  TextEditingController controllerBirim = TextEditingController();
  TextEditingController controllerKdvOrani = TextEditingController(text: "18");
  TextEditingController controllerAlisFiyat = TextEditingController();
  TextEditingController controllerSatisFiyat = TextEditingController();
  TextEditingController controllerAlisFiyatiKdvli = TextEditingController();
  TextEditingController controllerSatisFiyatiKdvli = TextEditingController();
  TextEditingController controllerKarOrani = TextEditingController();
  TextEditingController controllerAciklama = TextEditingController();

  TextEditingController controllerBirimEkle = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String uyariAltBasligi = "";


  bool _isStoklu = true;


  MapEntry<String, String>? selectedDepo;

  bool get isStoklu => _isStoklu;

  set isStoklu(bool value) {
    _isStoklu = value;
    notifyListeners();
  }


  StokAddViewModel.addNewStok() {
    isNewAdding = true;
    stokId = dbutil.getClassReference<StokKart>().doc().id;
    stokKart = StokKart(id: stokId);
  }

  StokAddViewModel.showExistStok({required this.stokKart}) {
    isNewAdding = false;
    stokId = stokKart.id!;
    controllerStokAdi.text = stokKart.adi ?? "";
   isStoklu = stokKart.stokTipi ?? true;
    controllerKategori.text = stokKart.kategori ?? "";
    controllerBarkod.text = stokKart.barkod ?? "";
    controllerUrunKodu.text = stokKart.urunKodu ?? "";

    controllerBirim.text = stokKart.birim ?? "";
    controllerKdvOrani.text = stokKart.kdv.toString();
    controllerAlisFiyat.text = stokKart.alisFiyati.toString();
    controllerSatisFiyat.text = stokKart.satisFiyati.toString();
    controllerAlisFiyatiKdvli.text =
        (((stokKart.alisFiyati ?? 0) * (stokKart.kdv ?? 0)) / 100).toString();
    controllerSatisFiyatiKdvli.text =
        (((stokKart.satisFiyati ?? 0) * (stokKart.kdv ?? 0)) / 100).toString();
    controllerKarOrani.text =
        ((stokKart.satisFiyati ?? 0) - (stokKart.alisFiyati ?? 0) - 1)
            .toString(); //TODO ?????
    controllerAciklama.text = stokKart.aciklama.toString();
  }

/////////////    \   /
/////////////     \ /
/////////////      V
///////////// Birim Field
/////////////      |
/////////////      |
/////////////      |
/////////////    \   /
/////////////     \ /
/////////////      V

  void addYeniBirim() {
    if (controllerBirimEkle.text.isNotEmpty) {
      String text = controllerBirimEkle.text;

      dbutil.getModelReference<Bilgiler>(Bilgiler.birimler).set(
          {text.trim().toCapitalize(): text.trim().toCapitalize()},
          SetOptions(merge: true)).whenComplete(() {
        controllerBirimEkle.text = "";
      });
    }
  }

  selectBirimFromList(MapEntry val) {

    controllerBirim.text = val.value.toString().toCapitalize();
  }

  deleteBirimFromList(MapEntry val) {
    dbutil
        .getModelReference<Bilgiler>(Bilgiler.birimler)
        .update({val.key: FieldValue.delete()});
  }

/////////////    \   /
/////////////     \ /
/////////////      V
///////////// Financal Field SetUp
/////////////      |
/////////////      |
/////////////      |
/////////////    \   /
/////////////     \ /
/////////////      V

  num get alis => double.tryParse(controllerAlisFiyat.text) ?? 0;
  num get satis => double.tryParse(controllerSatisFiyat.text) ?? 0;
  num get alisKdvli => double.tryParse(controllerAlisFiyatiKdvli.text) ?? 0;
  num get satisKdvli => double.tryParse(controllerSatisFiyatiKdvli.text) ?? 0;
  // num get karOrani => double.tryParse(controllerKarOrani.text);
  num get kdvOrani => double.tryParse(controllerKdvOrani.text) ?? 0;

  _setKarOrani() {
    if (satis >= 0 && alis > 0) {
      controllerKarOrani.text =
          '% ' + (((satis / alis) * 100) - 100).toStringAsFixed(1);
    }
  }

  onChangeAlisFiyat(String val) {
    controllerAlisFiyatiKdvli.text =
        (alis * ((kdvOrani + 100) / 100)).toStringAsFixed(2);

    _setKarOrani();
  }

  onChangeSatisFiyat(String val) {
    controllerSatisFiyatiKdvli.text =
        (satis * ((kdvOrani + 100) / 100)).toStringAsFixed(2);

    _setKarOrani();
  }

  onChangeAlisFiyatKdvli(String val) {
    controllerAlisFiyat.text =
        (alisKdvli / ((kdvOrani + 100) / 100)).toStringAsFixed(2);

    _setKarOrani();
  }

  onChangeSatisFiyatKdvli(String val) {
    controllerSatisFiyat.text =
        (satisKdvli / ((kdvOrani + 100) / 100)).toStringAsFixed(2);

    _setKarOrani();
  }

  Future<String?> saveStok() async {
    if (formKey.currentState!.validate()) {
      uyariAltBasligi = "";
      notifyListeners();
      try {
        _modeliHazirla();
        await _modeliYaz();


        return null;
      }on Exception catch (err) {
       return  fetchCatch(err, this);
        
      }
    } else {
      uyariAltBasligi = "*Girilmesi gereken zorunlu alanlar!";
      notifyListeners();
      return "validation err";
    }
  }

  void _modeliHazirla() {
    stokKart = stokKart.copyWith(
      
      aciklama: controllerAciklama.text.trim(),
      adi: controllerStokAdi.text.trim(),
      alisFiyati: alis,
      barkod: controllerBarkod.text.trim(),
      birim: controllerBirim.text.toCapitalize().trim(),
      kategori: controllerKategori.text.toCapitalize().trim(),
      kdv: kdvOrani.toInt(),
      satisFiyati: satis,
      stokTipi: isStoklu,
      urunKodu: controllerUrunKodu.text.trim().toCapitalize(),
      kayitTarihi: isNewAdding ? Timestamp.now() : null,
    );
  }

  Future<String?> _modeliYaz() async {
  
 return await dbutil.addOrSetModel(stokKart);

  }

  Future<String?> fetchBarcode() {
    return scanBarcode().then<String?>((value) {
      print(value);

      if (num.tryParse(value) != -1) {
        controllerBarkod.text = value;
        return null;
      } else {
        return "false";
      }
    });
  }




}
