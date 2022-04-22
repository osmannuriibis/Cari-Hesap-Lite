import 'dart:io';

import 'package:flutter/material.dart';

class ContributionViewModel extends ChangeNotifier {
  TextEditingController controllerKonu = TextEditingController();
  TextEditingController controllerMesaj = TextEditingController();

  File? _image;

  set image(File? value) {
    _image = value;
    notifyListeners();
  }

  File? get image => _image;
}
