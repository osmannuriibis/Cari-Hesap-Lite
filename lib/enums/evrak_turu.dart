
enum EvrakTuru {
  fatura,
  irsaliyeliFatura,
  sevkIrsaliyesi,
  makbuz,
  tahsilat,
  tediye,
  virman,
  /* ... */

}

extension EvrakTuruValues on EvrakTuru {
  String get stringValue {
    switch (this) {
      case EvrakTuru.fatura:
        return "Fatura";
      case EvrakTuru.irsaliyeliFatura:
        return "İrsaliyeli Fatura";
      case EvrakTuru.makbuz:
        return "Makbuz";
      case EvrakTuru.sevkIrsaliyesi:
        return "Sevk İrsaliyesi";
      case EvrakTuru.tahsilat:
        return "Tahsilat";
      case EvrakTuru.tediye:
        return "Tediye";
      case EvrakTuru.virman:
        return "Virman";
      default:
        throw RangeError(
            toString() + " out of The Range of EvrakTuruEnums");
    }
  }
}
