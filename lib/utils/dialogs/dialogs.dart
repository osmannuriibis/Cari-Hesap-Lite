import 'package:cari_hesapp_lite/components/dialogs/show_alert_dialog.dart';
import 'package:cari_hesapp_lite/enums/cari_islem_turu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> showDateDialog(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? (DateTime.now()).subtract(Duration(days: 365)),
    lastDate: lastDate ?? (DateTime.now()).add(Duration(days: 365)),
    confirmText: "Tamam",
    cancelText: "Vazgeç",
  );
}

Future<CariIslemTuru?> showCariIslemTuruDialog(BuildContext context) {
  return showAlertDialog<CariIslemTuru>(context,
      title: "Seçiniz",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var tur in CariIslemTuru.values)
            ListTile(
              title: Text(tur.stringValue),
              onTap: () {
                Navigator.pop(context, tur);
              },
            )
        ],
      ));
}
