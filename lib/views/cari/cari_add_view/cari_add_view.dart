import 'dart:developer';
import 'dart:ui';

import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/dialogs/bu_nedir_dialog.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/constants/cari_siniflandirma.dart';
import 'package:cari_hesapp_lite/enums/bu_nedir.dart';
import 'package:cari_hesapp_lite/models/bilgiler/bilgiler_util/cari_grup.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/place_picker.dart';
import 'package:cari_hesapp_lite/utils/place_picker_package/lib/entities/entities.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/utils/validator.dart';
import 'package:cari_hesapp_lite/views/cari/cari_add_view/cari_add_view_model/components/each_row_text_field.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../components/dialogs/alert_with_firebase_list.dart';
import '../../../components/text_fields/base_bordered_text_field.dart';
import '../../../constants/constants.dart';
import '../../../enums/cari_turu.dart';
import '../../../models/bilgiler/bilgiler.dart';
import '../../../services/il_ilce_json/il_ilce_listesi.dart';
import '../../../utils/num_input_formatter.dart';
import 'cari_add_view_model/cari_add_view_model.dart';

class CariAddView extends StatefulWidget {
  @override
  _CariAddViewState createState() => _CariAddViewState();
}

class _CariAddViewState extends State<CariAddView> with Validator {
  @override
  late BuildContext context;
  List<Widget> getExtraPhoneField = [];

  late CariAddViewModel viewModel;

  late CariAddViewModel viewModelUnlistened;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    viewModel = Provider.of<CariAddViewModel>(context);
    viewModelUnlistened = Provider.of(context, listen: false);
    print(viewModel);

    return DefaultTabController(
      initialIndex: viewModel.initialIndex,
      length: 3,
      child: Scaffold(
        appBar: MyAppBar(
          titleText: "Cari " + (viewModel.isNewAdding ? "Ekle" : "Düzenle"),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.check,
              ),
              onPressed: () {
                save();
              },
            )
          ],
          bottom: const TabBar(
            indicatorWeight: 2,
            tabs: [
              Tab(
                text: "Genel",
              ),
              Tab(
                text: "Finansal",
              ),
              Tab(
                text: "Son Adım",
              ),
            ],
          ),
        ),
        body: Form(
          key: viewModel.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: [
                _buildTab1(context),
                _buildTab2(context),
                _buildTab3(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab1(BuildContext context) {
    return MyColumn(
      children: [
        BaseBorderedTextField(
          labelText: "Unvanı",
          controller: viewModel.controllerUnvani,
          hintText: "Dostlar Ltd...",
          keyboardType: TextInputType.name,
          onChanged: (value) {
            viewModel.formKey.currentState!.validate();
          },
          validator: cokKisaOldu,
        ),
        BaseBorderedTextField(
          readOnly: true,
          controller: viewModel.controllerCariTuru,
          labelText: "Cari Türü",
          hintText: "Tedarikçi",
          onTap: () {
            showDialogForCariTuru(context);
          },
        ),
        BaseBorderedTextField(
          controller: viewModel.controllerCariGrup,
          readOnly: true,
          inputFormatters: [
            FilteringTextInputFormatter.deny(" "),
          ],
          onTap: () {
            showDialogForGrup(context);
          },
          labelText: "Grubu",
          hintText: "Gıda Market,Restoran vs..",
          validator: bosOlamaz,
          onChanged: (value) {
            viewModel.formKey.currentState!.validate();
          },
        ),
        BaseBorderedTextField(
          labelText: "Semt Bilgisi",
          controller: viewModel.controllerSemtBilgisi,
          hintText: "Bu alan listeleme ekranında görünecektir",
          keyboardType: TextInputType.name,
        ),
        BaseBorderedTextField(
          controller: viewModel.controllerTelefon,

          /*   endIcon: const Icon(Icons.add),
           endIconColor: Colors.black87,
          endIconPressed: addNewPhoneFiled, */
          labelText: "Telefon",
          hintText: "05..",
          keyboardType: TextInputType.number,
          inputFormatters: [
            TextInputMask(
              mask: '9(999) 999 9999',
              placeholder: '_', /* maxPlaceHolders: 11 */
            )
          ],
        ),
        if (getExtraPhoneField.isNotEmpty) ...getExtraPhoneField,
        BaseBorderedTextField(
          labelText: "Email",
          controller: viewModel.controllerEmail,
          hintText: "cari@firma.com.tr",
          keyboardType: TextInputType.emailAddress,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(style: BorderStyle.none)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Adres Bilgileri",
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("BUL"),
                      Icon(Icons.location_on_outlined),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push<LocationResult>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => showPlacePicker(
                              initialSearchWord:
                                  viewModel.controllerUnvani.text),
                        )).then(viewModelUnlistened.setKonumAyarlari);
                  },
                ),
              ],
            ),
          ),
        ),
        BaseBorderedTextField(
          labelText: "Adres",
          controller: viewModel.controllerAdres,
          hintText: "",
          keyboardType: TextInputType.streetAddress,
        ),
        BaseBorderedTextField(
          labelText: "Şehir",
          controller: viewModel.controllerSehir,
          readOnly: viewModel.readOnlySehir,
          hintText: "İstanbul",
          keyboardType: TextInputType.name,
          onTap: () {
            showIlListesiDialog(context).then((value) {
              if (value != null) viewModelUnlistened.setSehir(value);
            });
          },
        ),
        BaseBorderedTextField(
          labelText: "İlçe",
          controller: viewModel.controllerIlce,
          readOnly: viewModel.readOnlyIlce,
          keyboardType: TextInputType.name,
          hintText: "Bayrampaşa",
          onTap: () {
            showIlceListesiDialog(context).then((value) {
              viewModelUnlistened.setIlce(value);
            });
          },
        ),
        TextButton(
          child: const Text("Devam"),
          onPressed: () {
            if (viewModel.formKey.currentState!.validate()) {
              setState(() {
                viewModelUnlistened.initialIndex = 1;
              });
            }
          },
        )
      ],
    );
  }

  Future showDialogForGrup(BuildContext context) {
    var query = DBUtils().getClassReference<Bilgiler>();
    bas(query.path);
    bas(query.doc(Bilgiler.cariGrup).path);
    return showDialog(
      context: context,
      builder: (context) => AlertDialogWithFirebaseList(
        title: const Text("Cari Grup Seç/Ekle"),
        hintText: "Örn: Restoran",
        onLongPressItem: (MapEntry map) {
          bas(map);
          viewModelUnlistened.deleteCariGrupFromList(map);
        },
        onPressedItem: (MapEntry map) {
          bas(map);

          viewModelUnlistened.selectCariGrupFromList(map);
          Navigator.of(context).pop(true);
        },
        query: getBilgilerDocRef(Bilgiler.cariGrup).snapshots(),
        controller: viewModel.controllerCariGrupDialog,
        onPressedActionButton: () async {
          if (viewModelUnlistened.controllerCariGrupDialog.text.isNotEmpty &&
              await viewModelUnlistened.addCariGrup()) {
            bas("object");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Listeye Eklendi"),
            ));
          }
          viewModelUnlistened.formKey.currentState!.reset();
        },
      ),
    );
  }

  Future showDialogForCariTuru(BuildContext context) {
    CariTuru selectedCariTuru;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cari Turu Seçiniz"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var item in CariTuru.values)
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${item.stringValue}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                onTap: () {
                  viewModelUnlistened.cariTuru = item;
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab2(BuildContext context) {
    return MyColumn(
      children: [

        BaseBorderedTextField(
          readOnly: !viewModelUnlistened.isNewAdding,
          labelText: "Devir Bakiye",
          controller: viewModel.controllerBakiye,
          hintText: "350.00",
          keyboardType: TextInputType.number,
          inputFormatters: [
            DecimalTextInputFormatter(),
          ],
          onChanged: viewModelUnlistened.bakiyeOnChanced,
        ),
        MySwitch(viewModelUnlistened, viewModel.isSwitchDisable),
        const Divider(),
        BaseBorderedTextField(
          labelText: "Vergi Dairesi",
          controller: viewModel.controllerVDairesi,
          keyboardType: TextInputType.name,
          hintText: "Acısu VD..",
        ),
        BaseBorderedTextField(
          labelText: "Vergi Numarası",
          controller: viewModel.controllerVNo,
          hintText: "123456..",
          keyboardType: TextInputType.number,
        ),
        TextButton(
          child: Text("Devam"),
          onPressed: () {
            DefaultTabController.of(context)!.animateTo(2);
          },
        )
      ],
    );
  }

  Widget _buildTab3(BuildContext context) {
    return MyColumn(
      children: [
        RowTextFieldWithEndIcon(
            readOnly: true,
            labelText: "Sınıflandırma",
            controller: viewModel.controllerSiniflandirma,
            onTap: () {
              showSiniflandirmaDialog().then((value) {
                if (value != null) {
                  viewModelUnlistened.controllerSiniflandirma.text = value.key;
                }
              });
            },
            endIcon: const Icon(Icons.info_outline),
            endIconPressed: () {
              showBuNedirDialogs(context, BuNedirEnum.siniflandirma);
            }),
        RowTextFieldWithEndIcon(
            labelText: "Risk Limiti",
            controller: viewModel.controllerRiskLimiti,
            keyboardType: TextInputType.number,
            inputFormatters: [DecimalTextInputFormatter()],
            hintText: null,
            endIcon: const Icon(Icons.info_outline),
            endIconPressed: () {
              showBuNedirDialogs(context, BuNedirEnum.riskLimiti);
            }),
        RowTextFieldWithEndIcon(
            labelText: "Uyarı Mesajı",
            controller: viewModel.controllerUyariMesaji,
            hintText: "Örn:Sadece peşin satış yap...",
            endIcon: const Icon(Icons.info_outline),
            endIconPressed: () {
              showBuNedirDialogs(context, BuNedirEnum.uyariMesaji);
            }),
        BaseBorderedTextField(
          labelText: "Açıklama",
          controller: viewModel.controllerAciklama,
          hintText: "...",
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
          icon: const Icon(
            Icons.check,
          ),
          label: Text(
              (viewModelUnlistened.isNewAdding) ? "Hesabı Oluştur" : "KAYDET"),
          onPressed: () {
            save();
          },
        )
      ],
    );
  }

  addNewPhoneFiled() {
    setState(() {
      getExtraPhoneField.add(BaseBorderedTextField(
        keyboardType: TextInputType.number,
        inputFormatters: [DecimalTextInputFormatter()],
        labelText: ("Telefon " + (getExtraPhoneField.length + 2).toString()),
      ));
    });
  }

  Future<Map<String, String>?> showIlListesiDialog(BuildContext context) {
    ilListesi.sort((a, b) {
      return a['name']!.compareTo(b['name']!);
    });

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Il Seçiniz"),
        children: [
          ListTile(
            leading: const SizedBox.shrink(),
            title: const Text("DİĞER"),
            onTap: () {
              Navigator.of(context).pop<Map<String, String>>({});
            },
          ),
          for (var item in ilListesi)
            ListTile(
              leading: SizedBox.shrink(),
              title: Text(
                item['name']!,
              ),
              onTap: () {
                Navigator.of(context).pop<Map<String, String>>(item);
              },
            )
        ],
      ),
    );
  }

  showIlceListesiDialog(BuildContext context) {
    var ilceListTemp = ilceListesi;

    ilceListTemp = ilceListTemp.where((f) {
      return f['il_id'] == viewModel.selectedSehirId;
    }).toList();

    ilceListTemp.sort((a, b) {
      return a['name']!.compareTo(b['name']!);
    });

    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("İlçe Seçiniz"),
        children: [
          ListTile(
            leading: const SizedBox.shrink(),
            title: const Text("DİĞER"),
            onTap: () {
              Navigator.of(context).pop<Map<String, String>>({});
            },
          ),
          for (var item in ilceListTemp)
            ListTile(
              leading: const SizedBox.shrink(),
              title: Text(
                item['name']!,
              ),
              onTap: () {
                Navigator.of(context).pop<Map<String, String>>(item);
              },
            )
        ],
      ),
    );
  }

  void save() {
    
    viewModelUnlistened.save().showSaveSnackBar(context);
  }

  Future<MapEntry<String, Color>?> showSiniflandirmaDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sınıflandırma"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var item in cariSiniflandirma.entries)
              ListTile(
                title: Text(item.key),
                trailing: CircleAvatar(
                  backgroundColor: item.value,
                ),
                onTap: () {
                  Navigator.pop<MapEntry<String, Color>>(context, item);
                },
              )
          ],
        ),
      ),
    );
  }
}

class MySwitch extends StatefulWidget {
  late CariAddViewModel _viewModel;
  late bool _isSwitchDisable;
  MySwitch(CariAddViewModel viewModel, bool isSwitchDisable) {
    _isSwitchDisable = isSwitchDisable;
    _viewModel = viewModel;
  }

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool isSwitchChecked = true;
  String borclu = "Borçlu";

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      //Devir Bakiyesinde değer yoksa bu kısım çalışmıyor

      absorbing: widget._isSwitchDisable,
      child: GestureDetector(
        onTap: () {
          isSwitchChecked = !isSwitchChecked;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (borclu),
                  style: TextStyle(
                      fontSize: 15,
                      color: widget._isSwitchDisable
                          ? Colors.black26
                          : Colors.black54),
                ),
                Switch(
                  inactiveThumbColor: widget._isSwitchDisable
                      ? Colors.grey.shade400
                      : kPrimaryLightColor,
                  activeTrackColor: widget._isSwitchDisable
                      ? Colors.grey.shade200
                      : kPrimaryLightColor,
                  activeColor: widget._isSwitchDisable
                      ? Colors.grey.shade400
                      : kPrimaryColor,
                  inactiveTrackColor: widget._isSwitchDisable
                      ? Colors.grey.shade200
                      : kPrimaryColor,
                  value: isSwitchChecked,
                  onChanged: (boolValue) {
                    isSwitchChecked = boolValue;
                    borclu = (isSwitchChecked) ? "Borçlu" : "Alacaklı";
                    widget._viewModel.borclu = isSwitchChecked;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
