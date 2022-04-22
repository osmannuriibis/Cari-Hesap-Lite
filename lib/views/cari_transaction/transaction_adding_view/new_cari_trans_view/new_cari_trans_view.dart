import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/components/text_fields/my_text.dart';
import 'package:cari_hesapp_lite/constants/cari_siniflandirma.dart';
import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';

import '../../../../components/dialogs/custom_alert_dialog.dart';
import '../../../../components/text_fields/base_form_field.dart';
import '../../../../constants/constants.dart';

import '../../../../enums/irsaliye_turu_enum.dart';
import '../../../../models/stok_hareket.dart';
import '../../../../utils/date_format.dart';
import '../add_hareket_to_trans_view/add_hareket_in_trans_view.dart';
import '../add_hareket_to_trans_view/view_model/add_hareket_in_trans_view_model.dart';

import 'new_cari_trans_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CariTransactionAddView extends StatelessWidget {
  const CariTransactionAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CariTransactionAddViewModel>(context);
    var viewModelUnlistened =
        Provider.of<CariTransactionAddViewModel>(context, listen: false);

    return Scaffold(
      appBar: MyAppBar(
        titleText: viewModelUnlistened.cariIslem.islemTuru!.stringValue,
        centerTitle: true,
      ),
      body: SizedBox(
          height: height(context),
          child: SingleChildScrollView(
              child: Column(
            children: [
              AbsorbPointer(

                  //[true] is doesnt allow to interaction
                  absorbing: !viewModel.isAllowedToAdjust,
                  child: _Body(viewModel)),
              _buildSaveButton(context, viewModel, viewModelUnlistened),
            ],
          ))),
    );
  }

  Widget _buildSaveButton(
      BuildContext context,
      CariTransactionAddViewModel viewModel,
      CariTransactionAddViewModel viewModelUnlistened) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 50),
      child: Column(
        children: [
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: Text((viewModel.isAllowedToAdjust) ? "KAYDET" : "DÜZENLE"),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    (viewModel.isAllowedToAdjust)
                        ? kPrimaryColor
                        : Colors.blue),
                textStyle: MaterialStateProperty.all(TextStyle(
                    color: (viewModel.isAllowedToAdjust)
                        ? Colors.black
                        : Colors.white)),
                shape: MaterialStateProperty.all(
                  const StadiumBorder(),
                )),
            onPressed: () {
              switch (viewModel.isAllowedToAdjust) {
                case true:
                  // var progress = MyViewProgressUtil(context);

                  viewModelUnlistened.save().showSaveSnackBar(context);
                  break;
                case false:
                  viewModelUnlistened.isAllowedToAdjust = true;

                  break;
                default:
              }
            },
          ),
          if (!viewModel.isAllowedToAdjust)
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                child: Text("SİL"),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white)),
                  shape: MaterialStateProperty.all(
                    const StadiumBorder(),
                  )),
              onPressed: () async {
                var res = await showDialog<bool?>(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      title: "Uyarı",
                      content: const Text(
                          """Belge tüm bilgileri silinip, Tutar - Cari Bakiye ve (varsa) stoklar güncellenecektir.\nBu işlem geri alınamaz.\nSilmek istiyor musunuz?"""),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("VAZGEÇ")),
                        TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(
                              "SİL",
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    );
                  },
                );
                if (res != null && res) {
                  await viewModel.deleteAll();
                  Navigator.pop(context);
                }
              },
            ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _Body extends StatelessWidget {
  // ignore: prefer_final_fields
  CariTransactionAddViewModel _viewModel;
  _Body(this._viewModel);

  int i = 0;
  late BuildContext context;

  //  AnimationController animationController;
  /* 
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    super.initState();
  }
 */
  @override
  Widget build(BuildContext context) {
    this.context = context;

    CariTransactionAddViewModel viewModelUnlistened =
        Provider.of<CariTransactionAddViewModel>(context, listen: false);

    return Consumer<CariTransactionAddViewModel>(
      builder: (context, viewModel, child) => SizedBox(
        width: double.maxFinite,
        child: Form(
          onChanged: () {},
          child: Column(
            children: [
              _buildNameAndBalanceRow(viewModel.cariKart.id!),

              //_buildEvrakTuruSelect(context, viewModel, isEvrakFieldOpen),
              _buildEvrakTuruSelectField(context),
              _buildEvrakFields(
                context,
              ),

              (viewModel.isAllowedToAdjust)
                  ? _StadiumEndIconedButton(
                      viewModel: viewModel,
                      viewModelUnlistened: viewModelUnlistened,
                      onPressed: () async {
                        //StokListView'den stok çekiyoruz
                        var stokkart = (await getStokKartByPop(context));
                        //stokKart null gelirse bir işlem yapmıyoruz
                        if (stokkart == null) return;

                        var _viewModel = AddHareketInTransViewModel.newAdding(
                            cariIslem: viewModel.cariIslem,
                            cariKart: viewModel.cariKart,
                            stokKart: stokkart);

                        goToView<StokHareket, AddHareketInTransViewModel>(
                                context,
                                viewToGo: AddHareketInTransView(),
                                viewModel: _viewModel)
                            .then((value) {
                          if (value != null) {
                            viewModelUnlistened.addOrUpdateHareketToList(value);

                            //   setState();
                          }
                        });
                      },
                    )
                  : const SizedBox(
                      height: 15,
                    ),
              _ListItemTitle(),
              _buildStokHareketList(context),

              _buildTotalField(context, viewModel),
              const Divider(),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                child: (viewModel.siparisModel != null &&
                        viewModel.isSiparisShowing)
                    ? _buildSiparisArea(context, viewModel)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTotalField(
      BuildContext context, CariTransactionAddViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //   color: Colors.amber[100],
        width: width(context),
        alignment: Alignment.topRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Tutar: ",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
                Text(
                  "Kdv Toplamı: ",
                  style: TextStyle(fontSize: 16),
                ),
                Divider(),
                Text("Toplam: ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  "0.00",
                  controller: viewModel.controllerTutar,
                ), //with provider
                const Divider(),
                MyText(
                  "0.00",
                  controller: viewModel.controllerKdvTutar,
                ),
                const Divider(),
                MyText(
                  "0.00",
                  fontWeight: FontWeight.bold,
                  controller: viewModel.controllerToplam,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvrakFields(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: _viewModel.isEvrakFieldOpen
          ? Card(
              child: Form(
                key: _viewModel.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _MyTextFormField(
                            controller: _viewModel.controllerBelgeNo,
                            labelText: "Belge No",
                            hintText: "A1120",
                          ),
                        ),
                        Expanded(
                          child: _MyTextFormField(
                            controller: _viewModel.controllerDuzenlemeTarihi,
                            labelText: "Düzenleme Tarihi",
                            readOnly: true,
                            onTap: () {
                              _showDateDialog(context,
                                  _viewModel.controllerDuzenlemeTarihi);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _MyTextFormField(
                            labelText: "Düzenleme Saati",
                            controller: _viewModel.controllerDuzenlemeSaati,
                            readOnly: true,
                            onTap: () {
                              _showTimePickerDialog(
                                  context, _viewModel.controllerSevkTarihi);
                            },
                          ),
                        ),
                        Expanded(
                            child: _MyTextFormField(
                          controller: _viewModel.controllerSevkTarihi,
                          labelText: "Sevk Tarihi",
                          readOnly: true,
                          onTap: () {
                            _showDateDialog(
                                context, _viewModel.controllerSevkTarihi);
                          },
                        )),
                      ],
                    ),
                    _MyTextFormField(
                      controller: _viewModel.controllerAciklama,
                      onChanged: (value) {
                        //_controller.value = value;
                      },
                      labelText: "Açıklama",
                    )
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: width(context),
                height: 30,
                child: Card(
                  color: Colors.grey[200],
                ),
              ),
            ),
    );
  }

  /* Container _buildEvrakTuruSelect(
      BuildContext context, CariTransactionAddViewModel viewModel,
      [bool isEvrakFieldOpen = false]) {
    return Container(
      child: GestureDetector(
        onTap: () {
          this.isEvrakFieldOpen = !this.isEvrakFieldOpen;
        },
        child: Card(
          margin: EdgeInsets.all(8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: width(context) / 20,
            ),
            Row(
              children: [
                Text("EvrakTürü2:"),
                ElevatedButton(
                  child: Text(
                      /*  context.read<AddCariTransactionViewModel>().evrakTuru + */
                      /*  context.select<AddCariTransactionViewModel,> */
                      viewModel.getEvrakTuruString()),
                  onPressed: () {
                    _showEvrakTuruAlertDialog(context);
                  },
                ),
              ],
            ),
            IconButton(
                icon: Icon((isEvrakFieldOpen)
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_left),
                onPressed: () {
                  setState(() {});
                  this.isEvrakFieldOpen = !this.isEvrakFieldOpen;
                }),
          ]),
        ),
      ),
    );
  } */

  Widget _buildNameAndBalanceRow(String modelId) {
    var model = _viewModel.cariKart;
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(model.unvani ?? ""),
                const SizedBox(width: 5),
                CircleAvatar(
                  minRadius: 10,
                  backgroundColor: cariSiniflandirma[model.siniflandirma] ??
                      Colors.transparent,
                ),
              ],
            ),
            (model.uyariMesaji.isNotEmptyOrNull)
                ? GestureDetector(
                    child: Lottie.asset(
                      "assets/lottie/warning_red.json",
                      repeat: false,

                      width: 30,
                      height: 30,
                      frameRate: FrameRate(5),
                      //  fit: BoxFit.fitHeight,
                      /*   controller: animationController, */
                    ),
                    onTap: () {
                      showAlertDialog(context,
                          title: "Uyarı Mesajı",
                          content: Text(
                            model.uyariMesaji!,
                            style: const TextStyle(fontSize: 19),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("TAMAM"))
                          ]);
                    },
                  )
                : const SizedBox.shrink(),
            Text(
              "Bakiye :${model.bakiye!.toStringAsFixed(2)} ₺",
            )
          ],
        ),
      ),
    );
  }

  String? _showDateDialog(
      BuildContext context, TextEditingController controller) {
    String? dayString;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 300)),
      firstDate: DateTime.now().subtract(const Duration(days: 3000)),
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((selectedDate) {
      if (selectedDate != null) {
        if (controller == _viewModel.controllerDuzenlemeTarihi) {
          controller.text =
              dateFormatterToString(Timestamp.fromDate(selectedDate));
        }
        dayString = _viewModel.controllerSevkTarihi.text =
            dateFormatterToString(Timestamp.fromDate(selectedDate));
      }
    });

    return dayString;
  }

  String? _showTimePickerDialog(
      BuildContext context, TextEditingController controller) {
    String? dayString;
    showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
            initialEntryMode: TimePickerEntryMode.dial)
        .then((selectedTime) {
      if (selectedTime != null) {
        if (controller == _viewModel.controllerDuzenlemeTarihi) {
          controller.text = timeOfDayFormatterToString(selectedTime);
        }

        dayString = _viewModel.controllerDuzenlemeSaati.text =
            timeOfDayFormatterToString(selectedTime);
      }
    });

    return dayString;
  }

  Widget _buildEvrakTuruSelectField(BuildContext context) {
    var viewModel = Provider.of<CariTransactionAddViewModel>(context);

    return GestureDetector(
      onTap: () {
        //  this.isEvrakFieldOpen = !this.isEvrakFieldOpen;
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width(context) / 20,
            ),
            Row(
              children: [
                const Text("EvrakTürü:"),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(
                    color: kPrimaryColor,
                  )),
                  child: Text(
                      /*  context.read<AddCariTransactionViewModel>().evrakTuru + */
                      /*  context.select<AddCariTransactionViewModel,> */
                      viewModel.evrakTuru.value),
                  onPressed: () {
                    _showEvrakTuruAlertDialog(context, viewModel);
                  },
                ),
              ],
            ),
            IconButton(
                icon: Icon(
                  (_viewModel.isEvrakFieldOpen)
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_left,
                  size: 35,
                ),
                onPressed: () {
                  _viewModel.isEvrakFieldOpen = !_viewModel.isEvrakFieldOpen;
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildStokHareketList(BuildContext context) {
    return Consumer<CariTransactionAddViewModel>(
        builder: (context, _viewModel, child) {
      return _CardForStokHareket(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 400),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 5),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _viewModel.hareketListesiSonHali.length,
            itemBuilder: (context, index) {
              StokHareket stokHareket = _viewModel.hareketListesiSonHali[index];

              return Slidable(
                startActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    icon: Icons.edit,
                    label: "Satırı Düzelt",
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade700,
                    onPressed: (context) async {
                      var stokKart =
                          await DBUtils().getStokKartById(stokHareket.urunId!);

                      StokHareket? stokHareketEditted = await goToView<
                              StokHareket, AddHareketInTransViewModel>(context,
                          viewToGo: AddHareketInTransView(),
                          viewModel:
                              AddHareketInTransViewModel.showExistHareket(
                            cariKart: _viewModel.cariKart,
                            stokHareket: stokHareket,
                            stokKart: stokKart,
                          ));

                      if (stokHareketEditted != null) {
                        _viewModel.addOrUpdateHareketToList(stokHareketEditted,
                            index: index);
                      }
                    },
                  )
                ]),
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                      icon: Icons.delete_forever,
                      label: "Satırı Sil",
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      onPressed: (_) {
                        _viewModel.removeItem(index);
                      })
                ]),
                child: _ItemForStokHareket(
                  onTap: () {},
                  onLongPress: () {
                    _viewModel.removeItem(index);
                  },
                  urunAdi: (index + 1).toString() +
                      ") " +
                      (stokHareket.urunAdi ?? ""),
                  kdv: ((_viewModel.evrakTuru.value !=
                              IrsaliyeTuru.makbuz.stringValue)
                          ? stokHareket.kdvTutar?.toStringAsFixed(2) ?? ""
                          : "0") +
                      stokHareket.paraBirimi.getSembol,
                  miktar: (stokHareket.miktar?.toString() ?? "0") +
                      (stokHareket.birim ?? ""),
                  fiyat: (stokHareket.islemFiyati ?? 0).toStringAsFixed(2) +
                      "${stokHareket.paraBirimi.getSembol}/${stokHareket.birim}",
                  tutar: (_viewModel.evrakTuru.value !=
                          IrsaliyeTuru.makbuz.stringValue)
                      ? (stokHareket.toplamTutar ?? 0).toStringAsFixed(2) +
                          stokHareket.paraBirimi.getSembol
                      : (stokHareket.netTutar ?? 0).toStringAsFixed(2) +
                          stokHareket.paraBirimi.getSembol,
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildSiparisArea(
      BuildContext context, CariTransactionAddViewModel viewModel) {
    return MyCard(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Sipariş Kalemleri"),
            IconButton(
                onPressed: () {
                  viewModel.isSiparisShowing = false;
                },
                icon: const Icon(Icons.close))
          ],
        ),
        for (var item in viewModel.siparisModel!.siparisKalemleri)
          ListTile(
            title: Text(item.urunAdi ?? ""),
            subtitle: Text(
                (item.urunMiktari ?? 0).toString() + " " + (item.birim ?? "")),
          ),
      ],
    ));
  }
}

class _ListItemTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _CardForStokHareket(
      child: _ItemForStokHareket(),
    );
  }
}

class _ItemForStokHareket extends StatelessWidget {
  final String urunAdi, miktar, kdv, tutar, fiyat;

  final VoidCallback? onLongPress, onTap;
  const _ItemForStokHareket({
    Key? key,
    this.urunAdi = "Ürün Adı",
    this.miktar = "Miktar",
    this.kdv = "Kdv",
    this.tutar = "Tutar",
    this.onLongPress,
    this.onTap,
    this.fiyat = "Fiyat",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Column(
                // direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      urunAdi,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(flex: 4, child: Center(child: Text(miktar))),
                        Flexible(flex: 4, child: Center(child: Text(fiyat))),
                        Flexible(flex: 4, child: Center(child: Text(kdv))),
                        Flexible(
                            flex: 4,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(tutar))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardForStokHareket extends StatelessWidget {
  final Widget? child;

  const _CardForStokHareket({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: child,
      ),
    );
  }
}

class _StadiumEndIconedButton extends StatelessWidget {
  final CariTransactionAddViewModel viewModel;
  final CariTransactionAddViewModel viewModelUnlistened;

  final VoidCallback onPressed;
  //final Function setState;
  const _StadiumEndIconedButton({
    Key? key,
    required this.viewModel,
    required this.viewModelUnlistened,
    required this.onPressed,
    //  required this.setState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: kPrimaryColor,
          onPrimary: Colors.black87,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 10),
          child: Text("Ürün Ekle "),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _MyTextFormField extends StatelessWidget {
  final String? initialText, labelText, hintText;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final TextAlign textAlign;

  const _MyTextFormField(
      {Key? key,
      this.initialText,
      this.labelText,
      this.hintText,
      this.readOnly = false,
      this.onTap,
      this.controller,
      this.onChanged,
      this.textAlign = TextAlign.left})
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
      onTap: onTap,
      readOnly: readOnly,
      key: key,
    );
  }
}

_showEvrakTuruAlertDialog(
    BuildContext context, CariTransactionAddViewModel viewModel) {
  List<Widget> _getListTiles() {
    List<Widget> list = [];
    for (IrsaliyeTuru tur in IrsaliyeTuru.values) {
      String title;

      switch (tur) {
        case IrsaliyeTuru.irsaliyeliFatura:
          title = "İrsaliyeli Fatura";
          break;

        /*
        *[Lite] sürümünde kullanıma sunulmadığı için devre dışı bırakıldı
        */

        /* case IrsaliyeTuru.sevkIrsaliyesi:
          title = "Sevk İrsaliyesi";
          break; 
        */
        case IrsaliyeTuru.makbuz:
          title = "Makbuz";
          break;
        default:
          title = "";
      }

      list.add(ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          // Provider.of<CariTransactionAddViewModel>(context, listen: false)
          viewModel.evrakTuru = MapEntry(tur, tur.stringValue);
          Navigator.pop(context);
        },
      ));
    }
    return list;
  }

  showDialog(
    context: context,
    builder: (context) => CustomAlertDialog(
      title: "Evrak Türü",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: _getListTiles(),
      ),
    ),
  );
}
