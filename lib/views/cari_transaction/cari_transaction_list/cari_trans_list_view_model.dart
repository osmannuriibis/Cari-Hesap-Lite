import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../services/firebase/database/utils/database_utils.dart';

import '../../../../enums/cari_islem_turu.dart';
import '../../../../models/cari_islem.dart';

class CariTransactionsListViewModel extends ChangeNotifier {
/* DatabaseService _dbService;

  DatabaseService get dbService {
    if (_dbService == null) {
      return _dbService = DatabaseService<CariKart>();
    } else {
      return _dbService;
    }
  } */
  var dbUtil = DBUtils();

  Widget _hasSearchEntryIcon = const Icon(Icons.clear);
  set hasSearchEntryIcon(Widget widget) {
    _hasSearchEntryIcon = widget;
    notifyListeners();
  }

  Widget get hasSearchEntryIcon => _hasSearchEntryIcon;

  String? _filterText;
  String? get filterText => _filterText;

  set filterText(String? value) {
    _filterText = value;
    notifyListeners();
  }

  bool _isSearchPressed = false;
  bool get isSearchPressed => _isSearchPressed;

  set isSearchPressed(bool value) {
    _isSearchPressed = value;
    notifyListeners();
  }


  CariTransactionsListViewModel() {
    getList();
  }

  var _islemTuru = CariIslemTuru.satis;
  CariIslemTuru get islemTuru => _islemTuru;
  set islemTuru(CariIslemTuru value) {
    _islemTuru = value;
    notifyListeners();
  }

  var _listTransactions = <CariIslemModel>[];

  set listTransactions(List<CariIslemModel> value) {
    _listTransactions = value;
    notifyListeners();
  }

  List<CariIslemModel> get listTransactions => _listTransactions
          .where((element) => element.islemTuru == islemTuru)
          .toList()
          .where((element) {
        if (filterText.isEmptyOrNull) {
          return true;
        }
        return (element.cariUnvani ?? "")
            .toLowerCase()
            .contains(filterText!.toLowerCase());
      }).toList();

  Future<List<CariIslemModel>> getList() async {
    return listTransactions =
        await dbUtil.getModelListAsFuture<CariIslemModel>();
  }
}
