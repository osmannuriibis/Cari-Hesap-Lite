import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../services/firebase/database/utils/database_utils.dart';
import '../../../../utils/extensions.dart';

import '../../../components/buttons/base_primary_button.dart';
import '../../../components/dialogs/alert_with_firebase_list.dart';
import '../../../components/text_fields/base_bordered_text_field.dart';
import '../../../constants/constants.dart';
import '../../../models/bilgiler/bilgiler.dart';
import '../../../utils/general.dart';
import '../../../utils/num_input_formatter.dart';
import '../../../utils/validator.dart';
import '../../cari/cari_add_view/components/each_row_text_field.dart';
import 'view_model/stok_add_view_model.dart';

class StokAddView extends StatelessWidget with Validator {
  const StokAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _viewModel = Provider.of<StokAddViewModel>(context);
    var _viewModelUnlistened =
        Provider.of<StokAddViewModel>(context, listen: false);

    return Scaffold(
      appBar: MyAppBar(
        title: Text(
            "Stok ${(_viewModelUnlistened.isNewAdding) ? "Ekle" : "Düzenle"}"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _viewModel.formKey,
          child: Column(
            children: [
              Label("Ürün Bilgileri"),
              BaseBorderedTextField(
                controller: _viewModelUnlistened.controllerStokAdi,
                keyboardType: TextInputType.name,
                labelText: "Stok Adı",
                hintText: "",
                validator: bosOlamaz,
              ),
              /*   BaseBorderedTextField(
                controller: _viewModelUnlistened.controllerStokTipi,
                labelText: "Stok Tipi",
                hintText: "",
                //  validator: bosOlamaz,
              ), */
              RowTextFieldWithEndIcon(
                controller: _viewModelUnlistened.controllerBarkod,
                keyboardType: TextInputType.number,
                labelText: "Barkod",
                hintText: "",
                endIcon: const Icon(Icons.qr_code),
                endIconPressed: () {
                  _viewModelUnlistened
                      .fetchBarcode() /* .then(...) => SnackBar */;
                },
              ),
              BaseBorderedTextField(
                controller: _viewModelUnlistened.controllerUrunKodu,
                keyboardType: TextInputType.number,
                labelText: "Ürün Kodu",
                hintText: "",
              ),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: BaseBorderedTextField(
                      controller: _viewModelUnlistened.controllerKategori,
                      labelText: "Kategori",
                      hintText: "",
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: BaseBorderedTextField(
                      validator: bosOlamaz,
                      controller: _viewModel.controllerBirim,
                      labelText: "Birim",
                      readOnly: true,
                      onTap: () {
                        showDialogForBirim(
                            context, _viewModel, _viewModelUnlistened);
                      },
                      hintText: "",
                    ),
                  ),
                ],
              ),
              /////////////////////////////
              /////////////////////////////
              /////////////////////////////
              /////////////////////////////
              /////////////////////////////
              const Label("Ürün Tipi"),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text("Hizmet",
                              textScaleFactor:
                                  _viewModel.isStoklu ? null : 1.2),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Switch(
                          activeColor: kPrimaryColor,
                          inactiveThumbColor: kPrimaryColor,
                          inactiveTrackColor: kPrimaryLightColor,
                          thumbColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                          value: _viewModel.isStoklu,
                          onChanged: (value) {
                            _viewModel.isStoklu = value;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            "Stoklu Ürün",
                            textScaleFactor: _viewModel.isStoklu ? 1.2 : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

/* 
 *Lite sürümünde stok miktarı tutlmadığı için devred ışı bırakıldı.
 */
/*               AnimatedSize(
                duration: const Duration(milliseconds: 600),
                curve: Curves.bounceIn,
                child: Visibility(
                  visible: _viewModel.isStoklu,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RowTextFieldWithEndIcon(
                        controller: _viewModelUnlistened.controllerEmniyetStogu,
                        labelText: "Emniyet Stoğu",
                        inputFormatters: [DecimalTextInputFormatter()],
                        keyboardType: TextInputType.number,
                        endIcon: const Icon(Icons.info_outline),
                        endIconPressed: () {
                          showBuNedirDialogs(context, BuNedirEnum.emniyetStogu);
                        },
                      ),
                      for (var i = 0;
                          i < (_viewModel.miktarList.length + 1);
                          i++)
                        _RowForMiktarAndDepo(
                          viewModel: _viewModel,
                          viewModelUnlistened: _viewModelUnlistened,
                          index: i,
                        ),
                    ],
                  ),
                ),
              ), */

              const Label("Finansal Ayarlar"),
              BaseBorderedTextField(
                controller: _viewModel.controllerKdvOrani,
                labelText: "Kdv Oranı",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                selectTextWithTap: true,
                keyboardType: TextInputType.number,
                hintText: "8",
                onChanged: (value) {},
                validator: kdvValidator,
              ),
              _financalArea(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _viewModel.uyariAltBasligi,
                      style: const TextStyle(color: Colors.redAccent),
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 3,
                indent: 10,
                endIndent: 10,
              ),

              BaseBorderedTextField(
                controller: _viewModel.controllerAciklama,
                keyboardType: TextInputType.multiline,
                labelText: "Açıklama",
                hintText: "",
              ),
              MyBaseButton(
                buttonText: "KAYDET",
                onPressed: () async {
                  _viewModelUnlistened.saveStok().showSaveSnackBar(context);
                },
              ),
              SizedBox(
                height: height(context) / 3,
              ) /* */
            ],
          ),
        ),
      ),
    );
  }

  void showDialogForBirim(BuildContext context, StokAddViewModel _viewModel,
      StokAddViewModel _viewModelUnlistened) {
    showDialog(
      context: context,
      builder: (context) => AlertDialogWithFirebaseList(
        hintText: "Adet",
        controller: _viewModel.controllerBirimEkle,
        title: const Text("Birim Seç Ekle"),
        query: DBUtils()
            .getModelReference<Bilgiler>(Bilgiler.birimler)
            .snapshots(),
        onPressedActionButton: _viewModelUnlistened.addYeniBirim,
        onLongPressItem: _viewModelUnlistened.deleteBirimFromList,
        onPressedItem: (MapEntry snapshot) {
          _viewModelUnlistened.selectBirimFromList(snapshot);
          Navigator.of(context).pop(true);
        },
      ),
    );
  }
}

/* class _RowForMiktarAndDepo extends StatelessWidget {
  final int index;
  StokAddViewModel viewModel;
  StokAddViewModel viewModelUnlistened;

  _RowForMiktarAndDepo({
    Key? key,
    required this.index,
    required this.viewModel,
    required this.viewModelUnlistened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = viewModel.miktarList;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 7,
            child: BaseBorderedTextField(
              divider: false,
              /*  controller: _viewModelUnlistened
                  .controllerBaslangicMiktari, */
              inputFormatters: [DecimalTextInputFormatter()],
              keyboardType: TextInputType.number,
              labelText: "İlk Miktarı",
              hintText: "",
              initialValue:
                  (index < list.length) ? list[index].value.toString() : null,
              readOnly: (index == list.length) ? false : true,
              controller: (index == list.length)
                  ? (viewModel
                      .controllerIlkMiktar /*  = TextEditingController() */)
                  : null,
            ),
          ),
        /*   Flexible(
            flex: 7,
            child: BaseBorderedTextField(
              divider: false,
              labelText: "Depo",
              hintText: "",
              controller:
                  (index == list.length) ? (viewModel.controllerDepo) : null,
              initialValue:
                  (index < list.length) ? list[index].key.value : null,
              readOnly: true,
              onTap: (index == list.length)
                  ? () {
                      bas(viewModel.depoList);
                      showAlertDialog<MapEntry<String, String>>(context,
                          title: "Depo Seçiniz",
                          content: viewModelUnlistened.depoList.isNotEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var i = 0;
                                        i < viewModel.depoList.length;
                                        i++)
                                      ListTile(
                                        title:
                                            Text(viewModel.depoList[i].value),
                                        onTap: () {
                                          Navigator.pop(context);
                                          viewModel.controllerDepo.text =
                                              viewModel.depoList[i].value;
                                          viewModel.selectedDepo = MapEntry(
                                              viewModel.depoList[i].key,
                                              viewModel.depoList[i].value);
                                        },
                                      )
                                  ],
                                )
                              : MyFirestoreColList(
                                  query:
                                      DBUtils().getClassReference<DepoModel>(),
                                  itemBuilder: (context, snapshot, index) {
                                    // bas(snapshot.data());
                                    if (snapshot == null) {
                                      return const SizedBox.shrink();
                                    } else {
                                      bas("firebase ");
                                      viewModel.depoList.add(MapEntry(
                                          snapshot.data()["id"] ?? "",
                                          snapshot.data()["adi"] ?? ""));
                                      return ListTile(
                                        title: Text(snapshot.get("adi")),
                                        subtitle: Text((snapshot.data()["adres"]  ) ?? ""),
                                        trailing: const Text("\$anaDepo"),
                                        onTap: () {
                                          Navigator.pop(context);
                                          viewModel.controllerDepo.text =
                                              snapshot.get("adi") as String;
                                          viewModel.selectedDepo = MapEntry(
                                              snapshot.get("id") as String,
                                              snapshot.get("adi") as String);
                                        },
                                      );
                                    }
                                  },
                                ));
                    }
                  : null,
            ),
          ), */
          Flexible(
            flex: 3,
            child: TextButton(
              onPressed: () {
                viewModelUnlistened.addOrDeleteMiktarFiled(index);
              },
              child: (index == list.length)
                  ? const Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
} */

class Label extends StatelessWidget {
  final String title;
  const Label(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 3,
          indent: 10,
          endIndent: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(
          thickness: 3,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}

Widget _financalArea(BuildContext context) {
  var _viewModel = Provider.of<StokAddViewModel>(context);

  double widthBoxSize = MediaQuery.of(context).size.width * 0.33;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        children: [
          _customCard(
            labelText: "Alış Fiyatı",
            widthBoxSize: widthBoxSize,
            child: _MyCustomTextField(
              controller: _viewModel.controllerAlisFiyat,
              onChanced: _viewModel.onChangeAlisFiyat,
              onTap: () {
                selectTextInField(
                  _viewModel.controllerAlisFiyat,
                );
              },
            ),
          ),
          SizedBox(
            width: widthBoxSize / 2,
            height: widthBoxSize / 2,
          ),
          _customCard(
            labelText: "Satış Fiyatı",
            widthBoxSize: widthBoxSize,
            child: _MyCustomTextField(
              controller: _viewModel.controllerSatisFiyat,
              onChanced: _viewModel.onChangeSatisFiyat,
              onTap: () {
                selectTextInField(
                  _viewModel.controllerSatisFiyat,
                );
              },
            ),
          ),
        ],
      ),
      _customCard(
        labelText: "Kâr Oranı",
        widthBoxSize: widthBoxSize,
        child: _MyCustomTextField(
          readOnly: true,
          controller: _viewModel.controllerKarOrani,
          hasSuffixText: false,
        ),
      ),
      Column(
        children: [
          _customCard(
            labelText: "Kdvli Alış",
            widthBoxSize: widthBoxSize,
            child: _MyCustomTextField(
              controller: _viewModel.controllerAlisFiyatiKdvli,
              onChanced: _viewModel.onChangeAlisFiyatKdvli,
              onTap: () {
                selectTextInField(
                  _viewModel.controllerAlisFiyatiKdvli,
                );
              },
            ),
          ),
          SizedBox(
            width: widthBoxSize / 2,
            height: widthBoxSize / 2,
          ),
          _customCard(
            labelText: "Kdvli Satış",
            widthBoxSize: widthBoxSize,
            child: _MyCustomTextField(
              controller: _viewModel.controllerSatisFiyatiKdvli,
              onChanced: _viewModel.onChangeSatisFiyatKdvli,
              onTap: () {
                selectTextInField(
                  _viewModel.controllerSatisFiyatiKdvli,
                );
              },
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _customCard({
  BuildContext? context,
  required Widget child,
  double? widthBoxSize,
  required String labelText,
}) {
  return SizedBox(
    width: widthBoxSize,
    height: widthBoxSize,
    child: Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(labelText),
          child,
        ],
      ),
    ),
  );
}

class _MyCustomTextField extends StatelessWidget {
  final Function()? onTap;
  final void Function(String)? onChanced;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool readOnly;
  final String? hintText;
  final bool hasSuffixText;

  const _MyCustomTextField(
      {Key? key,
      this.onTap,
      this.onChanced,
      this.hintText,
      this.controller,
      this.hasSuffixText = true,
      this.readOnly = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        readOnly: readOnly,
        keyboardType: TextInputType.number,
        inputFormatters: [DecimalTextInputFormatter()],
        controller: controller,
        textAlign: TextAlign.center,
        validator: validator,
        onTap: onTap,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        onChanged: onChanced,
        decoration: InputDecoration(
            suffixText: hasSuffixText ? "₺" : null,
            border: const OutlineInputBorder(borderSide: BorderSide(width: 5)),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            isCollapsed: true),
      ),
    );
  }
}

/* 


        Column(
          children: [
            Card(
              child: Column(
                children: [
                  Text("Alış Fiyatı"),
                  _MyCustomTextField(),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Text("Alış Fiyatı\n+KDV"),
                  _MyCustomTextField(),
                ],
              ),
            ),
          ],
        ),
        Card(
          child: Text("Kar Oranı%"),
        ), //Orta kark
        Column(
          children: [
            Card(
              child: Column(
                children: [
                  Text("Satış Fiyatı"),
                  _MyCustomTextField(),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Text("Satış Fiyatı\n+KDV"),
                  _MyCustomTextField(),
                ],
              ),
            ),
          ],
        ),
 */

/* class _MyCustomTextField extends StatelessWidget {
  final bool readOnly;

  final Function onTap, onChanced;

  final String labelText, hintText;

  final IconData icon, endIcon;

  final Function endIconPressed;

  const _MyCustomTextField({
    Key key,
    this.readOnly,
    this.onTap,
    this.onChanced,
    this.labelText,
    this.hintText,
    this.icon,
    this.endIcon,
    this.endIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanced,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
} */
