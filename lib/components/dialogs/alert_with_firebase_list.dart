import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/components/fsal/special_firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../card/custom_card.dart';

class AlertDialogWithFirebaseList extends StatelessWidget {
  final Widget? title;
  final TextEditingController? controller;
  final void Function()? onPressedActionButton;
  final void Function(MapEntry)? onLongPressItem, onPressedItem;

  final bool reverse;

  final String? hintText;

  final Stream<DocumentSnapshot<Map<String, dynamic>>> query;

  const AlertDialogWithFirebaseList({
    Key? key,
    this.title,
    this.controller,
    required this.onPressedActionButton,
    this.reverse = false,
    required this.query,
    this.onLongPressItem,
    this.onPressedItem,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        //    direction: Axis.vertical,
        children: [
          const Text(
            "Listeden seçebilir, yeni ekleyebilirsiniz",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          MyCard(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
            child: MyFirestoreDocList(
              key: key,
              reverse: reverse,
              streamQuery: query,
              shrinkWrap: true,
              itemBuilder: (context, snapshot) {
                Map<String, dynamic>? map = snapshot?.data();
                if (map == null) return const Text("Veri Yok");

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var item in map.entries)
                        TextButton(
                          onPressed: () {
                            onPressedItem!(item);
                          },
                          onLongPress: () {
                            onLongPressItem!(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 10),
                            child: Text(
                              item.key,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      const Divider(
                        height: 0,
                      )
                    ],
                  ),
                );
              },
              //(context, snapshot, animation, index) =>
              // shrinkWrap: true,
            ),
          ),
          const Text(
            "Satır Silmek için basılı tutunuz",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 20,
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  flex: 5,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(" "),
                    ],
                    keyboardType: TextInputType.name,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(fontStyle: FontStyle.italic)),
                  )),
              Flexible(
                flex: 3,
                child: OutlinedButton(
                  child: const Text("Ekle"),
                  onPressed: onPressedActionButton,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
