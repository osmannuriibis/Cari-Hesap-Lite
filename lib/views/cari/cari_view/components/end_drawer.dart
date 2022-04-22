import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';
import 'package:cari_hesapp_lite/components/dialogs/custom_alert_dialog.dart';
import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/models/siparis_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/home_view/home_page.dart';
import 'package:cari_hesapp_lite/views/siparis/siparis_add_view.dart';
import 'package:cari_hesapp_lite/views/siparis/siparis_add_view_model.dart';

import '../../../../enums/cari_islem_turu.dart';
import '../../../../enums/gelir_gider_turu.dart';
import '../../../../enums/hesap_hareket_turu.dart';
import '../../../account_transaction/add_account_transaction_view/account_transaction_add_view.dart';
import '../../../account_transaction/add_account_transaction_view/account_transaction_add_view_model.dart';
import '../cari_view_model.dart';
import '../../../cari_transaction/transaction_adding_view/new_cari_trans_view/new_cari_trans_view.dart';
import '../../../cari_transaction/transaction_adding_view/new_cari_trans_view/new_cari_trans_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CariViewEndDrawer extends StatelessWidget {
  late BuildContext context;
  late CariViewModel viewModel;
  late CariViewModel viewModelUnlistened;

  CariViewEndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    viewModel = Provider.of<CariViewModel>(context);
    viewModelUnlistened = Provider.of<CariViewModel>(context, listen: false);
    return Drawer(
      child: SizedBox(
        width: width(context) * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Divider(),
            _EndDrawerItem(
              title: "SATIŞ",
              iconData: Icons.swipe_up_alt_outlined,
              onTap: () {
                closeDrawer();

                addCariTransaction(CariIslemTuru.satis);
              },
            ),
            _EndDrawerItem(
              title: "ALIŞ",
              iconData: Icons.swipe_down_alt_outlined,
              onTap: () {
                addCariTransaction(CariIslemTuru.alis);
              },
            ),
            _EndDrawerItem(
              title: "TAHSİLAT",
              iconData: Icons.switch_left_sharp,
              onTap: () {
                addCashOrEftAccountTransaction(GelirGiderTuru.gelir);
              },
            ),
            _EndDrawerItem(
              title: "ÖDEME YAP",
              iconData: Icons.switch_right_sharp,
              onTap: () {
                addCashOrEftAccountTransaction(GelirGiderTuru.gider);
              },
            ),
            _EndDrawerItem(
              title: "SİPARİŞ",
              iconData: Icons.select_all_outlined,
              onTap: () async {
                var islemTuru = await showAlertDialog<CariIslemTuru>(context,
                    title: "Sipariş Türünü Seçiniz",
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var item in CariIslemTuru.values)
                          ListTile(
                            title: Text(
                              item.stringValue,
                              style: const TextStyle(fontSize: 18),
                            ),
                            onTap: () =>
                                Navigator.pop<CariIslemTuru>(context, item),
                          ),
                        ListTile(
                          title: const Text(
                            "Siparişleri Gör",
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: () {
                            closeDrawer();
                            closeDrawer();

                            showDialog(
                              context: context,
                              builder: (context) {
                                return FutureBuilder<List<SiparisModel>>(
                                  future: DBUtils()
                                      .getModelListAsFuture<SiparisModel>([
                                    MapEntry("cariId",
                                        (viewModel.cariKart.id ?? "")),
                                  ]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return const CPIndicator();
                                    }
                                    var list = snapshot.data ?? [];

                                    /*  if(list.isEmpty) {
                                      return const ListTile(title: Text("Veri yok"),);
                                    } */
                                    return CustomAlertDialog(
                                      title: "Siparişler",
                                      content: (list.isEmpty)
                                          ? const ListTile(
                                              title: Text("Veri yok"))
                                          : ListView.builder(
                                              itemCount: list.length,
                                              itemBuilder: (context, index) {
                                                return SiparisTile(
                                                    siparisModel: list[index]);
                                              },
                                              shrinkWrap: true,
                                            ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Kapat"))
                                      ],
                                    );
                                  },
                                );
                              },
                            );

                            /*    showBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomSheet(
                                  onClosing: () {
                                    bas("kapandı");
                                  },
                                  builder: (context) {
                                    return FutureBuilder<List<SiparisModel>>(
                                        future: DBUtils().getModelListAsFuture<
                                            SiparisModel>([
                                          MapEntry("cariId",
                                              (viewModel.cariKart.id ?? "")),
                                          
                                        ]),
                                       /*  builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            var list = snapshot.data ?? [];
                                            return Container(
                                              height: height(context) / 2,
                                              child: ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: list.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Text(
                                                      list[index].cariAdi ??
                                                          "$index");
                                                },
                                              ),
                                            );
                                          } else {
                                            return const CPIndicator();
                                          }
                                        } */
                                        
                                        
                                        );
                                  },
                                );
                              },
                            ); */
                          },
                        )
                      ],
                    ));
                if (islemTuru != null) {
                  goToView(
                    context,
                    viewToGo: SiparisAddView(),
                    viewModel: SiparisAddViewModel.addNew(
                        cariIslemTuru: islemTuru, cariKart: viewModel.cariKart),
                  );
                }
              },
            ),
            _EndDrawerItem(
              title: "HESAP EKTRE",
              iconData: Icons.find_in_page_outlined,
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _EndDrawerItem(
                title: "KAPAT",
                textColor: Colors.red,
                iconData: Icons.exit_to_app,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  addCariTransaction(CariIslemTuru islemTuru, {bool isSiparis = false}) {
    return Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => CariTransactionAddViewModel.addNewHareket(
                  cariKart: viewModelUnlistened.cariKart,
                  cariIslemTuru: islemTuru),
              child: const CariTransactionAddView()),
        )).then((value) {
      // ignore: curly_braces_in_flow_control_structures
    });
  }

  void addCashOrEftAccountTransaction(GelirGiderTuru tur) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => AccountTransactionAddViewModel.addNew(
                  hesapHareketTuru: HesapHareketTuru.nakit,
                  cariKart: viewModelUnlistened.cariKart,
                  gelirGiderTuru: tur),
              child: AccountTransactionAddView()),
        ));
  }

  void closeDrawer() {
    Navigator.pop(context);
  }
}

class _EndDrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback? onTap;
  final Color? textColor;
  const _EndDrawerItem({
    Key? key,
    this.title = "",
    required this.iconData,
    this.onTap,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, color: textColor),
                ),
                const SizedBox(
                  width: 30,
                ),
                Icon(iconData),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
      onTap: onTap,
    );
  }
}
