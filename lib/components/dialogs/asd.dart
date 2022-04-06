/* 
import 'package:cari_takip/components/fsal/special_firebase_list.dart';
import 'package:cari_takip/models/bilgiler/bilgiler_util/masraf_util.dart';

import '../text_fields/base_bordered_text_field.dart';
import '../../utils/extensions.dart';
import '../../validator/validator.dart';

import 'package:flutter/material.dart';

import 'custom_alert_dialog.dart';

var anaMasrafEkleFormKey = GlobalKey<FormState>();
var controllerAnaMasrafEkle = TextEditingController();
var controllerAltMasrafAnaEkle = TextEditingController();
var controllerAltMasrafEkle = TextEditingController();

Future<MapEntry<String, String>?> showMasrafGrubuDialog(BuildContext context) {
  var refAnaMasraf = getAnaMasrafColRef();

  return showDialog<MapEntry<String, String>>(
    context: context,
    //  barrierDismissible: true,
    builder: (context) => CustomAlertDialog(
      title: "Masraf Grubu Seçiniz",
      content: SingleChildScrollView(
        child: Column(
          children: [
            MyFirestoreColList(
              shrinkWrap: true,
              query: refAnaMasraf,
              itemBuilder: (context, snapshot, index) {
                if (snapshot != null) {
                  Map Ana = snapshot.data();
                  var refAltMasraf = getAltMasrafColRef(snapshot.id);

                  return SingleChildScrollView(
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 5),
                      title: Text(
                        Ana['adi'],
                        style: TextStyle(fontSize: 16),
                      ),
                      children: [
                        MyFirestoreColList(
                          defaultChild: SizedBox.shrink(),
                          query: refAltMasraf,
                          shrinkWrap: true,
                          itemBuilder: (context, snapshot, index) {
                            if (snapshot != null) {
                              Map Alt = snapshot.data();

                              return ListTile(
                                title: Text(
                                  Alt['adi'] ?? "İsim yok",
                                  style: TextStyle(fontSize: 13),
                                ),
                                onTap: () {
                                  Navigator.pop(
                                      context,
                                      MapEntry(Ana['adi'] as String,
                                          Alt['adi'] as String));
                                },
                              );
                            } else
                              return SizedBox.shrink();
                          },
                        ),
                        ExpansionTile(
                          title: Text(
                            "${snapshot.data()['adi']}'e Ait Alt Masraf Kalemi Ekle",
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          children: [
                            BaseBorderedTextField(
                              labelText: "Alt masraf adi",
                              controller: controllerAltMasrafEkle,
                            ),
                            TextButton(
                              child: Text("Ekle"),
                              onPressed: () {
                                altMasrafGrubuEkle(snapshot.id.toString());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else
                  return ListTile(
                    title: Text("Veri Yok"),
                  );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: anaMasrafEkleFormKey,
              child: ExpansionTile(
                title: Text(
                  "Yeni Ana Masraf Grubu Ekle",
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                ),
                children: [
                  BaseBorderedTextField(
                    labelText: "Ana Masraf Adı",
                    validator: Validator().bosOlamaz,
                    controller: controllerAnaMasrafEkle,
                  ),
                  BaseBorderedTextField(
                    labelText: "Alt Masraf Adı",
                    validator: Validator().bosOlamaz,
                    controller: controllerAltMasrafAnaEkle,
                  ),
                  TextButton(
                    child: Text("Ekle"),
                    onPressed: () {
                      anaVeAltMasrafGrubuEkle();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> anaVeAltMasrafGrubuEkle() async {
  if (anaMasrafEkleFormKey.currentState!.validate()) {
    var anaId = await addOrSetAnaMasraf(
        controllerAnaMasrafEkle.text.trim().toCapitalize());

    addOrSetAltMasraf(
        anaId!, controllerAltMasrafAnaEkle.text.trim().toCapitalize());

    controllerAltMasrafAnaEkle.clear();
    controllerAnaMasrafEkle.clear();
  }
}

void altMasrafGrubuEkle(String anaMasrafId) {
  if (controllerAltMasrafEkle.text.isNotEmpty) {
    addOrSetAltMasraf(
        anaMasrafId, controllerAltMasrafAnaEkle.text.trim().toCapitalize());

    controllerAltMasrafEkle.clear();
  }
}
 */