import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../services/firebase/database/utils/database_utils.dart';

import '../../../../enums/cari_islem_turu.dart';
import '../../../../models/cari_islem.dart';
import '../../../../services/firebase/database/service/database_service.dart';

class CariTransactionsViewModel {
/* DatabaseService _dbService;

  DatabaseService get dbService {
    if (_dbService == null) {
      return _dbService = DatabaseService<CariKart>();
    } else {
      return _dbService;
    }
  } */

  bool isSwitchedIslemTuru = true;

  var islemTuru = CariIslemTuru.satis.stringValue;

 DBService? _cariIslemDbService;
  DBService get cariIslemDbService2 {
    if (_cariIslemDbService == null) {
      return _cariIslemDbService = DBService();
    } else {
      return _cariIslemDbService!;
    }
  }

  Query<Map<String,dynamic>> get satisQuery {
    return DBUtils().getClassReference<CariIslemModel>().where(
        "CariIslemValues.islemTuru.stringValue",
        isEqualTo: CariIslemTuru.satis.stringValue);
  }

  Query<Map<String,dynamic>> get alisQuery {
    return DBUtils().getClassReference<CariIslemModel>().where("islemTuru", isEqualTo: "Alış");
  }
}
