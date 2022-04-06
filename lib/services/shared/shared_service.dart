import 'dart:async';

import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  SharedService._();

  static final SharedService _init = SharedService._();

  static SharedService get instance => _init;

  var _userKey = AuthService().currentUserId;

  Future<String?> getStringValueByKey(String key) async {
    var asd = await SharedPreferences.getInstance();

    return asd.getString(getKeyPath(key));
  }

  Future<bool> setStringValueByKey(String key, String? value) async {
    var asd = await SharedPreferences.getInstance();
 
    if (value == null) {
      return asd.remove(getKeyPath(key));
    }

    return asd.setString(getKeyPath(key), value);
  }

  setListByKey(
    String key,
  ) async {
    var asd = await SharedPreferences.getInstance();
  }

  Stream<String?> streamValueByKey(String key) {
    var streamController = StreamController<String?>();

    var shared = SharedPreferences.getInstance().asStream().  listen((event) {
      bas("streamValueByKey çalıştı => SharedService");

      streamController.add(event.getString(getKeyPath(key)));
    });

    return streamController.stream;
  }

  String getKeyPath(String key) => (_userKey ?? "null") + "/" + key;
}
