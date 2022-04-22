import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../components/dialogs/show_alert_dialog.dart';
import '../../../../../components/text_fields/price_text.dart';
import '../../../../../constants/constants.dart';
import '../../../../../models/kartlar/cari_kart.dart';
import '../../../cari_add_view/cari_add_view.dart';
import '../../../cari_add_view/cari_add_view_model/cari_add_view_model.dart';
import '../../cari_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CariHomePage extends StatelessWidget {
  late CariKart model;

  CariHomePage({Key? key}) : super(key: key);

  int get telLength => (model.telNo?.length ?? 0); //TODO
  List<Widget> telWidgetList = [];
  late CariViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CariViewModel>(context);
    model = viewModel.cariKart;

    return Container(
      alignment: AlignmentDirectional.topCenter,
      color: Colors.grey[100],
      child: Column(
        children: [
          BakiyeCard(cariBakiye: model.bakiye ?? 0),
          //_buildRow(context, iconData: Icons.phone, textData: model.telNo[0]),
          ..._buildTelRow(context),

          _buildRow(
            context,
            iconData: Icons.email,
            textData: model.email ?? "",
            onPressed: () {
              viewModel.openEmail();
            },
          ),
          _buildRow(
            context,
            iconData: FontAwesomeIcons.mapMarkerAlt,
            textData: model.adres ?? "",
            onPressed: () {
              viewModel.getDirection();
            },
          ),
          const Divider(),
          ElevatedButton(
            /*  color: kPrimaryColor,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2), */
            child: const Text(
              "Düzenle",
              style: TextStyle(color: Colors.black87),
            ),
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.2),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (context) =>
                              CariAddViewModel.showExistCari(model),
                          child: CariAddView())));
            },
          ),
          const Divider(height: 20),
          ElevatedButton(
            /* 
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2), */
            child: const Text(
              "Sil",
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () async {
              if ((await showAlertDialog<bool?>(context,
                      title: "UYARI",
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${viewModel.cariKart.cariTuru!.name.toCapitalize()} tamamen silicenek.\nDevam etmek istiyor musunuz?"),
                      ),
                      actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text(
                          "Vazgeç",
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text("Evet")),
                  ]))
                  .exactlyTrue) {
                viewModel.deleteCariKart();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context,
      {required IconData iconData,
      required String textData,
      required VoidCallback onPressed}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(iconData),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Expanded(
              child: Text(
                textData,
                style: const TextStyle(fontSize: 20),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTelRow(
    BuildContext context,
  ) {
    int i = 0;

    do {
      telWidgetList.add(_buildRow(
        context,
        iconData: Icons.phone,
        textData: model.telNo != null
            ? model.telNo![++i - 1]!
            : "", //TODO: telNo 2 adet map'a cevirilecek
        onPressed: () {
          viewModel.makeCall();
        },
      ));
    } while (i < telLength);

    return telWidgetList;
  }
}

class BakiyeCard extends StatefulWidget {
  const BakiyeCard({
    Key? key,
    required num cariBakiye,
  }) : super(key: key);

  @override
  _BakiyeCardState createState() => _BakiyeCardState();
}

class _BakiyeCardState extends State<BakiyeCard> {
  bool isBalanceVisible = false;
  String hidenWord = "**.**";
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CariViewModel>(context);
    var viewModelUnlistened =
        Provider.of<CariViewModel>(context, listen: false);

    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.account_balance),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Row(
                  children: [
                    const Text(
                      "Bakiye: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    PText(
                      "${(isBalanceVisible) ? ((viewModel.cariKart.bakiye ?? 0).toStringAsFixed(2) + "₺") : (hidenWord)} ",
                      fontSize: 17,
                    )
                  ],
                ),
              ],
            ),
            IconButton(
              icon: (isBalanceVisible)
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                isBalanceVisible = !isBalanceVisible;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
