import 'package:cari_hesapp_lite/components/dialogs/custom_alert_dialog.dart';
import 'package:cari_hesapp_lite/utils/dialogs/dialogs.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/views/stok/stok_view/stok_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../components/appbar/my_app_bar.dart';
import '../../components/buttons/base_primary_button.dart';
import '../../components/card/custom_card.dart';
import '../../components/scroll_column.dart';
import '../../components/snack_bar.dart/snack_bar.dart';
import '../../components/text_fields/base_form_field.dart';
import '../../components/text_fields/my_field_with_label.dart';
import '../../enums/cari_islem_turu.dart';
import '../../models/kartlar/stok_kart.dart';
import '../../utils/view_route_util.dart';
import '../../views/stok/stok_list_view/stok_liste_view.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import 'siparis_add_view_model.dart';

class SiparisAddView extends StatelessWidget {
  SiparisAddView({Key? key}) : super(key: key);

  late SiparisAddViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<SiparisAddViewModel>(context);

    var list = viewModel.siparis.siparisKalemleri;

    return Scaffold(
      appBar: MyAppBar(
        titleText: (viewModel.cariIslemTuru == CariIslemTuru.satis
                ? "Satış"
                : "Alış") +
            " Siparis",
      ),
      body: MyColumn(
        children: [
          MyCard(
            child: Text(
              viewModel.cariKart.unvani ?? "",
              style: context.textTheme.headline6,
            ),
          ),
          _AddKalemItem(
              controller1: viewModel.controllerAdi,
              controller2: viewModel.controllerMiktari,
              suffixText: viewModel.birim,
              onTap1: () async {
                var stokKart = await goToView<StokKart, StokViewModel>(context,
                    viewToGo: const StokListView());
                if (stokKart != null) {
                  viewModel.selectStok(stokKart);
                }
              },
              readOnly2: (viewModel.kalemModel.urunId == null),
              keyboardType: TextInputType.number),
          OutlinedButton(
              onPressed: () {
                if (viewModel.controllerAdi.text.isEmptyOrNull ||
                    viewModel.controllerMiktari.text.isEmptyOrNull) {
                  showSnackBar(
                      context: context, message: "Alanları doldurunuz");
                } else {
                  viewModel.addItem();
                }
              },
              child: const Text("Sipariş Kalemini Ekle")),
          MyCard(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 500),
              child: MyColumn(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text("Siparis Kalemleri"),
                  ),
                  if (list.isEmpty)
                    const Text("Veri yok")
                  else
                    for (var i = 0; i < list.length; i++)
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              list[i].urunAdi ?? "",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    (list[i].urunMiktari ?? 0).toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    list[i].birim ?? "",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              )),
                          IconButton(
                              padding: const EdgeInsets.all(15),
                              onPressed: () {
                                viewModel.deleteItem(i);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                        ],
                      ),
                ],
              ),
            ),
          ),
          const Divider(),
          EachRowField(
            textLabel: "Siparis Tarihi",
            controller: viewModel.controllerTarih,
            readOnly: true,
            onTap: () async {
              var date = await showDateDialog(context);
              if (date != null) {
                viewModel.tarih = Timestamp.fromDate(date);
              }
            },
            fieldRatio: 10,
          ),
          BaseFormField(
            controller: viewModel.controllerAciklama,
            labelText: "Açıklama",
            
          ),

          // TODO EachRowField(textLabel: "Personel")
          MyBaseButton(
              onPressed: () async {
                bool? result = true;
                if (viewModel.siparis.siparisKalemleri.isEmpty) {
                  result = await showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: "Uyarı",
                      content: const Text(
                          "Siparişe Kalem eklemediniz\nDevam etmek istiyor musunuz?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Kaydet")),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              "Vazgeç",
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    ),
                  );
                }
                if (result != null && result) {
                  viewModel.save().showSaveSnackBar(
                        context,
                      );
                }
              },
              buttonText: "Siparisi Kaydet"),
          /*    TextButton(
              onPressed: () {
                viewModel.testText = "ad";
                viewModel.notify();
              },
              child: Text("notify")) */
        ],
      ),
    );
  }
}

class _AddKalemItem extends StatelessWidget {
  final String? initialText1, initialText2, hintText1, hintText2;

  final TextEditingController? controller1, controller2;

  final bool readOnly1, readOnly2;

  final String? suffixText;
  final VoidCallback? onTap1, onTap2, onPressed;
  final Widget? icon;
  final TextInputType? keyboardType;

  const _AddKalemItem({
    Key? key,
    this.initialText2,
    this.controller2,
    this.readOnly2 = true,
    this.suffixText,
    this.initialText1,
    this.controller1,
    this.readOnly1 = true,
    this.onTap1,
    this.onTap2,
    this.onPressed,
    this.icon,
    this.keyboardType,
    this.hintText1,
    this.hintText2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 4,
              child: BaseFormField(
                icon: icon,
                hintText: "Ürün seçiniz",
                initialValue: initialText1,
                controller: controller1,
                readOnly: readOnly1,
                onTap: onTap1,
              )),
          Expanded(
              flex: 4,
              child: BaseFormField(
                keyboardType: keyboardType,
                initialValue: initialText2,
                hintText: "Miktar giriniz",
                controller: controller2,
                readOnly: readOnly2,
                onTap: onTap2,
                suffixText: suffixText,
              )),
          /*     IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.check,
              color: Colors.green,
              size: 30,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ) */
        ],
      ),
    );
  }
}
