///sevkIrsaliyesi, irsaliyeliFatura, makbuz
enum IrsaliyeTuru {
  //sevkIrsaliyesi,
  irsaliyeliFatura,
  makbuz,
}

extension IrsaliyeTuruValues on IrsaliyeTuru? {
  static const stringMap = {
  //  IrsaliyeTuru.sevkIrsaliyesi: "Sevk Irsaliyesi",
    IrsaliyeTuru.irsaliyeliFatura: "İrsaliyeli Fatura",
    IrsaliyeTuru.makbuz: "Makbuz",
  };

  String get stringValue {
    if (this == null) {
      throw Exception("IrsaliyeTuru değeri null");
    }

    return stringMap[this] ?? (throw NullThrownError());
  }

  String toMap() => stringValue;
}

extension IrsaliyeTuruString on String {
  IrsaliyeTuru? get toIrsaliyeTuru {
    for (var item in IrsaliyeTuru.values) {
      if (item.stringValue == trim()) {
        return item;
      }
    }
    return throw Exception("İrsaliye Turu Yok");
  }
}
