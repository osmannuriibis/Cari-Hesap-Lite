import 'package:cari_hesapp_lite/components/drop_down_button_form/dropdown_btn_form_field.dart';
import 'package:cari_hesapp_lite/views/raporlar/genel_rapor/genel_rapor_vm.dart';
import 'package:cari_hesapp_lite/views/raporlar/rapor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/card/custom_card.dart';
import '../../../components/scroll_column.dart';

class GenelRaporView extends StatelessWidget {
  late GenelRaporViewModel viewModel;
  late GenelRaporViewModel viewModelUnlistened;
  late RaporViewModel viewModelBase;
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<GenelRaporViewModel>(context);
    viewModelUnlistened =
        Provider.of<GenelRaporViewModel>(context, listen: false);

    viewModelBase = Provider.of<RaporViewModel>(context);

    viewModelUnlistened.viewModelBase = viewModelBase;

    this.context = context;
    return MyColumn(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row(
          Column(
            children: [
              const Align(
                  alignment: Alignment.center, child: Text("Son 30 günlük")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Satış"),
                  Text("Tahsilat"),
                ],
              )
            ],
          ),
          TextEditingController(
              text: viewModel.son30GunlukSatis.toStringAsFixed(2) + "₺"),
          TextEditingController(
              text: viewModel.son30GunlukTahsilat.toStringAsFixed(2) + "₺"),
        ),
        _row(
            Column(
              children: [
                const Align(
                    alignment: Alignment.center, child: Text("Son 7 günlük")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Satış"),
                    Text("Tahsilat"),
                  ],
                )
              ],
            ),
            TextEditingController(
                text: viewModel.son7GunlukSatis.toStringAsFixed(2) + "₺"),
            TextEditingController(
                text: viewModel.son7GunlukTahsilat.toStringAsFixed(2) + "₺")),
        BaseBorderedDropdownBtnFormField<int>(
          value: viewModel.dropdownValue,
          onChanged: (value) {
            if (value != null) viewModelUnlistened.dropdownValue = value;
          },
          items: [
            for (var yil in viewModel.aylikIslemlerInYil.keys)
              DropdownMenuItem(
                alignment: Alignment.center,
                child: Text(yil.toString()),
                value: yil,
              ),
          ],
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          onHorizontalDragDown: (details) {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _row(
                  const Text("Toplam Satış"),
                  TextEditingController(
                      text: viewModel.toplamByYil.toString() + "₺")),
              _row(
                  const Text("Aylık Ortalama Satış"),
                  TextEditingController(
                      text:
                          viewModel.aylikOrtalamaSatisByYil.toStringAsFixed(2) +
                              "₺/ay")),
              _row(
                  const Text("Günlük Ortalama Satış"),
                  TextEditingController(

                    
                      text: viewModel.gunlukOrtSatis.toStringAsFixed(2) +  "₺/gün"
                          
                          )),
              _row(
                  const Text("Satış Miktarı"),
                  TextEditingController(
                      text: viewModel.satisMiktari.toString())),
            ],
          ),
        ),
        /*       MyBarChart(
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
                chartTitle: "Never Happend")), */
      ],
    );
  }

  Padding _row(Widget label, TextEditingController controller,
      [TextEditingController? controller2]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: label,
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(),
                  style: const TextStyle(fontFamily: "Monoisome"),
                  controller: controller,
                  readOnly: true,
                  enabled: false,
                  onTap: null,
                ),
              ),
              if (controller2 != null)
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(),
                    style: const TextStyle(
                        fontFamily:
                            "Monoisome" /* , fontWeight: FontWeight.bold */),
                    controller: controller2,
                    readOnly: true,
                    enabled: false,
                    onTap: null,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
