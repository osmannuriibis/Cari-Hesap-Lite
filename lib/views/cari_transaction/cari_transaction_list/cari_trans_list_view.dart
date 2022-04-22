import 'package:cari_hesapp_lite/components/cp_indicators/cp_indicator.dart';
import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/print.dart';

import '../../../../components/appbar/my_app_bar.dart';
import '../../../../enums/irsaliye_turu_enum.dart';
import '../../../../models/kartlar/cari_kart.dart';
import '../../../../utils/view_route_util.dart';
import '../../../../views/cari/cari_list_view/cari_list_view_model.dart/cari_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/buttons/fab.dart';
import '../../../../components/dialogs/custom_alert_dialog.dart';
import '../../../../components/switch/primary_switch.dart';
import '../../../../enums/cari_islem_turu.dart';
import '../../../../models/cari_islem.dart';
import 'package:cari_hesapp_lite/utils/place_picker_package/lib/widgets/search_input.dart';
import '../../cari/cari_list_view/cari_list_view.dart';
import '../transaction_adding_view/new_cari_trans_view/new_cari_trans_view.dart';
import '../transaction_adding_view/new_cari_trans_view/new_cari_trans_view_model.dart';
import 'cari_trans_list_view_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CariTransactionListView extends StatelessWidget {
  late CariTransactionsListViewModel viewModel;

  CariTransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CariTransactionsListViewModel>(context);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      //  extendBody: true,
      appBar: MyAppBar(
        automaticallyImplyLeading: !viewModel.isSearchPressed,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: viewModel.isSearchPressed
              ? SearchInput(
                  (str) async {
                    viewModel.hasSearchEntryIcon = const CPIndicator(size: 25);
                    await Future.delayed(const Duration(milliseconds: 500));

                    viewModel.hasSearchEntryIcon = const Icon(Icons.clear);

                    viewModel.filterText = str.trim();
                  },
                  hintText: "${viewModel.islemTuru.stringValue} Ara...",
                  leadIconPressed: () {
                    viewModel.isSearchPressed = !viewModel.isSearchPressed;
                    viewModel.filterText = "";
                  },
                  hasSearchEntryIcon: viewModel.hasSearchEntryIcon,
                  leadIcon: Icons.close,
                )
              : Text(
                  "${viewModel.islemTuru.stringValue} İşlemleri",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.amber[900], fontSize: 17),
                ),
        ),
        actions: [
          !viewModel.isSearchPressed
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    viewModel.isSearchPressed = !viewModel.isSearchPressed;
                  })
              : const SizedBox.shrink(),
          MyPrimarySwitch(
            value: viewModel.islemTuru == CariIslemTuru.satis,
            onChanged: (bool value) {
              viewModel.islemTuru =
                  (value ? CariIslemTuru.satis : CariIslemTuru.alis);
            },
          ),
        ],
      ),

      /* MyAppBar(
        titleText: ("${viewModel.islemTuru.stringValue} İşlemleri"),
        actions: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              MyPrimarySwitch(
                value: viewModel.islemTuru == CariIslemTuru.satis,
                onChanged: (bool value) {
                  bas("switch ontap");
                  bas(value);
                  viewModel.islemTuru =
                      (value ? CariIslemTuru.satis : CariIslemTuru.alis);
                },
              ),
            ],
          )
        ],
      ),
       */
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: viewModel.listTransactions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                CariIslemModel cariIslem = viewModel.listTransactions[index];

                return ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cariIslem.cariUnvani ?? ""),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                              cariIslem.toplam != null
                                  ? cariIslem.toplam!.toStringAsFixed(2) + " ₺"
                                  : "",
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.red)),
                        ),
                      ]),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cariIslem.evrakTuru != null
                        ? cariIslem.evrakTuru!.stringValue
                        : "-"),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  /*   leading: CircleAvatar(
                  child: cariIslem.imagePath != null
                      ? Image.network(cariIslem.imagePath)
                      : Center(
                          child: Text(cariIslem.unvani[0].toUpperCase()),
                        ),
                    ), */
                  onTap: () async {
                    var cariKart =
                        await DBUtils().getCariKartById(cariIslem.cariId!);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (context) => CariTransactionAddViewModel
                                    .showExistHareket(cariIslem, cariKart),
                                child: const CariTransactionAddView())));
                  },
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ),
      ),
      floatingActionButton: FAB(
        onPressed: () async {
          var res = await showAlertDialog<bool?>(context,
              title: "İşlem",
              content: Text("${viewModel.islemTuru.stringValue} Ekle"),
              actions: [
                TextButton(
                  child: const Text("TAMAM"),
                  onPressed: () async {
                    //CariİşlemView'da yeni [islemTuru] işlemi=>

                    Navigator.pop(context, true);
                  },
                ),
              ]);

          if (res.exactlyTrue) {
            CariKart? carikart = await goToView<CariKart, CariListViewModel>(
                context,
                viewToGo: CariListView(),
                viewModel: CariListViewModel());

            if (carikart == null) return;

            var viewModelAddCariTransaction =
                CariTransactionAddViewModel.addNewHareket(
              cariIslemTuru: viewModel.islemTuru,
              cariKart: carikart,
            );

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (context) => viewModelAddCariTransaction,
                      child: const CariTransactionAddView()),
                ));
          }

          // Navigator.pop(contextt);
        },
      ),
    );
  }
}

