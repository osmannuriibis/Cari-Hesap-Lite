import 'dart:async';

import 'package:cari_hesapp_lite/models/siparis_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/siparis_model.dart';

class HomeViewModel extends ChangeNotifier {
/*   late StreamSubscription<List<SiparisModel>> listen;
  List<SiparisModel> _listSiparis = [];
 List<SiparisModel> get listSiparis => this._listSiparis;

 set listSiparis(List<SiparisModel> value) => this._listSiparis = value; */
  var dbUtil = DBUtils();

  late StreamSubscription<List<SiparisModel>> entrySiparis;

  List<SiparisModel> _listSiparis = [];

  List<SiparisModel> get listSiparis => _listSiparis;

  set listSiparis(List<SiparisModel> value) {
    _listSiparis = value;
    notifyListeners();
  }

  HomeViewModel() {
    fetchSiparisList();
  }

  List<MyExpansionPanels> _myPanels = [
    MyExpansionPanels(
        header: "Sık Kullanılanlar",
        body: Container(
          padding: const EdgeInsets.all(10),
          child: GridView.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            crossAxisCount: 5,
            childAspectRatio: 1,
            children: [
              Container(
                color: Colors.redAccent,
              ),
              IconButton(
                tooltip: "Yeni Kısayol Ekle",
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.grey.shade600,
                  size: 40,
                ),
                onPressed: () {
                  bas("object");
                },
              )
            ],
          ),
        ),
        isExpanded: true),
    MyExpansionPanels(
        header: "Raporlar",
        body: const Center(
          child: Text(""),
        ),
        isExpanded: true),
    MyExpansionPanels(
        header: "Akış",
        body: const Center(
          child: Text(""),
        ),
        isExpanded: true),
  ];

  List<MyExpansionPanels> get myPanels => _myPanels;

  bool compareDate(Timestamp date) => (date.compareTo(Timestamp.now()) > 1);
  set myPanels(List<MyExpansionPanels> value) {
    _myPanels = value;
    notifyListeners();
  }

  void fetchSiparisList() {
    bas("fetch Siiparsiler");
    entrySiparis = DBUtils().getModelListAsStream<SiparisModel>().call(
      (event) {
        listSiparis = event;
      },
    );
  }

  @override
  void dispose() {
    entrySiparis.cancel();
    super.dispose();
  }

  void notify() {
    notifyListeners();
  }
}

class MyExpansionPanels {
  late Widget Function(BuildContext, bool) headerBuilder;
  Widget? body;
  bool isExpanded;

  MyExpansionPanels(
      {required String header, this.body, this.isExpanded = false}) {
    headerBuilder = (context, isExpanded) {
      return (isExpanded)
          ? Text(
              header,
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          : Text(header);
    };
  }
}
