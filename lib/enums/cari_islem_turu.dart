//Sadece cari(ve tedarikçi) birimlerinin yapacağı işlemleri gruplar...

enum CariIslemTuru {
  satis,

  alis
}

extension CariIslemTuruValues on CariIslemTuru {
  static const stringMap = {
    CariIslemTuru.alis: "Alış",
    CariIslemTuru.satis: "Satış",
  };

  String get stringValue => stringMap[this] ?? (throw Exception("Cari Islem Turu Null"));
  String toMap() => stringValue;
}

Map<String, CariIslemTuru> cariIslemTuruMap = {
  "Alış": CariIslemTuru.alis,
  "Satış": CariIslemTuru.satis,
};

extension CariIslemTuruFromString on String {
  CariIslemTuru get toCariIslemTuru {
    switch (this) {
      case "Alış":
        return CariIslemTuru.alis;
      case "Satış":
        return CariIslemTuru.satis;

      default:
        throw Exception(this);
    }
  }
}
