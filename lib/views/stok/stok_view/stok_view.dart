import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/buttons/base_primary_button.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/components/text_fields/my_field_with_label.dart';
import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/stok/stok_add_view/stok_add_view.dart';
import 'package:cari_hesapp_lite/views/stok/stok_add_view/view_model/stok_add_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../models/kartlar/stok_kart.dart';
import 'stok_view_model.dart';
import 'package:flutter/material.dart';

class StokView extends StatelessWidget {
  late StokViewModel viewModel;
  late StokKart stokKart;
  StokView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<StokViewModel>(context);
    stokKart = viewModel.stokKart;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: MyAppBar(
            titleText: (stokKart.adi ?? ""),
            bottom: const TabBar(
                unselectedLabelColor: Colors.black45,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black87,
                labelPadding: EdgeInsets.all(0),
                tabs: [
                  Tab(
                    child: Text("Ürün Bilgileri"),
                  ),
                  Tab(
                    child: Text("Ürün Hareketleri"),
                  ),
                ]),
            actions: [
              IconButton(
                  onPressed: () {
                    goToView(context,
                        viewToGo: const StokAddView(),
                        viewModel: StokAddViewModel.showExistStok(
                            stokKart: viewModel.stokKart));
                  },
                  icon: const Icon(Icons.edit_outlined))
            ],
          ),
          body: TabBarView(children: [
            MyColumn(
              children: [
                MyCard(
                    child: Column(
                  children: [
                    _Row(title: "Ürün Adı", value: viewModel.stokKart.adi),
                    const Divider(),
                    _Row(
                        title: "Ürün Kodu", value: viewModel.stokKart.urunKodu),
                    _Row(title: "Barkod", value: viewModel.stokKart.barkod),
                    _Row(title: "Kategori", value: viewModel.stokKart.kategori),
                    _Row(title: "Birim", value: viewModel.stokKart.birim),
                    const Divider(),
                    _Row(
                        title: "Alış Fiyatı",
                        value: (viewModel.stokKart.alisFiyati ?? 0)
                            .toStringAsFixed(2)),
                    _Row(
                        title: "Satış Fiyatı",
                        value: (viewModel.stokKart.satisFiyati ?? 0)
                            .toStringAsFixed(2)),
                    _Row(
                        title: "Kdv Oranı",
                        value:
                            ("%" + (viewModel.stokKart.kdv ?? 0).toString())),
                  ],
                )),
                MyBaseButton(onPressed: () {}, buttonText: "Düzenle")
              ],
            ),
            MyCard(
              child: MyColumn(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Müşteri Adı",
                            style: TextStyle(fontSize: 17),
                          )),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Miktar",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "İşlem",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  for (var item in viewModel.listStokHareket)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              item.cariAdi ?? "",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              (item.miktar ?? 0).toStringAsFixed(2) +
                                  " " +
                                  (viewModel.stokKart.birim ?? ""),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              item.cariIslemTuru == CariIslemTuru.alis
                                  ? "Giriş"
                                  : "Çıkış",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ])),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;

  final String? value;

  const _Row({
    Key? key,
    required this.title,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(flex: 2, child: _Text(title)),
          Expanded(flex: 3, child: _Text(": " + (value ?? ""))),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String data;

  const _Text(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: context.textTheme.headline6,
    );
  }
}
