import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';

import '../../../../components/appbar/my_app_bar.dart';
import '../../../../components/fsal/special_firebase_list.dart';
import '../../../../enums/irsaliye_turu_enum.dart';
import '../../../../models/kartlar/cari_kart.dart';
import '../../../../utils/view_route_util.dart';
import '../../../../views/cari/cari_list_view/cari_list_view_model.dart/cari_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/buttons/fab.dart';
import '../../../../components/dialogs/custom_alert_dialog.dart';
import '../../../../components/switch/primary_switch.dart';
import '../../../../enums/cari_islem_turu.dart';
import '../../../../models/cari_islem.dart';
import '../../../cari/cari_list_view/cari_list_view.dart';
import 'cari_trans_list_view_model.dart';
import '../../transaction_adding_view/new_cari_trans_view/new_cari_trans_view.dart';
import '../../transaction_adding_view/new_cari_trans_view/new_cari_trans_view_model.dart';
import 'package:flutter/material.dart';

class CariTransactionListView extends StatefulWidget {
  @override
  _CariTransactionListViewState createState() =>
      _CariTransactionListViewState();
}

class _CariTransactionListViewState extends State<CariTransactionListView> {
  var _viewModel = CariTransactionsViewModel();

  var cariIslem = CariIslemModel();

  @override
  Widget build(BuildContext contextt) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: MyAppBar(
        titleText: ("${this._viewModel.islemTuru} İşlemleri"),
        actions: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              PrimarySwitch(
                value: _viewModel.isSwitchedIslemTuru,
                onChanged: (bool value) {
                  setState(() {
                    _viewModel.islemTuru = (value
                        ? CariIslemTuru.satis.stringValue
                        : CariIslemTuru.alis.stringValue);

                    _viewModel.isSwitchedIslemTuru = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.amber[50],
          child: MyFirestoreColList(
            key: (_viewModel.isSwitchedIslemTuru) ? Key("satis") : Key('alis'),
            query: (_viewModel.isSwitchedIslemTuru)
                ? _viewModel.satisQuery
                : _viewModel.alisQuery,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, snapshot, index) {
              if (snapshot?.data() != null) {
                Map<String, dynamic> map = snapshot!.data();

                cariIslem = CariIslemModel.fromMap(map);

                return Column(
                  children: [
                    ListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(cariIslem.cariUnvani ?? ""),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                  cariIslem.toplam != null
                                      ? cariIslem.toplam!.toStringAsFixed(2) +
                                          " ₺"
                                      : "",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red)),
                            ),
                          ]),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(cariIslem.evrakTuru != null
                            ? cariIslem.evrakTuru!.stringValue
                            : "asd"),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      /*   leading: CircleAvatar(
                    child: cariIslem.imagePath != null
                        ? Image.network(cariIslem.imagePath)
                        : Center(
                            child: Text(cariIslem.unvani[0].toUpperCase()),
                          ),
                  ), */
                      onTap: () async {
                        var cariIslemModel = CariIslemModel.fromMap(map);
                        var cariKart = await
                            DBUtils().getCariKartById(cariIslemModel.cariId!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                    create: (context) =>
                                        CariTransactionAddViewModel
                                            .showExistHareket(
cariIslemModel, cariKart

                                            ),
                                    child: CariTransactionAddView())));
                      },
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    )
                  ],
                );
              } else
                return ListTile(
                  title: Text("Veri Yok Abi"),
                );
            },
          ),
        ),
      ),
      floatingActionButton: FAB(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                ShowAlertDialog(_viewModel.isSwitchedIslemTuru, contextt),
          );

          // Navigator.pop(contextt);
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ShowAlertDialog extends StatefulWidget {
  bool isSwitched;

  BuildContext context;

  ShowAlertDialog(
    this.isSwitched,
    this.context, {
    Key? key,
  }) : super(key: key);

  @override
  _ShowAlertDialogState createState() => _ShowAlertDialogState();
}

class _ShowAlertDialogState extends State<ShowAlertDialog> {
  var value = false;
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: ((widget.isSwitched)
              ? CariIslemTuru.satis.stringValue
              : CariIslemTuru.alis.stringValue) +
          " Ekle",
      content: null,
      actions: [
        Text("Perakende Satış?"),
        Checkbox(
          value: value,
          onChanged: (value) {
            this.value = value!;
          },
        ),
        TextButton(
          child: Text("TAMAM"),
          onPressed: () async {
            Navigator.pop(context);

            //CariİşlemView'da yeni [islemTuru] işlemi=>

            CariKart? carikart = await goToView<CariKart, CariListViewModel>(
                context,
                viewToGo: CariListView(),
                viewModel: CariListViewModel());

            if (carikart != null) {
              var _viewModelAddCariTransaction =
                  CariTransactionAddViewModel.addNewHareket(
                cariIslemTuru: (widget.isSwitched)
                    ? CariIslemTuru.satis
                    : CariIslemTuru.alis,
                cariKart: carikart,
              );

              goToView(context,
                  viewToGo: CariTransactionAddView(),
                  viewModel: _viewModelAddCariTransaction);
            }
          },
        ),
      ],
    );
  }
}
