import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:flutter/material.dart';

class AyarlarView extends StatelessWidget {
  const AyarlarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleText: "Ayalar",
      ),
      body: Column(
        children: [
          ListTile(
              title: const Text("Depo Ekle"),
              onTap: () {}),
        ],
      ),
    );
  }
}
