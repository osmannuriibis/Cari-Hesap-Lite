///cari,
///firma,
enum CariTuru {
  cari, //
  firma,
  //sahis,
}

extension CariTuruValues on CariTuru {
  static const stringMap = {CariTuru.cari: "Cari", CariTuru.firma: "Firma"};

  String? get stringValue => stringMap[this];
  String? toMap() => stringValue;
}

extension CariTuruStrings on String? {
  CariTuru? get toCariTuru {
    CariTuru? val;

    if (this == null) return null;

    for (var item in CariTuru.values) {
      if (item.stringValue == this!.trim()) {
        val = item;
      }
    }

    return val;
  }
}
