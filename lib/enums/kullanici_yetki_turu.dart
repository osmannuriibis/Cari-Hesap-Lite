enum KullaniciYetkiTuru { main,admin, sefil }

extension YetkiString on KullaniciYetkiTuru {
  static const map = {
    KullaniciYetkiTuru.main: "Main",
    KullaniciYetkiTuru.admin: "Yönetici",
    KullaniciYetkiTuru.sefil: "Çalışan",
  };

  String? get stringValue => map[this];
  String?  toMap() => stringValue;
}



extension YetkiValue on String {
  KullaniciYetkiTuru get getKullaniciYetkiValue {
    switch (this) {
       case "Main":
        return KullaniciYetkiTuru.main;
      case "Yönetici":
        return KullaniciYetkiTuru.admin;
      case "Çalışan":
        return KullaniciYetkiTuru.sefil;
      default:
        throw RangeError("this is out of the KullanıcıYetkiTuru values");
    }
  }
}
