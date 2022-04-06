import 'dart:io';

import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/service/database_service.dart';
import 'package:cari_hesapp_lite/utils/catch.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService with DBService {
  var storage = FirebaseStorage.instance;

  

  Future<String?> getImageUrl<T extends BaseModel>(
      StorageFolder folderType, String modelId) async {
    try {
      return getReference(folderType, modelId).getDownloadURL();
    } on Exception catch (e) {
      fetchCatch(e, this);
      return null;
    }
  }

  Future<String> setImage<T extends BaseModel>(
      StorageFolder folderType, String modelId, File imageFile ,String fileName) {
    var task = getReference(folderType, modelId)
    .child(fileName)
    .putFile(imageFile);
    return task.then((p0) => p0.ref.getDownloadURL());
  }

  Reference getReference(StorageFolder folderType, String modelId) {
    return storage.ref(folderType.getName).child(modelId);
  }
}

enum StorageFolder { users, sirketler }

extension ToName on Enum {
  String get getName => toString().split('.').last;
}
