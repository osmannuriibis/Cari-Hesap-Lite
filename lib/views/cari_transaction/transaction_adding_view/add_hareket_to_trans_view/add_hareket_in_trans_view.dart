import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/components/text_fields/my_field_with_label.dart';
import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';

import '../../../../components/buttons/base_primary_button.dart';
import '../../../../components/text_fields/base_form_field.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/general.dart';
import '../../../../utils/validator.dart';
import 'view_model/add_hareket_in_trans_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddHareketInTransView extends StatelessWidget with Validator {
  late AddHareketInTransViewModel _viewModel;

  AddHareketInTransView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _viewModelUnlistened =
        Provider.of<AddHareketInTransViewModel>(context, listen: false);

    _viewModel = Provider.of<AddHareketInTransViewModel>(context);

    _viewModel.setKdvOrani();

    _viewModelUnlistened
        .addFocusListener(_viewModelUnlistened.focusNodeIskontoOran);
    _viewModelUnlistened
        .addFocusListener(_viewModelUnlistened.focusNodeIskontoTutar);
    return Scaffold(
      appBar: MyAppBar(
        titleText: "${_viewModel.stokKart.adi ?? "nullGeldi"} Ekle",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: MyColumn(
        isSeperator: false,
        children: [
          /*   Divider(),
          WrapCards(
            children: [
              Text("${_viewModel.stokKart.adi}   ",
                  style: TextStyle(fontSize: 17)),
            ],
            direction: Axis.horizontal,
          ),
          Divider(), */
          Form(
            key: _viewModel.formKey,
            child: Column(
              children: [
                _EachRowBirimFiyat(
                  //future builder'dan dolayı ayılırdı
                  viewModelUnlistened: _viewModelUnlistened,
                  viewModel: _viewModel,
                  focusNodeFiyat: _viewModel.focusNodeFiyat,
                ),
                EachRowField(
                  controller: _viewModelUnlistened.controllerMiktar,
                  textLabel: "Miktar",
                  suffixText: _viewModel.stokKart.birim,
                  onChange: _viewModelUnlistened.onChange,
                  onTap: () {
                    selectTextInField(_viewModelUnlistened.controllerMiktar);
                  },
                  focusNode: _viewModel.focusNodeMiktar,
                ),
                EachRowField(
                  absorbing: true,
                  controller: _viewModel.controllerTutar,
                  textLabel: "Tutar",
                  suffixText: "₺",
                  onSaved: (String? typed) {},
                  readOnly: true,
                ),
                EachRowField(
                  controller: _viewModel.controllerIskontoOrani,
                  textLabel: "İskonto",
                  onChange: _viewModelUnlistened.onChangeIskontoOran,
                  focusNode: _viewModel.focusNodeIskontoOran,
                  suffixText: "%",
                  onTap: () {
                    selectTextInField(_viewModel.controllerIskontoOrani);
                  },
                  validator: kdvValidator,
                ),
                EachRowField(
                  controller: _viewModel.controllerIskontoTutar,
                  textLabel: "İskonto Tutar",
                  onChange: _viewModelUnlistened.onChangeIskontoTutar,
                  suffixText: "₺",
                  onTap: () {
                    selectTextInField(_viewModel.controllerIskontoTutar);
                  },
                ),
                _EachRowOnlyKdv(
                    controller: _viewModel.controllerKdvOran,
                    textLabel: "KDV Oranı",
                    onChange: _viewModelUnlistened.onChange,
                    focusNode: _viewModel.focusNodeKdvOran,
                    suffixText: "%",
                    onTap: () {
                      selectTextInField(_viewModelUnlistened.controllerKdvOran);
                    }),
                EachRowField(
                  controller: _viewModel.controllerKdvTutar,
                  absorbing: true,
                  textLabel: "KDV Tutar",
                  suffixText: "₺",
                  readOnly: true,
                ),
                EachRowField(
                  controller: _viewModel.controllerToplam,
                  absorbing: true,
                  textLabel: "Toplam",
                  suffixText: "₺",
                  readOnly: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: BaseFormField(
                    labelText: "Açıklama",
                    hintText: "Bu satır işlemi ilgili bir açıklama..",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: MyBaseButton(
                      buttonText: "KAYDET",
                      onPressed: () {
                        _viewModel.save().then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text((value != null)
                                  ? ("Bir Sorun Oluştu: $value \n")
                                  : "Ürün Eklendi"),
                            ),
                          );
                          if (value == null) {
                            Navigator.pop(
                                context, _viewModelUnlistened.stokHareket);
                          }
                        });
                      }),
                ),
                /**/
              ],
            ),
          )
        ],
      ),
    );
  }

  /*  String firebaseSorguMetodu() {
    String cariId = "-MO8W2P6-MPBceN8Owcz",
        stokId = "-MO8VjuporPgNdOtA9JA",
        id = "123456789";
    DatabaseService<Fiyatlar>().getClassReference().child(id).set(
          Fiyatlar(
                  id: id, stokId: stokId, alis: 9.90, satis: 12, cariId: cariId)
              .toMap(),
        );

    var ref = getClassReference<Fiyatlar>()
        .orderByChild('id')
        .equalTo(id)
        .reference();

    print("ref key: " + ref.key);
    ref.orderByChild("stokId").equalTo(stokId).once().then((snapshot) {
      Map map2 = snapshot.value;

      print("key: " + map2.keys.last.toString());

      print("----------------------");
      var deger = snapshot; //.value[id];
      print('map type: ' + deger.runtimeType.toString());

      print("value:   " + snapshot.value.toString());
      var map = snapshot.value[id];
      print(map);
      print("snapshot id:   " + snapshot.value[id]['id']);
      print("snapshot id:   " + snapshot.key);
      print("snapshot id:   " + snapshot.runtimeType.toString());
      print("snapshot id:   " + snapshot.toString());

      // print(Fiyatlar.fromJson(value.value).toString() + "***************");
      // Map<String, dynamic> map = Map.from(value.value)[id];

      //  print(map);

      print(Fiyatlar.fromMap(snapshot.value[id]).toString());
    });

    return " data ------";
  }*/
}

class _EachRowBirimFiyat extends StatelessWidget {
  const _EachRowBirimFiyat({
    Key? key,
    required AddHareketInTransViewModel viewModelUnlistened,
    required AddHareketInTransViewModel viewModel,
    required FocusNode focusNodeFiyat,
  })  : _viewModelUnlistened = viewModelUnlistened,
        _viewModel = viewModel,
        _focusNodeFiyat = focusNodeFiyat,
        super(key: key);

  final AddHareketInTransViewModel _viewModelUnlistened;
  final AddHareketInTransViewModel _viewModel;
  final FocusNode _focusNodeFiyat;

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<num>(
        future: _viewModelUnlistened.getBirimFiyatInitialText(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              _viewModelUnlistened.controllerBirimFiyat.text =
                  (snapshot.data).toString();
            }

            return EachRowField(
              controller: (_viewModel.controllerBirimFiyat),
              textLabel: "Birim Fiyat",
              onChange: _viewModelUnlistened.onChange,
              onTap: () => selectTextInField(_viewModel.controllerBirimFiyat),
              focusNode: _focusNodeFiyat,
              suffixText: "₺",
            );
          } else {
            return const CPIndicator();
          }
        });
  }
}

class _EachRowOnlyKdv extends StatelessWidget {
  final String textLabel;
  final String? hintText, initialText;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String?)? onChange;
  final void Function(String?)? onSaved;
  final String? Function(String?)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputFormatter? inputFormatters;
  final String? suffixText;

  const _EachRowOnlyKdv({
    Key? key,
    required this.textLabel,
    this.hintText,
    this.initialText,
    this.readOnly = false,
    this.onTap,
    this.onChange,
    this.controller,
    this.onSaved,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.onEditingComplete,
    this.focusNode,
    this.validator,
    this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 10,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    textLabel + ":",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 20,
                child: SizedBox(
                  width: width(context) / 2,
                  child: BaseFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: onFieldSubmitted,
                    onSaved: onSaved,
                    onEditingComplete: onEditingComplete,
                    textAlign: TextAlign.right,
                    selectionControls: materialTextSelectionControls,
                    controller: controller,
                    hintText: hintText,
                    validator: validator,
                    initialValue: initialText,
                    onChanged: onChange,
                    focusNode: focusNode,
                    onTap: onTap,
                    suffixText: suffixText,
                    readOnly: readOnly,
                    key: key,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            height: 5,
          )
        ],
      ),
    );
  }
}

