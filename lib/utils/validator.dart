import 'package:cari_hesapp_lite/models/base_model/base_model.dart';

import 'package:cari_hesapp_lite/utils/print.dart';

import '../utils/extensions.dart';

class Validator {
  String? cokKisaOldu(String? value) {
    bas("validator çalıştı: $value");
    if (value == null) {
      return "Çok kısa oldu!";
    } else {
      return (value.length < 3) ? "Çok kısa oldu!" : null;
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Geçerli bir email giriniz";
    } else {
      return !value.contains("@")  ? "Geçerli bir email giriniz" : null;
    }
  }

  String? bosOlamaz(String? value) {
    if (value != null) {
      return (value.trim().isEmptyOrNull) ? "Boş olmamalı" : null;
    } else {
      return (value.isEmptyOrNull) ? "Boş olmamalı" : null;
    }
  }

  String? kdvValidator(String? value) {
   if(value != null){ 
     var val = (value != "") ? (num.tryParse(value) != null ? num.tryParse(value) :0 ) : 0;

    if (val! < 0 || val > 100) {
      return "0-100 arasında olmalı";
    }}
    return null;
  }

  String? ibanValidator(String? val) {
    print("iban lenght: " + val!.length.toString());
    if (val.length <= 2 || val.length == 32) {
      return null;
    } else {
      return "Eksiksiz giriniz yada boş geçiniz";
    }
  }

  String? sifirdanBuyuk(String? val) {
    if (val!.isEmpty || num.tryParse(val)! <= 0 || val == " ") {
      return "Geçerli bir sayı giriniz";
    }
    return null;
  }
}
