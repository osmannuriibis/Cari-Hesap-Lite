import '../../../../components/appbar/my_app_bar.dart';
import '../../../../components/fsal/special_firebase_list.dart';
import '../../../../services/firebase/database/utils/database_utils.dart';

import '../../../constants/constants.dart';
import '../../../models/kartlar/stok_kart.dart';

import '../stok_add_view/stok_add_view.dart';
import '../stok_add_view/view_model/stok_add_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StokListView extends StatelessWidget {
  const StokListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: MyAppBar(
        titleText: "Stok Seç",
      ),
      body: SafeArea(child: StoksList()),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        label: const Text("Yeni Ekle", style: TextStyle(color: Colors.black)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (context) => StokAddViewModel.addNewStok(),
                    child: const StokAddView()),
              ));
        },
        icon: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

// ignore: must_be_immutable
class StoksList extends StatelessWidget {
  String orderByChild = 'adi';
  late StokKart stokKart;

  StoksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirestoreColList(
      defaultChild: const Center(
        child: CircularProgressIndicator(backgroundColor: kPrimaryColor)
      ),
      query: DBUtils().getClassReference<StokKart>(),
      itemBuilder: (context, snapshot, index) {
        if (snapshot?.data() != null) {
          var map = snapshot!.data();
          stokKart = StokKart.fromMap(map);
          return _ListTileItem(
            stokKart: stokKart,
            onTap: () {
              Navigator.pop(context, StokKart.fromMap(map));
            },
          );
        }
        return const ListTile(
          title: Text("Veri yok")
        );
      },
    );
  }
}

class _ListTileItem extends StatelessWidget {
  final void Function()? onTap;
  const _ListTileItem({
    Key? key,
    required this.stokKart,
    this.onTap,
  }) : super(key: key);

  final StokKart stokKart;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: stokKart.imagePath != null
            ? Image.network(stokKart.imagePath!)
            : Center(
                child: Text(stokKart.adi?[0].toUpperCase() ?? ""),
              ),
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(stokKart.adi ?? ""),
        ),
      ]),
      subtitle: Text(stokKart.aciklama ?? "asd"),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }
}
