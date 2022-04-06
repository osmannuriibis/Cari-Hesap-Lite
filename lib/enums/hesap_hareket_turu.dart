///  "Kredi Kartı",
///     "Havale",
///      "Nakit",
///    "Çek",
///     "Senet",

enum HesapHareketTuru {
  nakit,
  krediKarti,
  havale,
  cek,
  senet,
}

extension HesapHareketTuruValues on HesapHareketTuru {
  static const map = {
    HesapHareketTuru.krediKarti: "Kredi Kartı",
    HesapHareketTuru.havale: "Havale",
    HesapHareketTuru.nakit: "Nakit",
    HesapHareketTuru.cek: "Çek",
    HesapHareketTuru.senet: "Senet",
  };

  String get stringValue => map[this]!;
  String toMap() => map[this]!;
}

extension HesapHareketTuruStrings on String {
  HesapHareketTuru? get toHesapHareketTuru {
    for (var item in HesapHareketTuru.values) {
      if (item.stringValue == trim()) {
        return item;
      }
    }
    return null;
  }
}
