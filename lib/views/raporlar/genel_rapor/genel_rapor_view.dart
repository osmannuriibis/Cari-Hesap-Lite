import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/drop_down_button_form/dropdown_btn_form_field.dart';
import 'package:cari_hesapp_lite/utils/charts/bar_chart.dart';
import 'package:cari_hesapp_lite/utils/charts/charts_utils.dart';
import 'package:cari_hesapp_lite/utils/charts/line_chart.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_vm.dart';
import 'package:cari_hesapp_lite/views/raporlar/rapor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenelRaporView extends StatelessWidget {
late  GenelRaporViewModel viewModel;
  late GenelRaporViewModel viewModelUnlistened;
 late  RaporViewModel viewModelBase;
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<GenelRaporViewModel>(context);
    viewModelUnlistened =
        Provider.of<GenelRaporViewModel>(context, listen: false);

    viewModelBase = Provider.of<RaporViewModel>(context);

    viewModelUnlistened.viewModelBase = viewModelBase;

    this.context = context;
    bas(viewModel.aylikIslemlerInYil.keys.first);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseBorderedDropdownBtnFormField<int>(
              value: viewModel.dropdownValue,
              onChanged: (value) {
               if(value != null) viewModelUnlistened.dropdownValue = value;
              },
              items: [
                for (var yil in viewModel.aylikIslemlerInYil.keys)
                  DropdownMenuItem(
                    child: Text(yil.toString()),
                    value: yil,
                  ),
              ],
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              onHorizontalDragDown: (details) {
                bas(details.globalPosition);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _row(
                      "Toplam Satış",
                      TextEditingController(
                          text: viewModel.toplamByYil.toString())),
                  _row(
                      "Aylık Ortalama Satış",
                      TextEditingController(
                          text: viewModel.aylikOrtalamaSatisByYil
                              .toStringAsFixed(2))),
                  _row(
                      "Günlük Ortalama Satış",
                      TextEditingController(
                          text: viewModel.gunlukOrtSatis.toStringAsFixed(2))),
                  _row(
                      "Satış Miktarı",
                      TextEditingController(
                          text: viewModel.satisMiktari.toString())),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyCard(
                    height: 200,
                    aspectRatio: 1.5,
                    child: null/* MyBarChart(
                        chartSpec: getChartSpect(
                            viewModel.aylikSatisInAyByYil.entries
                                .map<ChartModel>((e) => ChartModel(
                                    adi: "${e.key}/${viewModel.dropdownValue}",
                                    tutar: e.value,
                                    tarih: DateTime(
                                        viewModel.dropdownValue, e.key)))
                                .toList(),
                            domainFn: (datum, index) => datum.adi,
                            measureFn: (datum, index) => datum.tutar,
                            yBirim: "₺",
                            chartTitle: "Never Happend")) */)
             

                ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  Padding _row(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(label),
          ),
          TextFormField(
            decoration:
                InputDecoration(contentPadding: EdgeInsets.only(left: 10)),
            style:
                TextStyle(fontFamily: "Pragmata", fontWeight: FontWeight.bold),
            scrollPadding: EdgeInsets.all(40),
            controller: controller,
            readOnly: true,
            onTap: null,
          ),
        ],
      ),
    );
  }
}
