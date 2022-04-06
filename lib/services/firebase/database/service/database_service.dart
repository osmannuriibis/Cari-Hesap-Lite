
import 'package:cari_hesapp_lite/models/siparis_model.dart';
import 'package:cari_hesapp_lite/utils/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cari_hesapp_lite/models/genel_modeller/genel_hata.dart';
import 'package:cari_hesapp_lite/models/kartlar/cari_kart.dart';
import 'package:cari_hesapp_lite/models/kartlar/stok_kart.dart';
import '../../../../models/bilgiler/bilgiler.dart';
import '../../../../models/cari_islem.dart';
import '../../../../models/deneme_model.dart';

import '../../../../models/fiyatlar.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

import '../../../../models/hesap_hareket.dart';
import '../../../../models/islemler_model.dart';
import '../../../../models/sirket_model.dart';
import '../../../../models/stok_hareket.dart';
import '../../../../models/user_model.dart';
import '../../auth/service/auth_service.dart';

class DBService {
  final firestoreInstance = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
      getClassReference<T extends BaseModel>() =>
          firestoreInstance.collection(getClassColPath(T));
  DocumentReference<Map<String, dynamic>>
      getModelReference<T extends BaseModel>(String id) =>
          getClassReference<T>().doc(id);

  String get _sirketId {
    if (UserProvider().sirketId != null) {
      return UserProvider().sirketId!;
    }
    throw Exception("şirketID null geldi \n DBSERVIS()");
  }

////
////
////
////
////
////
////
////
////
////
////
////
////

  String getClassColPath(Type T ) {
    
    if (T == UserModel) {
      return _usersPath;
    } else if (T == SirketModel) {
      return _sirketlerPath;
    } else if (T == CariKart) {
      return _getTablesPath + _cariKartPath;
    } else if (T == CariIslemModel) {
      return _getTablesPath + _cariIslemlerPath;
    } else if (T == StokKart) {
      return _getTablesPath + _stokKartPath;
    } else if (T == Islemler) {
      return _getTablesPath + _islemlerPath;
    } else if (T == StokHareket) {
      return _getTablesPath + _stokHareketPath;
    } else if (T == Bilgiler) {
      return _getTablesPath + _bilgilerPath;
    } 

    ///
    /// PATH=> tablo[i]/hesaplar/kasa
    ///                         /banka
    ///                         /pos
    ///                             /id
    ///                                /bagliBankId
    ///                         /kart
    ///                             /id
    ///                                /bagliBankId

 else if (T == DenemeModel) {
      return _getTablesPath + _denemePath;
    } else if (T == HesapHareket) {
      return _getTablesPath + _hesapHareketPath;
    }  else if (T == SiparisModel) {
      return _getTablesPath + _siparisler;
    } else if (T == Fiyatlar) {
      return _getTablesPath + _fiyatlarPath;
    } else if (T == GenelHata) {
      return _genelHataPath;
    } else {
      throw Exception("$T bulunamadı => DatabaseService()");
    }
  }

  String? userId = AuthService().mainUserId;

  // ignore: unused_element
  String get _usersPath => "users";
  String get _sirketlerPath => "sirketler";

  String get _genelHataPath => "hatalar";

  String get _getTablesPath => _sirketPath + "/";

  String get _sirketPath => _sirketlerPath + "/" + (_sirketId);

  String get _cariKartPath => "carikart";
  String get _stokKartPath => "stokkart";

  String get _cariIslemlerPath => "cariislem";
  String get _stokHareketPath => "stokhareket";
  String get _hesapHareketPath => "hesaphareket";

  String get _islemlerPath => "islemler";

  String get _bilgilerPath => "bilgiler";
  String get _fiyatlarPath => "bilgiler/fiyatlar/fiyatlar";

  String get _denemePath => "deneme";
  String get _siparisler => "siparisler";
}

/* 

private static String userPath = "users/" + userId +"/";

    private static String SIRKET_KODU = "sirket0";
    private static String VERITABANI_KODU = "veritabani0";
    private static String TABLO_KODU = "tablo0";
    



    public static String getInstanceTabloPath(){
       return  "users/" + userId + "/sirketler/"+ SIRKET_KODU+"/veritabanlari/"+VERITABANI_KODU+"/tablolar/"+ TABLO_KODU;
    } */
