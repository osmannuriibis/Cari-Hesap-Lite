import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/enums/irsaliye_turu_enum.dart';
import 'package:cari_hesapp_lite/enums/siparis_status.dart';
import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cari_hesapp_lite/models/siparis_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/close_statusbar.dart';
import 'package:cari_hesapp_lite/utils/date_format.dart';
import 'package:cari_hesapp_lite/utils/dialogs/dialogs.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/cari_transaction/transaction_adding_view/new_cari_trans_view/new_cari_trans_view.dart';
import 'package:cari_hesapp_lite/views/cari_transaction/transaction_adding_view/new_cari_trans_view/new_cari_trans_view_model.dart';
import 'package:cari_hesapp_lite/views/home_view/components/drawer/home_driwer_list.dart';
import 'package:cari_hesapp_lite/views/home_view/home_view_model.dart';
import 'package:cari_hesapp_lite/views/siparis/siparis_add_view.dart';
import 'package:cari_hesapp_lite/views/siparis/siparis_add_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../utils/user_provider.dart';
import 'components/drawer/drawer_header.dart';
import 'components/drawer/home_drawer.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  var controller = TextEditingController();
  late HomeViewModel viewModel;
  late HomeViewModel viewModelUnlistened;

  bool isCari = true;

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    viewModel = Provider.of<HomeViewModel>(context);
    viewModelUnlistened = Provider.of<HomeViewModel>(context, listen: false);

    var listSiparis = viewModel.listSiparis;
    var listTransactions = viewModel.listTransaction;
    var listIncome = viewModel.listIncome;

    /*  FirebaseFirestore.instance
        .collection("collectionPath")
        .doc()
        .set({"data": "Data2"}).then((value) {
      bas("value");
      bas("value");
    }).onError((error, stackTrace) {
      bas(error);
    }).whenComplete(() => bas("when complete")); */

    return WillPopScope(
      onWillPop: () async {
        bas("viewModel.isDrawerOpen");
        bas(viewModel.isDrawerOpen);
        if (viewModel.isDrawerOpen) return true;

        return await showAlertDialog<bool>(context,
                title: "Cari Hesapp Lite",
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Uygulama kapanacak.\nEmin misiniz?",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text(
                        "Vazgeç",
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Evet")),
                ]) ??
            false;
      },
      child: Container(
        color:
            kPrimaryLightColor, //Theme.of(context).colorScheme.primaryVariant,

        child: SafeArea(
          child: Scaffold(
            onDrawerChanged: (isOpened) => viewModel.isDrawerOpen = isOpened,
            resizeToAvoidBottomInset: false,
            // resizeToAvoidBottomInset: false,

            extendBodyBehindAppBar: false,
            extendBody: false,
            appBar: MyAppBar(
              titleText: userProvider.sirketModel?.unvani ?? "___",
            ),
            body: MyColumn(
              children: [
                _ordersArea(context, listSiparis),
                const Divider(),
                transactionArea(context, listTransactions),
                const Divider(),
                incomingReportArea(context, listTransactions, listIncome),
                const SizedBox(height: 25)
              ],
            ),
            drawerEdgeDragWidth: width(context) / 2,

            drawer: HomeDrawer(
              drawerList: const HomeDrawerList(),
              header: Header(),
            ),
          ),
        ),
      ),
    );
  }

  MyCard _ordersArea(BuildContext context, List<SiparisModel> listSiparis) {
    listSiparis.sort((e, y) => e.siparisTarihi!.compareTo(y.siparisTarihi!));

    return MyCard(
        margin: const EdgeInsets.only(top: 18),
        title: const Text("Siparisler"),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Yeni Sipariş"),
                  IconButton(
                      onPressed: () async {
                        var cariKart = await getCariKartByPop(context);
                        if (cariKart != null) {
                          goToView(context,
                              viewToGo: SiparisAddView(),
                              viewModel: SiparisAddViewModel.addNew(
                                  cariIslemTuru: CariIslemTuru.satis,
                                  cariKart: cariKart));
                        }
                        /**/
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_rounded,
                      ))
                ],
              ),
              const Divider(height: 5),
              /*   if (listSiparis.isEmpty)
                const ListTile(
                  title: Text("Sipariş yok"),
                )
              else */
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listSiparis.length,
                itemBuilder: (context, index) {
                  var model = listSiparis[index];
                  return SiparisTile(
                    siparisModel: model,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ],
          ),
        ));
  }

  Widget transactionArea(BuildContext context, List<CariIslemModel> list) {
    // ignore: prefer_const_constructors
    return MyCard(
      title: const Text("İşlemler"),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Yeni İşlem"),
              IconButton(
                  onPressed: () async {
                    var islem = await showCariIslemTuruDialog(context);
                    if (islem == null) return;

                    var cariKart = await getCariKartByPop(context);

                    if (cariKart == null) return;

                    goToView(context,
                        viewToGo: const CariTransactionAddView(),
                        viewModel: CariTransactionAddViewModel.addNewHareket(
                            cariKart: cariKart, cariIslemTuru: islem));

                    /**/
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                  ))
            ],
          ),
          const Divider(height: 5),
          if (list.isEmpty)
            const ListTile(
              title: Text("Veri yok"),
            ),
          for (var cariIslem in list)
            ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cariIslem.cariUnvani ?? ""),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                          cariIslem.toplam != null
                              ? cariIslem.toplam!.toStringAsFixed(2) + " ₺"
                              : "",
                          style:
                              const TextStyle(fontSize: 15, color: Colors.red)),
                    ),
                  ]),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((cariIslem.evrakTuru != null
                        ? cariIslem.evrakTuru!.stringValue
                        : "") +
                    " - " +
                    (cariIslem.islemTuru?.stringValue ?? "")),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              /*   leading: CircleAvatar(
                    child: cariIslem.imagePath != null
                        ? Image.network(cariIslem.imagePath)
                        : Center(
                            child: Text(cariIslem.unvani[0].toUpperCase()),
                          ),
                  ), */
              onTap: () async {
                var cariKart =
                    await DBUtils().getCariKartById(cariIslem.cariId!);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (context) =>
                                CariTransactionAddViewModel.showExistHareket(
                                    cariIslem, cariKart),
                            child: const CariTransactionAddView())));
              },
            ),
        ],
      ),
    );
  }

  incomingReportArea(
      BuildContext context,
      List<CariIslemModel> listTransactions,
      List<HesapHareketModel> listIncome) {
    num gelir = 0, satis = 0;

    for (var item in listTransactions) {
      satis += (item.toplamTutar ?? 0);
    }
    for (var item in listIncome) {
      gelir += item.toplamTutar ?? 0;
    }

    return MyCard(
      title: const Text("Günlük Rapor"),
      child: Row(
        children: [
          _incomeCard(context, title: "Satış", amount: satis),
          const SizedBox(width: 4),
          _incomeCard(context, title: "Gelir", amount: gelir),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names

}

Widget _incomeCard(BuildContext context,
    {required String title, required num amount}) {
  return Expanded(
      child: AspectRatio(
    aspectRatio: 2,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 0.25),
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          Text(
            amount.toStringAsFixed(2) + " ₺",
            style: context.textTheme.headline6,
          ),
        ],
      )),
    ),
  ));
}

class SiparisTile extends StatelessWidget {
  const SiparisTile({
    Key? key,
    required this.siparisModel,
  }) : super(key: key);

  final SiparisModel siparisModel;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(siparisModel.cariAdi ?? ""),
        subtitle: siparisModel.siparisTarihi != null
            ? Text(dateFormatterToString(siparisModel.siparisTarihi!))
            : null,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  Text("Tarih: " +
            dateFormatterToString(model.kayitTarihi!)),
        const Text("Ürünler:"), */

          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Siparişler:"),
              for (var item in siparisModel.siparisKalemleri)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text((item.urunMiktari ?? -1).toString()),
                      const SizedBox(width: 4),
                      Text(item.birim ?? ""),
                      const SizedBox(width: 8),
                      Text(item.urunAdi ?? ""),
                    ],
                  ),
                ),
            ]),
          ),
          const Divider(),
          if (siparisModel.siparisStatus == SiparisStatus.olusturuldu)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text("İptal et"),
                  onPressed: () {
                    DBUtils().updateModel<SiparisModel>(
                        {"siparisStatus": SiparisStatus.iptalEdildi.name},
                        siparisModel.id);
                  },
                ),
                TextButton(
                  child:
                      Text(siparisModel.cariIslemTuru!.stringValue + 'a çevir'),
                  onPressed: () async {
                    var cariKart =
                        await DBUtils().getCariKartById(siparisModel.cariId!);
                    goToView(
                      context,
                      viewToGo: const CariTransactionAddView(),
                      viewModel: CariTransactionAddViewModel.addNewHareket(
                          cariKart: cariKart,
                          cariIslemTuru: siparisModel.cariIslemTuru!,
                          siparisModel: siparisModel),
                    );
                  },
                ),
                TextButton(
                  child: Text(siparisModel.cariIslemTuru! == CariIslemTuru.satis
                      ? "Teslim Edildi"
                      : "Teslim Alındı"),
                  onPressed: () {
                    siparisModel.siparisStatus = SiparisStatus.islemeCevrildi;
                    DBUtils().addOrSetModel(siparisModel);
                  },
                ),
              ],
            )
          else
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      DBUtils().deleteModel<SiparisModel>(siparisModel);
                    },
                    child: const Text("Sil"))
              ],
            )
        ],
        trailing: siparisModel.siparisStatus == SiparisStatus.iptalEdildi
            ? const Text("İptal edildi")
            : (siparisModel.siparisStatus == SiparisStatus.olusturuldu
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Beklemede"),
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor:
                            (siparisModel.siparisTarihi?.toDate() ??
                                            DateTime.now())
                                        .compareTo(DateTime.now()) <
                                    1
                                ? Colors.red.shade700
                                : Colors.orange[800],
                      )
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("İşlendi"),
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.green.shade700,
                      )
                    ],
                  )));
  }
}
