import 'dart:async';

import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/models/konum.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/konum_service/calc_distance.dart';
import 'package:cari_hesapp_lite/utils/konum_service/konum_extension.dart';
import 'package:cari_hesapp_lite/utils/konum_service/konum_service.dart';
import 'package:flutter/material.dart';

import '../../../../enums/cari_turu.dart';

class CariListViewModel extends ChangeNotifier {
  var dbutil = DBUtils();
  var konumService = KonumService()..requestPermission();
  var currentLocation = KonumService().currentPosition;

  bool _isSearchPressed = false;
  bool get isSearchPressed => _isSearchPressed;

  set isSearchPressed(bool value) {
    _isSearchPressed = value;
    notifyListeners();
  }

  late bool _isCari;
  bool get isCari => _isCari;

  set isCari(bool value) {
    _isCari = value;
    notifyListeners();
  }

  String? _filterText;
  String? get filterText => _filterText;

  set filterText(String? value) {
    _filterText = value;
    notifyListeners();
  }

  String? _sortField;
  set sortField(String? value) {
    if (value == "konum") KonumService().requestPermission();
    _sortField = value;
    notifyListeners();
  }

  String? get sortField => _sortField;

  List<CariKart> _listBase = <CariKart>[];

  late StreamSubscription<List<CariKart>> listen;

  CariTuru cariTuru(bool isCari) {
    return isCari ? CariTuru.cari : CariTuru.firma;
  }

  CariListViewModel({
    bool isCari = true,
  }) {
    this.isCari = isCari;
    setCariList();
  }

  set listBase(List<CariKart> value) {
    _listBase = value;
    notifyListeners();
  }

  List<CariKart> get listBase {
    var _list = <CariKart>[];

    _list = _listBase.where((e) => e.cariTuru == cariTuru(isCari)).toList();

    _list = filterList(_list, filterText);
    sortByKonum(_list);
    //sortField alanına göre sıralama yapıyor
    if (sortField.isNotEmptyOrNull) {
      if (sortField! == "unvan") sortByUnvan(_list);
    }

    return _list;
  }

  void setCariList() {
    /*  if (_listBase.isEmpty) { */
    listen = dbutil.getModelListAsStream<CariKart>().call(
      (event) {
        listBase = event;
      },
    ); //.getModelList<CariKart>(this);
    /* } */
  }

  void notify() {
    notifyListeners();
  }

  void sortByKonum(List<CariKart> list) {
    if (currentLocation != null) {
      list.sort((e, y) {
        var first = getDistance(
            currentLocation!.asKonum,
            Konum(
                latitude: e.konum?.latitude ?? 0,
                longitude: e.konum?.longitude ?? 0));
        var second = getDistance(
            currentLocation!.asKonum,
            Konum(
                latitude: y.konum?.latitude ?? 0,
                longitude: y.konum?.longitude ?? 0));

        return first.compareTo(second);
      });
    }
  }

  void sortByUnvan(List<CariKart> list) {
    list.sort((e, y) {
      return (e.unvani ?? "").compareTo((y.unvani ?? ""));
    });
  }

  List<CariKart> filterList(List<CariKart> list, String? filterText) {
    var _list = <CariKart>[];
    if (filterText.isNotEmptyOrNull) {
      for (var item in list) {
        if ((item.toMap()["unvani"] as String)
                .toLowerCase()
                .contains(filterText!.toLowerCase()) ||
            (item.toMap()["ekBilgi"] as String)
                .toLowerCase()
                .contains(filterText.toLowerCase())) {
          _list.add(item);
        }
      }
    } else {
      _list = list;
    }
    return _list;
  }

  @override
  void dispose() {
    listen.cancel();
    super.dispose();
  }

  Widget _hasSearchEntryIcon = const Icon(Icons.clear);
  set hasSearchEntryIcon(Widget widget) {
    _hasSearchEntryIcon = widget;
    notifyListeners();
  }

  Widget get hasSearchEntryIcon => _hasSearchEntryIcon;
}

/* extension ListenSnapshot
    on StreamSubscription<QuerySnapshot<Map<String, dynamic>>> Function(
        void Function(QuerySnapshot<Map<String, dynamic>>),
        {bool? cancelOnError,
        void Function() onDone,
        Function? onError}) {
  MapEntry<StreamSubscription<QuerySnapshot<Map<String, dynamic>>>, List<T>>
      getModelList<T extends BaseModel>([ChangeNotifier? viewModel]) {
    var list = <T>[];
    var listen = this.call((event) {
      list.clear();
      bas("listen çalıştı......");
      for (var item in event.docs) {
        list.add(Mapper.fromMap<T>(item.data()));
      }
      for (var item in list) {
        bas(item.toString());
        bas("");
      }
      if (viewModel != null) viewModel.notifyListeners();
    });

    return MapEntry(listen, list);
  }
}

 */