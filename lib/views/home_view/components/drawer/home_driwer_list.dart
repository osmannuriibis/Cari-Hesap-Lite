import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/cari/cari_list_view/cari_list_view.dart';
import 'package:cari_hesapp_lite/views/cari/cari_list_view/cari_list_view_model.dart/cari_list_view_model.dart';
import 'package:cari_hesapp_lite/views/cari/cari_view/cari_view_model.dart';
import 'package:cari_hesapp_lite/views/contribution_view/contribution_view.dart';
import 'package:cari_hesapp_lite/views/stok/stok_view/stok_view_model.dart';
import '../../../cari/cari_view/cari_view.dart';
import '../../../cari_transaction/cari_transaction_list/cari_trans_list_view.dart';
import '../../../cari_transaction/cari_transaction_list/cari_trans_list_view_model.dart';
import '../../../raporlar/rapor_view.dart';
import '../../../raporlar/rapor_view_model.dart';
import '../../../stok/stok_view/stok_view.dart';

import 'package:flutter/material.dart';

import '../../../../components/drawer/drawer_list_item.dart';

class HomeDrawerList extends StatelessWidget {
  const HomeDrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DrawerItem(
            label: "Ana Sayfa",
            icon: Icons.home_max_outlined,
            onTap: () {
              Navigator.pop(context);
            }),
        DrawerItem(
            label: "Cariler",
            icon: Icons.people_outline_rounded,
            onTap: () async {
              /* var asd = ProgressUtil(context);
              await method();
              asd.closeProgress(); */
              CariKart? cariKart = await goToView<CariKart?, CariListViewModel>(
                  context,
                  viewToGo: CariListView(),
                  viewModel: CariListViewModel());
              if (cariKart != null) {
                goToView(context,
                        viewToGo: CariView(),
                        viewModel: CariViewModel(cariKart))
                    .whenComplete(() {});
              }
            }),
        DrawerItem(
            label: "Stoklar",
            icon: Icons.amp_stories_outlined,
            onTap: () async {
              var stokKart = await getStokKartByPop(context);
              if (stokKart != null) {
                goToView(context,
                    viewToGo: StokView(), viewModel: StokViewModel(stokKart));
              }
            }),
        const Divider(),
        /*   Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "Yönetim",
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
        ), */
        const Divider(),
        DrawerItem(
            label: "Alış Satış",
            icon: Icons.swap_calls_outlined,
            onTap: () {
              goToView(context, viewToGo: CariTransactionListView(),
              viewModel: CariTransactionsListViewModel()
              );
            }),
        DrawerItem(
            label: "Raporlar",
            icon: Icons.document_scanner_outlined,
            onTap: () {
              goToView(context,
                  viewToGo: RaporView(), viewModel: RaporViewModel());
            }),
        const Divider(),
        /*   Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "Araçlar",
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
        ), */
        const Divider(),
        DrawerItem(
            label: "Öneride bulun",
            icon: Icons.comment_outlined,
            onTap: () {
              goToView(context, viewToGo: ContributionView());
            }),
        DrawerItem(
            label: "Hakkında",
            icon: Icons.info_outlined,
            onTap: () {
              showAboutDialog(context: context);
            }),

        /*   DrawerItem(
            label: "Ayarlar",
            onTap: () => goToView(context, viewToGo: AyarlarView())), */
      ],
    );
  }
}
