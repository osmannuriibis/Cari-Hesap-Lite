import 'dart:math';

import 'package:cari_hesapp_lite/utils/catch.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

extension StringExtension on String? {
  String toCapitalize() {
    return (isNotEmptyOrNull)
        ? "${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}"
        : "";
  }

  String toCapForEachOne() {
    List<String> list;
    String newString = "";
    if (isNotEmptyOrNull) {
      list = this!.split(' ');
    } else {
      return "";
    }

    for (String item in list) {
      newString += item.toCapitalize() + " ";
    }
    return newString.trim();
  }

  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    } else {
      if (this == "") {
        return true;
      } else {
        return false;
      }
    }
  }

  bool get isNotEmptyOrNull {
    return !isEmptyOrNull;
    /* if (this == null) {
      return false;
    } else {
      if (this == "") {
        return false;
      } else {
        return true;
      }
    } */
  }

  String get toCorrect {
    return this ?? "";
  }

  num get toNum {
    if (this == null) {
      return 0;
    } else {
      return num.tryParse(this!.trim()) ?? 0;
    }
  }
}

extension DoubleExtension on double {
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits).toDouble();
    return ((this * mod).round().toDouble() / mod);
  }
}

extension NumExtension on num? {
  bool get isNullOrZero {
    if (this == null) {
      return true;
    } else {
      if (this == 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool get isNotNullOrEmpty {
    return !isNullOrZero;
    /* if (this == null) {
      return false;
    } else {
      if (this == 0) {
        return false;
      } else {
        return true;
      }
    } */
  }

  num get toNum {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension FutureExtension<T> on Future<T?> {
  Future<String?> getBoolResultForFirebase() {
    // ignore: unnecessary_this
    return this
        .then<String?>((value) => null)
        .onError((FirebaseException error, stackTrace) {
      fetchCatch(error, this);
      return error.code;
    });
  }
}

extension SaveExtension on Future<String?> {
  Future<T?> showSaveSnackBar<T>(BuildContext context,
      {bool isPop = true,
      bool isPopOnError = false,
      SnackBarAction? action,
      T? model}) async {
    var result = await this;

    bas("showSnackBar result : $result");

    if (result == null) {
      if (isPop) {
        Navigator.of(context).pop(model);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Hata: $result"),
        action: action,
      ));

      if (isPopOnError) {
        Navigator.of(context).pop(model);
      }
    }
  }
}
