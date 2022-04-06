import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/bottom_nav_bar/curved_bnb.dart';
import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/views/raporlar/detay_rapor/detay_rapor_view.dart';
import 'package:cari_hesapp_lite/views/raporlar/gecmis_rapor/gecmis_rapor.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_view.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_vm.dart';
import 'package:cari_hesapp_lite/views/raporlar/rapor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RaporView extends StatelessWidget {
late  RaporViewModel viewModel;
  late RaporViewModel viewModelUnlistened;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<RaporViewModel>(context);
    viewModelUnlistened = Provider.of<RaporViewModel>(context, listen: false);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MyAppBar(
          titleText: "Raporlar",
          bottom: const TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              indicatorColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                decorationColor: Colors.blue,
              ),
              unselectedLabelColor: Colors.black54,
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Genel Rapor",
                ),
                Tab(
                  text: "Detay Raporlar",
                ),
                Tab(
                  text: "Geçmiş Raporlar",
                ),
              ]),
        ),
        body: FutureBuilder<List<QueryDocumentSnapshot>>(
            future: viewModelUnlistened.tumIslemList,
            builder: (context, snapshot) {
              bas("snapshot özellikleri");
              bas(snapshot.connectionState);
              bas(snapshot.hasData);
              bas(snapshot.data);
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return TabBarView(children: [
                    ChangeNotifierProvider(
                        create: (context) =>
                            GenelRaporViewModel(snapshot.data!),
                        child: GenelRaporView()),
                    DetayRaporView(),
                    GecmisRaporView()
                  ]);
                } else {
                  return const Text("Veri Yok");
                }
              } else {
                return const CPIndicator();
              }
            }),
        persistentFooterButtons: [
          CloseButton(
            onPressed: () async {
            
              /* 
              var date = DateTime.now();

              Map<int, Map<int, List<String>>> map = {
                2020: {
                  11: ["casd"],
                  12: ["data"]
                },
                2021: null,
                2022: null
              };

              map.update(
                date.year,
                (aylikMap) //dönüş değeri aylik map istiyor

                {
                  if (aylikMap == null) aylikMap = {};
                  bas("aylikMap");
                  bas(aylikMap);
                  aylikMap.update(
                    date.month,
                    (value) {
                      value.add(date.day.toString());
                      return value;
                    },
                    ifAbsent: () => [date.day.toString()],
                  );
                  return aylikMap;
                },
                ifAbsent: () {
                  return {
                    date.month: ["${date.day}"]
                  };
                },
              );

              bas(map); */
            },
          )
        ],
      ),
    );
  }
}
