import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/utils/place_picker_package/lib/place_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../components/cp_indicators/cp_indicator.dart';
import '../../../components/scroll_column.dart';
import '../../../components/switch/primary_switch.dart';
import '../../../constants/constants.dart';
import '../cari_add_view/cari_add_view.dart';
import '../cari_add_view/cari_add_view_model/cari_add_view_model.dart';
import 'cari_list_view_model.dart/cari_list_view_model.dart';
import '../cari_view/cari_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin type implements CariView {}

// ignore: must_be_immutable
class CariListView extends StatelessWidget {
  String sorting = "konum";

  late CariListViewModel viewModel;

  CariListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CariListViewModel>(context);


    var list = viewModel.listBase;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(
        automaticallyImplyLeading: !viewModel.isSearchPressed,
        title: viewModel.isSearchPressed
            ? SearchInput(
                (str) async {
                  viewModel.hasSearchEntryIcon = const CPIndicator(size: 25);
                  await Future.delayed(const Duration(milliseconds: 500));

                  viewModel.hasSearchEntryIcon = const Icon(Icons.clear);
                  viewModel.filterText = str.trim();
                },
                hintText: viewModel.isCari ? "Cari Ara.." : "Tedarikçi Ara..",
                leadIconPressed: () {
                  viewModel.isSearchPressed = !viewModel.isSearchPressed;
                  viewModel.filterText = "";
                },
                hasSearchEntryIcon: viewModel.hasSearchEntryIcon,
                leadIcon: Icons.close,
              )
            : null,
        titleText: (viewModel.isCari ? "Cariler" : "Tedarikçiler"),
        actions: [
          !viewModel.isSearchPressed
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          viewModel.isSearchPressed =
                              !viewModel.isSearchPressed;
                        }),
                    PopupMenuButton<String>(
                      offset: Offset.zero,
                      initialValue: "unvan",
                      onSelected: (value) {
                        
                        viewModel.sortField = value;
                      },
                      icon: const Icon(Icons.sort),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                              child: Text("Konuma Göre"), value: "konum"),
                          const PopupMenuItem(
                              child: Text("İsime Göre"), value: "unvan"),
                        ];
                      },
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          MyPrimarySwitch(
            key: Key("${viewModel.isCari}"),
            value: viewModel.isCari,
            onChanged: (value) {
              viewModel.isCari = value;
            },
          )
        ],
      ),
      body: MyColumn(
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(),
            itemCount: list.length,
            key: viewModel.isCari ? const Key("Cari") : const Key("Firma"),
            /*   stream: _viewModel.getCariListAsStream(isCari,
              filterText: searchText, sortField: sorting), */

            /*  getClassReference<CariKart>()
              .where("cariTuru",
                  isEqualTo: isCari
                      ? CariTuru.cari.stringValue
                      : CariTuru.firma.stringValue) */
            //  .where("unvani", isGreaterThanOrEqualTo: "F")
            /*  .orderBy(
                sorting == "isim" ? "unvani" : "konum",
              ) */

            /* limitToFirst(10) */
            itemBuilder: (context, index) {
              CariKart cariKart = list[index];

              return Slidable(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          cariKart.unvani ?? "",
                          overflow: TextOverflow.visible,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontFamily: "Quicksand"),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Visibility(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Bakiye",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.black54,
                                        fontFamily: "Quicksand"),
                              ),
                              Text(
                                (cariKart.bakiye ?? 0).toStringAsFixed(2) +
                                    ("₺"),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.black54,
                                        fontFamily: "Quicksand"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 6,
                        child: Text(
                          cariKart.ekBilgi ?? "",
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.pop<CariKart>(context, cariKart);
                  },
                ),
                startActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    backgroundColor: Colors.blue,
                    icon: Icons.settings,
                    label: "Düzenle",
                    onPressed: (context) {},
                  ),
                  SlidableAction(
                    backgroundColor: Colors.blue,
                    icon: Icons.more_horiz,
                    label: "Daha Fazla",
                    onPressed: (context) {},
                  ),
                ]),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (context) => CariAddViewModel.addNewCari(
                          viewModel.cariTuru(viewModel.isCari)),
                      child: CariAddView())));
        },
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
