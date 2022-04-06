import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/buttons/base_primary_button.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
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
                actions: [IconButton(onPressed: () {
                        goToView(context,
                          viewToGo: const StokAddView(),
                          viewModel: StokAddViewModel.showExistStok(
                              stokKart: viewModel.stokKart));
                }, icon: const Icon(Icons.edit_outlined))],
          ),
          body: TabBarView(children: [
            MyColumn(
              children: [
                MyCard(
                  child: 
                  
                  MyColumn(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text("Stok Miktar Bilgileri"),
                      ),
                      if(viewModel.stokKart.stokTipi!)
                      for (var item in viewModel.depoList)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              item.key,
                              style: context.textTheme.headline6,
                            ),
                            Text(
                              item.value.toStringAsFixed(2),
                              style: context.textTheme.headline6,
                            )
                          ],
                        )
                        else 
                        const Text("Hizmet Ürünü (Stoksuz)")
                    ],
                  )  ,
                ),
                MyBaseButton(
                    onPressed: () {
                
                    },
                    buttonText: "Düzenle")
              ],
            ),
            MyCard(
              child: MyColumn(
                children: [
                  for (var item in viewModel.listStokHareket)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text((item.miktar ?? 0).toStringAsFixed(2) +
                            " " +
                            (viewModel.stokKart.birim ?? "")),
                        Text(item.cariIslemTuru == CariIslemTuru.alis
                            ? "Giriş"
                            : "Çıkış"),
                      ],
                    )
                ],
              ),
            ),
          ])),
    );
  }
}
