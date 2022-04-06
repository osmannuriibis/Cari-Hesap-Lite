import 'package:cari_hesapp_lite/models/user_model.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/sirket_model.dart';
import '../../../services/firebase/database/service/database_service.dart';
import '../../../services/firebase/database/utils/database_utils.dart';
import '../../../utils/catch.dart';
import '../../../utils/print.dart';

import 'package:flutter/material.dart';

class SirketAddViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  late bool isNewAdding;
  late SirketModel _sirket;

  var controllerUnvani = TextEditingController();
  var controllerTicariAdi = TextEditingController();
  var controllerTel = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerAdres = TextEditingController();
  var controllerSehir = TextEditingController();
  var controllerIlce = TextEditingController();
  var controllerVDairesi = TextEditingController();
  var controllerVNo = TextEditingController();

  SirketAddViewModel.addNew() {
    isNewAdding = true;
    _sirket = SirketModel();
  }
  SirketAddViewModel.showExist(this._sirket) {
    isNewAdding = false;

    controllerUnvani.text = _sirket.unvani ?? "";
    controllerTicariAdi.text = _sirket.ticariAdi ?? "";
    controllerTel.text = _sirket.tel ?? "";
    controllerEmail.text = _sirket.email ?? "";
    controllerAdres.text = _sirket.adres ?? "";
    controllerSehir.text = _sirket.sehir ?? "";
    controllerIlce.text = _sirket.ilce ?? "";
    controllerVDairesi.text = _sirket.vDairesi ?? "";
    controllerVNo.text = _sirket.vNo ?? "";
  }

  Future<String?> save() async {
    if (formKey.currentState!.validate()) {
      try {
        modeliHazirla();
        await modeliYaz();
        //sirket kurulumu ile oluşturulan ek alanlar
        if (isNewAdding) await ekAlanlar();
        return null;
      } on Exception catch (e) {
        return fetchCatch(e, this);
      }
    } else {
      return "validation";
    }
  }

  late String generatedSirketId;
  void modeliHazirla() {
    generatedSirketId = FirebaseFirestore.instance.collection("asd").doc().id;
    _sirket = _sirket.copyWith(
        adres: controllerAdres.text,
        email: controllerEmail.text,
        id: generatedSirketId,
        ilce: controllerIlce.text,
        sehir: controllerSehir.text,
        tel: controllerTel.text,
        ticariAdi: controllerTicariAdi.text,
        unvani: controllerUnvani.text,
        vDairesi: controllerVDairesi.text,
        vNo: controllerVNo.text);
  }

  Future<String?> modeliYaz() async {
    //user altı sirket collection'una sirketId atama
    DBUtils()
        .getModelReference<UserModel>(AuthService().currentUserId!)
        .collection(DBService().getClassColPath(SirketModel))
        .doc(generatedSirketId)
        .set({"id" : generatedSirketId}); 
    DBUtils()
        .getModelReference<SirketModel>(generatedSirketId)
        .collection(DBService().getClassColPath(UserModel))
        .doc(AuthService().currentUserId)
        .set({"id" : AuthService().currentUserId});
    


    return await DBUtils().addOrSetModel(_sirket);
  }

  Future<void> ekAlanlar() async {
    //Ana depo alanı oluşturma
  }
}
