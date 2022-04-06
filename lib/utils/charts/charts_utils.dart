/* import 'package:charts_flutter/flutter.dart' as C;
import 'package:charts_flutter/flutter.dart';
import 'package:intl/intl.dart';

import 'package:eldeki_hesap/utils/print.dart';

enum ChartPeriyot {
  aylik,
  haftalik /* ,otuzGunluk,yillik */
}

class ChartSpec {
  ///x axis => int tarih
  ///y axis => tutar
  List/* <Series<dynamic, String>> */? seriesList;

  String? chartTitle;
  String? yBirim;

  List<C.ChartBehavior>? behaviors;
  int? prMinTickCount;
  int? prMaxTickCount;
  int? labelRotation;

  ChartSpec({
    this.seriesList,
    this.chartTitle,
    this.yBirim,
    this.behaviors,
    this.prMinTickCount,
    this.prMaxTickCount,
     this.labelRotation = 45,
  });
}

class ChartModel {
  String? adi;
  DateTime? tarih;

  num ?tutar;
  ChartModel({
    this.adi,
    this.tarih,
    this.tutar,
  });
}

getChartSpect(List<ChartModel> islemDatas,
    { //ChartPeriyot periyot,
    String yBirim = "₺",
    String chartTitle = "",
    String Function(ChartModel datum, int index)? domainFn,
    num Function(ChartModel datum, int index)? measureFn,
    List<ChartBehavior>? behaviors}) {
  if (islemDatas.isNotEmpty) if (islemDatas.first.tarih != null)
    islemDatas.sort((e, y) => e.tarih!.compareTo(y.tarih!));

  var _seriesList = [
    Series(id: "id", data: islemDatas, domainFn: domainFn, measureFn: measureFn)
  ];

  return ChartSpec(
      seriesList: _seriesList,
      yBirim: yBirim,
      chartTitle: chartTitle,
      behaviors: behaviors);
}

ChartSpec getChartSpecForLine(
    {ChartPeriyot? periyot,
   required List<ChartModel> islemDatas,
    //List<C.Series<T,DateTime>> islemSeries,
    /* List<Map> modelMapList,
   String fieldAsDomainAxis ,
  String  fieldAsMeasureAxis  */
    String yEksenFormat = "₺",
    String chartTitle = "",
    DateTime Function(ChartModel datum, int index)? domainFn,
    num Function(ChartModel datum, int index)? measureFn}) {
  islemDatas.sort((e, y) => e.tarih!.compareTo(y.tarih!));

  var ilkTarih =
      islemDatas.length == 0 ? DateTime.now() : islemDatas.first.tarih;

  var simdi = DateTime.now();
  var buAyinSonDemi = DateTime(
    simdi.year,
    simdi.month + 1,
  ).subtract(Duration(seconds: 1));

  int spotQuantity = 1;

  switch (periyot) {
    case ChartPeriyot.aylik:
      while (DateTime(ilkTarih!.year, ilkTarih.month + spotQuantity)
          .isBefore(buAyinSonDemi)) {
        spotQuantity++;
      }
      break;
    default:
  }

  var realIslemDatas = <ChartModel>[];
  if (islemDatas.length > 0)
    for (var i = 0; i < spotQuantity; i++) {
      double tutar = 0;
      var islemAyi = DateTime(ilkTarih!.year, ilkTarih.month + i);

      for (var data in islemDatas) {
        if (DateTime(data.tarih!.year, data.tarih!.month)
            .isAtSameMomentAs(DateTime(islemAyi.year, islemAyi.month)))
          tutar = tutar + (data.tutar ?? 0);
      }
      bas("tutar");
      bas(tutar);

      realIslemDatas.add(ChartModel(tarih: islemAyi, tutar: tutar));
    }

/* Series<TimeSeriesSales, DateTime> */
  var format = DateFormat("MMM");
  var _seriesList = <C.Series<ChartModel, DateTime>>[];
  _seriesList.add(C.Series(
    id: "TimeChart ",
    data: realIslemDatas,
    domainFn: domainFn,
    measureFn: measureFn,
  ));

  return ChartSpec(
      seriesList: _seriesList, chartTitle: chartTitle, yBirim: yEksenFormat);
}
 */