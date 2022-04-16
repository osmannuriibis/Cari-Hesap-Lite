import 'dart:async';

import 'package:cari_hesapp_lite/models/sirket_model.dart';
import 'package:cari_hesapp_lite/models/user_model.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/services/firebase/database/service/database_service.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/utils/mapper_from_type/mapper.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _sirketId;
  final _auth = AuthService();

  SirketModel? sirketModel;

  UserModel? userModel;

  static final UserProvider _userSingleton = UserProvider._setInstance();
  factory UserProvider() {
    return _userSingleton;
  }

  UserProvider._setInstance() {
    initCurrentFields();
  }

  String? get sirketId => _sirketId ?? sirketModel?.id;

  User get _user => AuthService().currentUser!;

  //var dbReference = DatabaseService().getClassReference();

  var dbInstance = FirebaseFirestore.instance;

  initCurrentFields() {
    fetchUserAndSirket();
    _fetchUserModelAsStream();
    //   sirketIdAsStream();
  }

  ///returns current[_sirketId]
  Future<MapEntry<UserModel?, SirketModel?>> fetchUserAndSirket(
      [String? setId]) async {
    UserModel? _userModel;
    SirketModel? _sirketModel;

    var userRef =
        dbInstance.collection("users").doc(AuthService().currentUserId);

    _userModel = await userRef.get().then((value) {
      bas("value.data()");
      bas(value.data());
      if (((value.data())?.length ?? 0) == 0) {
        return null;
      }
      if (value.data() != null) {
        return Mapper.fromMap<UserModel>(value.data()!);
      }
    });

    try {
      _sirketModel =
          await userRef.collection("sirketler").get().then((value) async {
        _sirketId = (value.docs.isNotEmpty) ? value.docs.first.id : null;

        return await dbInstance
            .collection(DBService().getClassColPath(SirketModel))
            .doc(_sirketId)
            .get()
            .then((value) {
          if (value.data() == null) return sirketModel = null;
          return sirketModel = SirketModel.fromMap(value.data()!);
        });
      });
    } on FirebaseException catch (e) {
      bas("e.code");
      bas(e.code);
      bas(e.message);
    }
    bas("_userModel");

    bas(_userModel);
    return MapEntry(_userModel, _sirketModel);
  }

  fetchUser() {}

  void _fetchUserModelAsStream() {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    FirebaseAuth.instance.idTokenChanges().listen((event) {});

    dbInstance.collection("users").doc(_user.uid).snapshots().listen((event) {
      if (event.data() != null) {
        userModel = UserModel.fromMap(event.data()!);

        if ((userModel?.adi?.isNotEmptyOrNull ?? false) &&
            (userModel?.soyadi?.isNotEmptyOrNull ?? false)) {
          _auth.currentUser!.updateDisplayName(
              (userModel!.adi!) + " " + (userModel!.soyadi!));
        }
        if (userModel?.photoURL != null) {
          _auth.currentUser!.updatePhotoURL(userModel!.photoURL);
        }
      }
    });

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event?.email != null) {
        DBUtils().updateUserField(event!.uid, "email", event.email!);
      }
    });
  }
}

/*    if (_sirketId == null) {
      return null;
    } else {
      DocumentReference<Map<String, dynamic>>? doc = dbInstance
          .collection("sirketler")
          .doc(_sirketId)
          .collection("users")
          .doc(_user.uid);

      doc.snapshots().listen((event) {
        if (event.data()?["yetki"] != null) {
          yetki = (event.data()?["yetki"] as String).getKullaniciYetkiValue;
        }
      });

      doc.collection("sirketler").doc(_sirketId).get().then((value) {
        bas("value.toString()");
        bas(value.toString());
        (unvani = value.data()?["unvani"] ?? "---");
      });

      return await doc.get().then<String?>((value) {
        if (value.data()?["yetki"] != null) {
          yetki = (value.data()?["yetki"] as String).getKullaniciYetkiValue;
          return sirketId;
        }
      });
    } */