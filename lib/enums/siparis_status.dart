enum SiparisStatus {
  olusturuldu,
  islemeCevrildi,
  iptalEdildi,
}

extension SiparisStatusValue on SiparisStatus {
  String get toStringValue => name;
  toMap() => toStringValue;
}

extension SiparisStatusString on String {
  SiparisStatus get toSiparisStatus {
    for (var item in SiparisStatus.values) {
      if (item.name == this) {
        return item;
      }
    }
    throw Exception("$this is not A SiparisStatus");
  }
}
