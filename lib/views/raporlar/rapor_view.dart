import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/views/raporlar/detay_rapor/detay_rapor_view_model.dart';
import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';
import 'package:cari_hesapp_lite/views/raporlar/detay_rapor/detay_rapor_view.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_view.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_vm.dart';
import 'package:cari_hesapp_lite/views/raporlar/rapor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RaporView extends StatelessWidget {
  late RaporViewModel viewModel;
  late RaporViewModel viewModelUnlistened;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<RaporViewModel>(context);
    viewModelUnlistened = Provider.of<RaporViewModel>(context, listen: false);
    return DefaultTabController(
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
        ),
        body: FutureBuilder<List<CariIslemModel>>(
            future: viewModelUnlistened.tumIslemList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return TabBarView(children: [
                    ChangeNotifierProvider(
                        create: (context) =>
                            GenelRaporViewModel(snapshot.data!),
                        child: GenelRaporView()),
                    ChangeNotifierProvider(
                        create: (context) =>
                            DetayRaporViewModel(snapshot.data!),
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
