import 'dart:async';
import 'package:cari_hesapp_lite/models/sirket_model.dart';
import 'package:cari_hesapp_lite/models/user_model.dart';
import 'package:cari_hesapp_lite/utils/mapper_from_type/mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/models/cari_islem.dart';
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/models/kartlar/stok_kart.dart';
import 'package:cari_hesapp_lite/enums/miktar_degisim.dart';

import 'package:cari_hesapp_lite/services/firebase/database/service/database_service.dart';

import 'package:cari_hesapp_lite/utils/extensions.dart';

class DBUtils {
  var dbService = DBService();

  DocumentReference<Map<String, dynamic>>
      getModelReference<T extends BaseModel>(String modelId) =>
          dbService.getClassReference<T>().doc(modelId);

  CollectionReference<Map<String, dynamic>>
      getClassReference<T extends BaseModel>() =>
          dbService.getClassReference<T>();

///////// DATABASE
/////////   CRUD
/////////    |
/////////    |
/////////   \ /
/////////    V

  Future<String?> addOrSetModel<T extends BaseModel>(T model,
      {String? documentId}) async {
    try {
      Map<String, dynamic> modelMap = model.toMap();

      if (modelMap['id'] == null) {
        modelMap['id'] = documentId ?? getClassReference<T>().doc().id;
      }

      return await _setModel<T>(modelMap);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  asd(Type T) {
    T == CariIslemModel;
  }

  Future<String?> addOrSetModelBatch(List<BaseModel> models) async {
    try {
      var instance = dbService.firestoreInstance;
      var batch = instance.batch();

      for (var model in models) {
        model.id ??= instance.collection("collectionPath").doc().id;
        batch.set(
            instance
                .collection(dbService.getClassColPath(model.runtimeType))
                .doc(model.id),
            model.toMap());
        asd(model.runtimeType);
      }
      return batch.commit().getBoolResultForFirebase();
      //await _setModel<T>(modelMap);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String?> _setModel<T extends BaseModel>(Map<String, dynamic> map) {
    var instance = FirebaseFirestore.instance;
    var batch = instance.batch();

    var ref = getModelReference<T>(map['id']);
    batch.set(ref, map);
    return batch.commit().getBoolResultForFirebase();
    /* .set(
          map,
        )
        .getBoolResultForFirebase(); */
  }

/* getModelReference<StokKart>(hareket.urunId).update({
            "miktar": FieldValue.increment(
                (cariIslem.islemTuru == CariIslemTuru.satis)
                    ? hareket.miktar * -1
                    : hareket.miktar)
          }); */

  Future<String?> updateModel<T extends BaseModel>(Map<String, dynamic> data,
      [String? documentId]) async {
    return await getModelReference<T>((documentId != null)
            ? documentId
            : (data['id'] ?? NullThrownError()))
        .set(data, SetOptions(merge: true))
        .getBoolResultForFirebase();
  }

  Future<String?> deleteModel<T extends BaseModel>(T modelId) {
    return getModelReference<T>(modelId.id!)
        .delete()
        .getBoolResultForFirebase();
  }
/////////    GET
/////////   MODELs
/////////    AND
/////////   FIELDs
/////////     |
/////////     |
/////////    \ /
/////////     V

  Future<T?> getModelFromDB<T extends BaseModel>(String modelId, T bosModel) {
    return getModelReference<T>(modelId)
        .get()
        .then<T?>((value) => bosModel.fromMap(value.data()!) as T)
        .catchError((onError) => null);
  }

  Future<StokKart> getStokKartById(String stokId) async {
    return StokKart.fromMap(
        (await getModelReference<StokKart>(stokId).get()).data()!);
  }

  Future<CariKart> getCariKartById(String cariId) async {
    return CariKart.fromMap(
        (await getModelReference<CariKart>(cariId).get()).data()!);
  }

  Future<dynamic> getModelsFieldsValueFromDB<T extends BaseModel>(
      String modelId, String fieldName) {
    return getModelReference<T>(modelId)
        .get()
        .then((value) => (value.get(fieldName))) //TODO dene burayı
        .catchError((onError) => null);
  }

/////////  UPDATES
/////////   MODELs
/////////   FIELD
/////////     |
/////////     |
/////////    \ /
/////////     V

  /// [field]  --CariKart:=> ['bakiye'] -- StokKart:=> ['miktar']
  ///
  /// [quantity] = değişim miktarı
  ///
  /// [degisimTuru] = Enum: azalış veya artış seçimi
  Future<String?> updateModelNumField<T extends BaseModel>(
      String modelId, num quantity, String field, Degisim degisimTuru) async {
    var miktar = quantity * ((degisimTuru == Degisim.azalt) ? -1 : 1);

    /* return await getModelReference<T>(modelId)
      .update({field: FieldValue.increment(miktar)}).getBoolResult(); */

    return await updateModel<T>({field: FieldValue.increment(miktar)}, modelId);
  }

  Future<String?> updateCariBakiye(
      String cariId, num amount, Degisim degisimTuru) async {
    return updateModelNumField<CariKart>(cariId, amount, "bakiye", degisimTuru);
  }

  ///[T] modelinden [K] hesabına [toplamTutar] miktarında para gönderimi
  /*  Future<bool> moneyTransferHesapToCari<T extends BaseModel,
          K extends BankaHesaplarBaseModel>(
      {required T kartModel,
      required K hesapModel,
      required num toplamTutar,
      required bool isToKart,
      String field = "bakiye"}) async {
    try {
      updateModelNumField<T>(kartModel.id!, toplamTutar, field,
          isToKart ? Degisim.artir : Degisim.azalt);
      updateBagliHesapBakiye<K>(
          hesapModel, toplamTutar, isToKart ? Degisim.azalt : Degisim.artir);
      return true;
    } on Exception catch (e) {
      return fetchCatch(e, this);
    }
  } */

/////////  QUERIES
/////////   MODELs
/////////    AND
/////////   LISTs
/////////     |
/////////     |
/////////    \ /
/////////     V

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCariIslemByFilter(String field, value) async {
    return (await getClassReference<CariIslemModel>()
            .where(field, isEqualTo: value)
            .get())
        .docs;
  }

  //TODO silinecek
  Stream<List<T>> getModelListAsStream2<T extends BaseModel>() {
    var streamController = StreamController<List<T>>();

    var list = <T>[];

    getClassReference<T>().snapshots().listen(
      (event) {
        list.clear();

        if (event.docs.isNotEmpty) {
          for (var item in event.docs) {
            if (item.data() == null) {
              throw Exception("null => getModelListAsStream");
            }
            list.add(Mapper.fromMap<T>(item.data()));
          }
        }
        streamController.add(list);
      },
      onDone: () {
      },
    );
    return streamController.stream;
  }

  ///@param [filterList] definition: MapEntry<MapEntry<"field","value">, "equality">

  StreamSubscription<List<T>> Function(void Function(List<T> event)? onData,
      {bool? cancelOnError,
      void Function()? onDone,
      Function?
          onError}) getModelListAsStream<T extends BaseModel>(
      [List<MapEntry<MapEntry<Object, Object>, FirestoreClause>>? filterList,
      ]) {

    var list = <T>[];
    var ref = DBUtils().getClassReference<T>();

    Query<Map<String, dynamic>>? query;

    if (filterList != null) {
      for (var item in filterList) {
        query =
            (query ?? ref).whereJust(item.key.key, item.value, item.key.value);
      }
    } else {
      query = null;
    }

    return (query ?? ref)
            .snapshots()
            .asyncMap((e) => e.docs.map((e) {

                  return Mapper.fromMap<T>(e.data());
                }).toList())
            .listen /* ((event) {
      bas("stream listen çalşıtı", this);

      list.clear();

      for (var item in event) {
        list.add(item);
      }

      if (viewModel != null) viewModel.notifyListeners();
    }) */
        ;

    //  return MapEntry(listen, list);
  }

  Future<List<T>> getModelListAsFuture<T extends BaseModel>(
      [List<MapEntry<Object, Object>>? filterList]) async {
    var list = <T>[];
    var ref = getClassReference<T>();
    Query<Map<String, dynamic>>? query;
    if (filterList != null) {
      for (var item in filterList) {
        query = (query ?? ref).where(item.key, isEqualTo: item.value);
      }
    }

    await (query ?? ref).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var item in value.docs) {
          list.add(Mapper.fromMap<T>(item.data()));
        }
      }
    });
    return list;
  }

  StreamSubscription<T?> Function(void Function(T? event)? onData,
      {bool? cancelOnError,
      void Function()? onDone,
      Function? onError}) getModelAsStream<T extends BaseModel>(
    String modelId,
  ) {
    //  T? model;
    return getModelReference<T>(modelId).snapshots().asyncMap((event) {
      if (event.data() != null) {
        return Mapper.fromMap<T>(event.data()!);
      }
      return null;
    }).listen /* ((event) {
      model = event;
      bas("model in getModelAsStream");
      bas(model);

      if (notifyListeners != null) {
        notifyListeners.call();
        bas("notify called");
      }
    }) */
        ;

    // return MapEntry(listen, model);
  }

  Future<T?> getModelAsFuture<T extends BaseModel>(String modelId) async {
    return await getModelReference<T>(modelId).get().then((value) {
      var map = value.data();
      if (map != null) {
        return Mapper.fromMap<T>(map);
      } else {
        return null;
      }
    });
  }

  Future<String?> updateUserField(String uid, String field, String value) {
    return updateModel<UserModel>({field: value}, uid);
  }

/////////
/////////
/////////
/////////
/////////     |
/////////     |
/////////    \ /
/////////     V

  CollectionReference<Map<String, dynamic>> getUserClassReferenceUnderSirket(
      String sirketId) {
    return getModelReference<SirketModel>(sirketId).collection("users");
  }
}

enum FirestoreClause {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
}

extension WhereClause<T extends Object> on Query<T> {
  Query<T> whereJust(Object field, FirestoreClause equality, Object? value) {
    switch (equality) {
      case FirestoreClause.arrayContains:
        return where(field, arrayContains: value);

      case FirestoreClause.isEqualTo:
        return where(field, isEqualTo: value);

      case FirestoreClause.isGreaterThan:
        return where(field, isGreaterThan: value);

      case FirestoreClause.isGreaterThanOrEqualTo:
        return where(field, isGreaterThanOrEqualTo: value);

      case FirestoreClause.isLessThan:
        return where(field, isLessThan: value);

      case FirestoreClause.isLessThanOrEqualTo:
        return where(field, isLessThanOrEqualTo: value);

      case FirestoreClause.isNotEqualTo:
        return where(field, isNotEqualTo: value);
      default:
        throw Exception("FirestoreJustify value is Null ");
    }
  }
}
