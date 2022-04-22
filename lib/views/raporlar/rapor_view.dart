import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/views/raporlar/detay_rapor/detay_rapor_view_model.dart';
import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';
import 'package:cari_hesapp_lite/views/raporlar/detay_rapor/detay_rapor_view.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_view.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_vm.dart';
import 'package:cari_hesapp_lite/views/raporlar/rapor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/islemler_model.dart';

class RaporView extends StatelessWidget {
  late RaporViewModel viewModel;
  late RaporViewModel viewModelUnlistened;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<RaporViewModel>(context);
    viewModelUnlistened = Provider.of<RaporViewModel>(context, listen: false);
    return DefaultTabController(
      key: viewModel.tabController,
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
          titleText: "Raporlar",
          bottom: TabBar(
              indicatorColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                  decorationColor: Colors.blue,
                  fontFamily:
                      Theme.of(context).textTheme.bodyText1?.fontFamily),
              unselectedLabelColor: Colors.black54,
              isScrollable: true,
              tabs: const [
                Tab(
                  text: "Genel",
                ),

                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Tab(
                    text: "Detay",
                  ),
                ),
                //Tab(text: "Geçmiş Raporlar")
              ]),
          actions: [
            Builder(builder: (context) {
              bas("DefaultTabController.of(context)?.index");
              bas(DefaultTabController.of(context)?.index);
              return IconButton(
                  onPressed: /*((DefaultTabController.of(context)?.index ?? -1) !=
                          1)
                       ? null
                      : */
                      () {
            /*         if ((DefaultTabController.of(context)?.index ?? -1) == 1) {
                      showAlertDialog(context,
                          title: "İşlem Filtre",
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  value: viewModel.satis, //viewModel.satis,
                                  onChanged: (val) {
                                    bas(val);
                                    viewModel.satis = val;
                                    viewModel.notifyListeners();
                                  }),
                            ],
                          ));
                    } */
                  },
                  icon: const Icon(Icons.filter_list_outlined));
            })
          ],
        ),
        body: FutureBuilder<List<Islemler>>(
            future: viewModelUnlistened.tumIslemList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return TabBarView(children: [
                    ChangeNotifierProvider(
                        create: (context) => GenelRaporViewModel(
                            snapshot.data!
                                .where((element) =>
                                    element.runtimeType == CariIslemModel)
                                .map((e) => e as CariIslemModel)
                                .toList(),
                            snapshot.data!
                                .where((element) =>
                                    element.runtimeType == HesapHareketModel)
                                .map((e) => e as HesapHareketModel)
                                .toList()),
                        child: GenelRaporView()),
                    ChangeNotifierProvider(
                        create: (context) => DetayRaporViewModel(
                                snapshot.data!, [
                              viewModel.satis,
                              viewModel.alis,
                              viewModel.gelir,
                              viewModel.gider
                            ]),
                        child: DetayRaporView()),
                    //  GecmisRaporView()
                  ]);
                } else {
                  return const Text("Veri Yok");
                }
              } else {
                return const CPIndicator();
              }
            }),
      ),
    );
  }
}
