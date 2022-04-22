import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/enums/hesap_hareket_turu.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../components/appbar/my_app_bar.dart';
import '../../../components/buttons/base_primary_button.dart';
import '../../../components/text_fields/base_form_field.dart';
import '../../../constants/constants.dart';
import '../../../enums/gelir_gider_turu.dart';
import '../../../models/kartlar/cari_kart.dart';
import '../../../utils/date_format.dart';
import '../../../utils/general.dart';
import '../../../utils/num_input_formatter.dart';
import 'account_transaction_add_view_model.dart';

// ignore: must_be_immutable
class AccountTransactionAddView extends StatelessWidget {
  late BuildContext context;
  late AccountTransactionAddViewModel viewModel;
  late AccountTransactionAddViewModel viewModelUnlistened;

  AccountTransactionAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    this.context = context;
    viewModel = Provider.of(context);
    viewModelUnlistened = Provider.of(context, listen: false);

    return Scaffold(
      appBar: MyAppBar(
        titleText: (viewModel.gelirGiderTuru == GelirGiderTuru.gelir
            ? "Tahsilat"
            : "Ödeme Yap"),
        /*   actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          )
        ], */
      ),
      body: Form(
        key: viewModel.formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              AbsorbPointer(
                absorbing: !viewModel.isAllowedAdjust,
                child: Column(
                  children: [
                    _buildNameAndBalanceRow(viewModel.cariKart!),
                    _buildHesapAdiAlani(context),
                    _buildEvrakFields(),
                    _buildTutar(),
                    const Divider(),
                  ],
                ),
              ),
              //_buildAdditionalFields(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: MyBaseButton(
                      onSurface: viewModel.isAllowedAdjust
                          ? kPrimaryColor
                          : Colors.blue,
                      buttonText:
                          viewModel.isAllowedAdjust ? "Kaydet" : "Düzenle",
                      onPressed: viewModel.isAllowedAdjust
                          ? () {
                              save();
                            }
                          : () {
                              viewModel.isAllowedAdjust =
                                  !viewModel.isAllowedAdjust;
                            },
                    ),
                  ),
                  if (!viewModel.isAllowedAdjust)
                    MyBaseButton(
                      onSurface: Colors.red,
                      buttonText: "Sil",
                      onPressed: () {
                        // TODO viewModel.bakiyeleriGuncelle(reverse: true);
                      },
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutar() {
    return SizedBox(
      // color: Colors.amber[100],
      width: width(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Son İşlem"),
                    TextButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            (viewModel.sonCariIslem != null)
                                ? (viewModel.sonCariIslem!.toplam ?? 0)
                                    .toStringAsFixed(2)
                                : "0.00",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                      onPressed: (viewModel.sonCariIslem != null)
                          ? () {
                              viewModel.controllerTutar.text = viewModel
                                  .sonCariIslem!.toplamTutar
                                  .toString();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Bakiye"),
                    TextButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            (viewModel.gelirGiderTuru == GelirGiderTuru.gelir)
                                ? ((viewModel.cariKart!.bakiye ?? 0) >= 0)
                                    ? (viewModel.cariKart!.bakiye ?? 0)
                                        .toStringAsFixed(2)
                                    : "0"
                                : ((viewModel.cariKart!.bakiye ?? 0) < 0)
                                    ? (viewModel.cariKart!.bakiye ?? 0)
                                        .toStringAsFixed(2)
                                    : 0.toString(),
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.clip,
                          ),
                          const Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                      onPressed:
                          viewModel.gelirGiderTuru == GelirGiderTuru.gelir
                              ? (((viewModel.cariKart!.bakiye ?? 0) > 0)
                                  ? () {
                                      viewModelUnlistened.controllerTutar.text =
                                          viewModel.cariKart!.bakiye.toString();
                                    }
                                  : null)
                              : (((viewModel.cariKart!.bakiye ?? 0) < 0)
                                  ? () {
                                      viewModelUnlistened.controllerTutar.text =
                                          viewModel.cariKart!.bakiye.toString();
                                    }
                                  : null),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: _MyTextFormField(
                  controller: viewModel.controllerTutar,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    DecimalTextInputFormatter(),
                  ],
                  onTap: () {
                    selectTextInField(viewModelUnlistened.controllerTutar);
                  },
                  labelText: "Tutar",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildHesapAdiAlani(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((viewModel.gelirGiderTuru == GelirGiderTuru.gelir
                  ? "Tahsilat"
                  : "Ödeme") +
              " Türü: "),
          ElevatedButton(
            child: Text(viewModel.hesapHareketTuru.stringValue),
            onPressed: () {
              showAlertDialog(
                context,
                content: MyColumn(
                  children: [
                    for (var item in HesapHareketTuru.values)
                      ListTile(
                        title: Text(item.stringValue),
                        onTap: () {
                          viewModel.hesapHareketTuru = item;
                          Navigator.pop(context);
                        },
                      )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNameAndBalanceRow(CariKart cariKart) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(4),
          side: const BorderSide(width: 1, color: Colors.black87)),
      semanticContainer: false,
      shadowColor: Colors.amber,
      elevation: 10,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                (cariKart.unvani != null) ? cariKart.unvani! : "Yükleniyor..."),
            Text(
                "Bakiye :${(cariKart.bakiye != null) ? (cariKart.bakiye ?? 0).toStringAsFixed(2) : "Yükleniyor..."} ₺")
          ],
        ),
      ),
    );
  }

  Widget _buildEvrakFields() {
    return SizedBox(
      // color: Colors.amber[100],
      width: width(context),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _MyTextFormField(
                    controller: viewModel.controllerBelgeNo,
                    labelText: "Belge No",
                    hintText: "A1120",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _MyTextFormField(
                    controller: viewModel.controllerIslemTarihi,
                    labelText: "İşlem Tarihi",
                    readOnly: true,
                    onTap: () {
                      _showDateDialog(context, viewModel.controllerIslemTarihi);
                    },
                  ),
                ),
              ],
            ),
            _MyTextFormField(
              controller: viewModel.controllerAciklama,
              onChanged: (value) {
                //_controller.value = value;
              },
              labelText: "Açıklama",
            )
          ],
        ),
      ),
    );
  }

  String _showDateDialog(BuildContext context, TextEditingController value) {
  
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 300)),
      firstDate: DateTime.now().subtract(const Duration(days: 3000)),
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((selectedDate) {
      if (selectedDate != null) {
        value.text = dateFormatterToString(Timestamp.fromDate(selectedDate));
      }
    });

    return  "";

    ///TODO: Problem's here, solve it!
  }

  void save() {
    viewModel.save().showSaveSnackBar(context);
    /**/
  }
}

class _MyTextFormField extends StatelessWidget {
  final String? initialText, labelText, hintText;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const _MyTextFormField(
      {Key? key,
      this.initialText,
      this.labelText,
      this.hintText,
      this.readOnly = false,
      this.onTap,
      this.controller,
      this.onChanged,
      this.textAlign = TextAlign.left,
      this.keyboardType,
      this.inputFormatters})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      initialValue: initialText,
      onChanged: onChanged,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly,
      key: key,
    );
  }
}
