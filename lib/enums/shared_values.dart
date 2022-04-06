enum SharedKeys { sirketId, sikKullanilanlar }

extension SharedKeysValues on SharedKeys {
  static const map = {
    SharedKeys.sirketId: "sirketId",
    SharedKeys.sikKullanilanlar: "sikKullanilanlar"
  };

  String get stringValue {
    if (map[this] != null) {
    return map[this]!;
    } else {
      throw Exception();
    }
  }
}
