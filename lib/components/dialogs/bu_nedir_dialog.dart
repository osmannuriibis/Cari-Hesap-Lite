import 'package:cari_hesapp_lite/enums/bu_nedir.dart';
import 'package:flutter/material.dart';
import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';

showBuNedirDialogs(BuildContext context, BuNedirEnum value) {
  return showAlertDialog(context,
      title: "BuNedir?",
      content: Text(value.getAciklama(),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 20,
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("TAMAM"))
      ]);
}
