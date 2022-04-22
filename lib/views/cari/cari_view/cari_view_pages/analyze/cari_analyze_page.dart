/* 
import 'package:cari_hesapp_lite/views/cari/cari_view/cari_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CariAnalyzePage extends StatelessWidget {
late  CariViewModel viewModel;
  late CariViewModel viewModelUnlistened;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CariViewModel>(context);
    viewModelUnlistened = Provider.of<CariViewModel>(context, listen: false);
    return 
    Text("Yapılacak")
    /* FutureBuilder<QuerySnapshot>(
        future: viewModelUnlistened.getCariIslemlerQuery().get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<QueryDocumentSnapshot>? list = snapshot.data?.docs;
            if (list != null) {
              

            var islemList = list
                .map<ChartModel>((e) => ChartModel(
                    tutar: e.get("sonToplam"),
                    tarih: (e.get("duzenlemeTarihi") as int).toDateTime))
                .toList();
            return CustomCard(
                //TODO
                child: LimitedBox(
              maxHeight: width(context),
              child: Text("Chart Yapılacak")/* MyLineChart(getChartSpecForLine(
                chartTitle: "İşlemler",
                islemDatas: islemList,
                periyot: ChartPeriyot.aylik,
                yEksenFormat: "₺",
                domainFn: (datum, index) => datum.tarih!,
                measureFn: (datum, index) => datum.tutar!,
              ) */),
            );
            }else
return Center(child: Text("Veri Yok"));
          } else if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Center(child: Text("Veri Yok"));
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        }) */;
  }
}
 */