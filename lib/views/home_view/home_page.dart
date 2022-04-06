import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/enums/siparis_status.dart';
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/models/siparis_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/date_format.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/cari_transaction/transaction_adding_view/new_cari_trans_view/new_cari_trans_view.dart';
import 'package:cari_hesapp_lite/views/cari_transaction/transaction_adding_view/new_cari_trans_view/new_cari_trans_view_model.dart';
import 'package:cari_hesapp_lite/views/home_view/components/drawer/home_driwer_list.dart';
import 'package:cari_hesapp_lite/views/home_view/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../services/firebase/auth/service/auth_service.dart';
import '../../utils/user_provider.dart';
import 'components/drawer/drawer_header.dart';
import 'components/drawer/home_drawer.dart';

class HomeView extends StatelessWidget {
  var controller = TextEditingController();
  late HomeViewModel viewModel;
  late HomeViewModel viewModelUnlistened;

  bool isCari = true;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    viewModel = Provider.of<HomeViewModel>(context);
    viewModelUnlistened = Provider.of<HomeViewModel>(context, listen: false);

    var myPanelList = viewModel.myPanels;
    var listSiparis = viewModel.listSiparis;

    /*  FirebaseFirestore.instance
        .collection("collectionPath")
        .doc()
        .set({"data": "Data2"}).then((value) {
      bas("value");
      bas("value");
    }).onError((error, stackTrace) {
      bas(error);
    }).whenComplete(() => bas("when complete")); */

    return Container(
      color: kPrimaryLightColor, //Theme.of(context).colorScheme.primaryVariant,

      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: false,
          extendBody: false,
          appBar: MyAppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                  icon: const Icon(Icons.power_settings_new),
                  onPressed: () async {
                    var val = await _buildSignOutDialog(context);
                    if (val != null) {
                      if (val) context.read<AuthService>().signOut();
                    }
                  },
                ),
              ),
              IconButton(
                  onPressed: () async {},
                  icon: const Icon(Icons.question_answer))
            ],
            titleText: userProvider.sirketModel?.unvani ?? "___",
          ),
          body: MyColumn(
            children: [
              /*        ExpansionPanelList(
                animationDuration: kThemeAnimationDuration * 3,
                expandedHeaderPadding: const EdgeInsets.all(15),
                elevation: 2,
                expansionCallback: (panelIndex, isExpanded) {
                  viewModelUnlistened.myPanels[panelIndex].isExpanded =
                      !isExpanded;

                  //notifyListener'i tetiklemek için
                  viewModelUnlistened.myPanels = viewModelUnlistened.myPanels;
                  bas(isExpanded);
                  bas(panelIndex);
                  bas(viewModel.myPanels.first.isExpanded);
                },
                children: [
                  for (var panel in myPanelList)
                    ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: panel.headerBuilder,
                      body: panel.body!,
                      isExpanded: panel.isExpanded,
                    )
                ],
              ),
          */

              _ordersArea(listSiparis),
            ],
          ),
          drawerEdgeDragWidth: width(context) / 2,
          
          persistentFooterButtons: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CloseButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser!.reload();
                  },
                ),
              ],
            ),
            ElevatedButton(
              child: const Text("asd"),
              style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              onPressed: () async {
                bas(userProvider.sirketModel);
                bas("userProvider.sirketModel");
                bas(userProvider.userModel);
                bas("userProvider.userModel");
              },
            )
          ],
          drawer: HomeDrawer(

            drawerList: HomeDrawerList(),
            header: Header(),
          ),
        ),
      ),
    );
  }

  MyCard _ordersArea(List<SiparisModel> listSiparis) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Yeni Sipariş"),
                  IconButton(
                      onPressed: () {
                        /*  goToView(context,
                            viewToGo: SiparisAddView(),
                            viewModel: SiparisAddViewModel.addNew(
                                cariIslemTuru: cariIslemTuru,
                                cariKart: cariKart)); */
                      },
                      icon: const Icon(FontAwesomeIcons.plus))
                ],
              ),
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

  Future<bool?> _buildSignOutDialog(BuildContext context) async {
    return await showAlertDialog<bool>(context,
        title: "Çıkış yapıyorsunuz",
        content: const Text("Devam etmek istiyor musunuz?"),
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
              child: const Text("Tamam")),
        ]);
  }

  // ignore: non_constant_identifier_names

}

class SiparisTile extends StatelessWidget {
  const SiparisTile({
    Key? key,
    required this.siparisModel,
  }) : super(key: key);

  final SiparisModel siparisModel;

  @override
  Widget build(BuildContext context) {
    final today = Timestamp.now();
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
        collapsedBackgroundColor:
            (siparisModel.siparisTarihi!.compareTo(today) < 1)
                ? (siparisModel.siparisStatus == SiparisStatus.islemeCevrildi
                    ? null
                    : siparisModel.siparisStatus == SiparisStatus.olusturuldu
                        ? Colors.red.shade100
                        : null)
                : siparisModel.siparisStatus == SiparisStatus.islemeCevrildi
                    ? Colors.green.shade100
                    : null,
        trailing: siparisModel.siparisStatus == SiparisStatus.iptalEdildi
            ? const Text("İptal edildi")
            : (siparisModel.siparisStatus == SiparisStatus.olusturuldu
                ? const Text("Beklemede")
                : const Text("İşlendi")));
  }
}
