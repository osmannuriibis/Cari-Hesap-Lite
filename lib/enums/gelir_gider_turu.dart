
/// [Gelir], [Gider]
enum GelirGiderTuru  {
  gelir,gider
}

extension GelirGiderTuruValues on GelirGiderTuru {
  static const map = {
    GelirGiderTuru.gelir: "Gelir",
    GelirGiderTuru.gider: "Gider",
   
  };

  String? get stringValue => map[this];
  String?  toMap() => map[this];

}

extension GelirGiderTuruString on String{

GelirGiderTuru? get toGelirGiderTuru {
    for (var item in GelirGiderTuru.values) {
      if (item.stringValue == trim()) {
        return item;
      }
    }
    return null;
  }

}