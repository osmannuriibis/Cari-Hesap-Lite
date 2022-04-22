// ignore_for_file: must_be_immutable

import 'package:cari_hesapp_lite/enums/gelir_gider_turu.dart';
import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/hesap_hareket.dart';
import 'package:cari_hesapp_lite/models/islemler_model.dart';
import 'package:cari_hesapp_lite/utils/date_format.dart';
import 'package:cari_hesapp_lite/utils/dialogs/dialogs.dart';
import 'package:cari_hesapp_lite/views/raporlar/detay_rapor/detay_rapor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../components/card/custom_card.dart';
import '../../../components/scroll_column.dart';
import '../../../enums/cari_islem_turu.dart';

class DetayRaporView extends StatelessWidget {
  late DetayRaporViewModel viewModel;

  DetayRaporView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<DetayRaporViewModel>(context);

    return MyColumn(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                tooltip: MaterialLocalizations.of(context).previousPageTooltip,
                onPressed: () {
                  viewModel.previousDay();
                },
                icon: const Icon(FontAwesomeIcons.chevronLeft),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var day = await showDateDialog(context,
                    initialDate: viewModel.selectedDay);
                if (day != null) {
                  viewModel.selectedDay = day;
                  viewModel.notifyListeners();
                }
              },
              child: Text(
                dateTimeFormatterToString(viewModel.selectedDay),
                style: context.textTheme.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                tooltip: MaterialLocalizations.of(context).nextPageTooltip,
                onPressed: viewModel.selectedDay.day == DateTime.now().day &&
                        viewModel.selectedDay.month == DateTime.now().month
                    ? null
                    : () {
                        viewModel.nextDay();
                      },
                icon: const Icon(FontAwesomeIcons.chevronRight),
              ),
            ),
          ],
        ),
      
        /*     Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [Text("data")],
          ),
        ), */
        MyCard(
          padding: const EdgeInsets.all(4),
          child: MyColumn(
            children: [
              const _RowCustom(
                t1: "Müşteri Adı",
                t2: "İşlem",
                t3: "Verilen",
                t4: "Alinan",
              ),
              const Divider(),
              for (var item in viewModel.getList()) _Row(item: item),
              const Divider(),
              const _RowCustom(
                t2: "Toplam",
                t3: "Verilen",
                t4: "Alinan",
              ),
              _RowCustom(
                t3: viewModel.toplamVerilen(),
                t4: viewModel.toplamAlinan(),
              ),
              const Divider(),
              _RowCustom(
                t2: "Toplam",
                t3: "Tutar",
                t4: viewModel.farkTot.toStringAsFixed(2) + "₺",
              )
            ],
          ),
        )
      ],
    );
  }
}

class _RowCustom extends StatelessWidget {
  final String? t1, t2, t3, t4;
  const _RowCustom({
    Key? key,
    this.t1,
    this.t2,
    this.t3,
    this.t4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 6,
            child: Text(
              t1 ?? "",
            )),
        Expanded(
          flex: 3,
          child: Text(
            t2 ?? "",
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            t3 ?? "",
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            t4 ?? "",
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Islemler item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 6,
            child: Text(
              item.cariUnvani ?? "",
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(item.runtimeType == CariIslemModel
                ? ((item as CariIslemModel).islemTuru?.stringValue) ?? ""
                : ((item as HesapHareketModel).gelirGiderTuru?.stringValue) ??
                    ""),
          ),
          Expanded(
            flex: 3,
            child: Text(item.runtimeType == CariIslemModel
                ? ((item as CariIslemModel).islemTuru == CariIslemTuru.satis
                    ? (item as CariIslemModel).toplamTutar!.toStringAsFixed(2) +
                        item.paraBirimi.getSembol
                    : "-")
                : ((item as HesapHareketModel).gelirGiderTuru ==
                        GelirGiderTuru.gider)
                    ? (item as HesapHareketModel)
                            .toplamTutar!
                            .toStringAsFixed(2) +
                        item.paraBirimi.getSembol
                    : "-"),
          ),
          Expanded(
            flex: 3,
            child: Text(item.runtimeType == CariIslemModel
                ? ((item as CariIslemModel).islemTuru == CariIslemTuru.alis
                    ? (item as CariIslemModel).toplamTutar!.toStringAsFixed(2) +
                        item.paraBirimi.getSembol
                    : "-")
                : ((item as HesapHareketModel).gelirGiderTuru ==
                        GelirGiderTuru.gelir)
                    ? (item as HesapHareketModel)
                            .toplamTutar!
                            .toStringAsFixed(2) +
                        item.paraBirimi.getSembol
                    : "-"),
          ),
        ],
      ),
    );
  }
}
