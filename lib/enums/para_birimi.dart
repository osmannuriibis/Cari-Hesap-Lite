// ignore_for_file: constant_identifier_names

enum ParaBirimi {
  TRY,
  USD,
  EUR,
  JPY,
  EGP,
  LKR,
  GBP,
  AUD,
  CAD,
  CHF,
  CNY,
  HKD,
  NZD,
  SEK,
  KRW,
  SGD,
  NOK,
  MXN,
  INR,
  RUB,
  ZAR,
  BRL,
  TWD,
  DKK,
  PLN,
  THB,
  IDR,
  HUF,
  CZK,
  ILS,
  CLP,
  PHP,
  AED,
  COP,
  SAR,
  MYR,
  RON,
  KWD
}
/* static const String TRY = "TRY";
  static const String USD = "USD";
  static const String EUR = "EUR";

  static const String JPY = "JPY";
  static const String EGP = "EGP";
  static const String LKR = "LKR";
  static const String GBP = "GBP";
  static const String AUD = "AUD";
  static const String CAD = "CAD";
  static const String CHF = "CHF";
  static const String CNY = "CNY";
  static const String HKD = "HKD";
  static const String NZD = "NZD";
  static const String SEK = "SEK";
  static const String KRW = "KRW";
  static const String SGD = "SGD";
  static const String NOK = "NOK";
  static const String MXN = "MXN";
  static const String INR = "INR";
  static const String RUB = "RUB";
  static const String ZAR = "ZAR";
  static const String BRL = "BRL";
  static const String TWD = "TWD";
  static const String DKK = "DKK";
  static const String PLN = "PLN";
  static const String THB = "THB";
  static const String IDR = "IDR";
  static const String HUF = "HUF";
  static const String CZK = "CZK";
  static const String ILS = "ILS";
  static const String CLP = "CLP";
  static const String PHP = "PHP";
  static const String AED = "AED";
  static const String COP = "COP";
  static const String SAR = "SAR";
  static const String MYR = "MYR";
  static const String RON = "RON";
  static const String KWD = "KWD"; 
  


  
  
  
  */

extension ParaBirimiSembol on ParaBirimi? {
  String  toMap() => getKodu;
  String get getSembol {
    switch (this) {
     
      case ParaBirimi.TRY:
        return "₺";

      case ParaBirimi.USD:
        return "\$";
      case ParaBirimi.EUR:
        return "€";
      case ParaBirimi.JPY:
        return "¥";
      case ParaBirimi.EGP:
        return "E£";
      case ParaBirimi.LKR:
        return "Rs";
      case ParaBirimi.GBP:
        return "£";
      case ParaBirimi.AUD:
        return "A\$";
      case ParaBirimi.CAD:
        return "C\$";
      case ParaBirimi.CHF:
        return "CHF";
      case ParaBirimi.CNY:
        return "C¥";
      case ParaBirimi.HKD:
        return "H\$";
      case ParaBirimi.NZD:
        return "NZD";
      case ParaBirimi.SEK:
        return "SEK";
      case ParaBirimi.KRW:
        return "₩";
      case ParaBirimi.SGD:
        return "S\$";
      case ParaBirimi.NOK:
        return "kr";
      case ParaBirimi.MXN:
        return "MX\$";
      case ParaBirimi.INR:
        return "₹";
      case ParaBirimi.RUB:
        return "₽";
      case ParaBirimi.ZAR:
        return "ZAR";
      case ParaBirimi.BRL:
        return "R\$";
      case ParaBirimi.TWD:
        return "NT\$";
      case ParaBirimi.DKK:
        return "DKK";
      case ParaBirimi.PLN:
        return "zł";
      case ParaBirimi.THB:
        return "฿";
      case ParaBirimi.IDR:
        return "Rp";
      case ParaBirimi.HUF:
        return "Ft";
      case ParaBirimi.CZK:
        return "Kč";
      case ParaBirimi.ILS:
        return "₪";
      case ParaBirimi.CLP:
        return "CH\$";
      case ParaBirimi.PHP:
        return "₱";
      case ParaBirimi.AED:
        return "د.إ";
      case ParaBirimi.COP:
        return "CO\$";
      case ParaBirimi.SAR:
        return "﷼";
      case ParaBirimi.MYR:
        return "RM";
      case ParaBirimi.RON:
        return "lei";
      case ParaBirimi.KWD:
        return "د.ك";

      default:
        throw RangeError(toString() + " is out of the ParaBirimi Values");
    }
  }

  String get getKodu {
    switch (this) {
      case ParaBirimi.TRY:
        return "TRY";

      case ParaBirimi.USD:
        return "USD";
      case ParaBirimi.EUR:
        return "EUR";
      case ParaBirimi.JPY:
        return "JPY";
      case ParaBirimi.EGP:
        return "EGP";
      case ParaBirimi.LKR:
        return "LKR";
      case ParaBirimi.GBP:
        return "GBP";
      case ParaBirimi.AUD:
        return "AUD";
      case ParaBirimi.CAD:
        return "CAD";
      case ParaBirimi.CHF:
        return "CHF";
      case ParaBirimi.CNY:
        return "CNY";
      case ParaBirimi.HKD:
        return "HKD";
      case ParaBirimi.NZD:
        return "NZD";
      case ParaBirimi.SEK:
        return "SEK";
      case ParaBirimi.KRW:
        return "KRW";
      case ParaBirimi.SGD:
        return "SGD";
      case ParaBirimi.NOK:
        return "NOK";
      case ParaBirimi.MXN:
        return "MXN";
      case ParaBirimi.INR:
        return "INR";
      case ParaBirimi.RUB:
        return "RUB";
      case ParaBirimi.ZAR:
        return "ZAR";
      case ParaBirimi.BRL:
        return "BRL";
      case ParaBirimi.TWD:
        return "TWD";
      case ParaBirimi.DKK:
        return "DKK";
      case ParaBirimi.PLN:
        return "PLN";
      case ParaBirimi.THB:
        return "THB";
      case ParaBirimi.IDR:
        return "IDR";
      case ParaBirimi.HUF:
        return "HUF";
      case ParaBirimi.CZK:
        return "CZK";
      case ParaBirimi.ILS:
        return "ILS";
      case ParaBirimi.CLP:
        return "CLP";
      case ParaBirimi.PHP:
        return "PHP";
      case ParaBirimi.AED:
        return "AED";
      case ParaBirimi.COP:
        return "COP";
      case ParaBirimi.SAR:
        return "SAR";
      case ParaBirimi.MYR:
        return "MYR";
      case ParaBirimi.RON:
        return "RON";
      case ParaBirimi.KWD:
        return "KWD";
      default:
        throw RangeError(toString() + " is out of the ParaBirimi Values");
    }
  }

/*   String get getDovizAdi {
    switch (this) {
      case ParaBirimi.TRY:
        return "TRY";

      case ParaBirimi.USD:
        return "USD";
      case ParaBirimi.EUR:
        return "EUR";
      case ParaBirimi.JPY:
        return "JPY";
      case ParaBirimi.EGP:
        return "EGP";
      case ParaBirimi.LKR:
        return "LKR";
      case ParaBirimi.GBP:
        return "GBP";
      case ParaBirimi.AUD:
        return "AUD";
      case ParaBirimi.CAD:
        return "CAD";
      case ParaBirimi.CHF:
        return "CHF";
      case ParaBirimi.CNY:
        return "CNY";
      case ParaBirimi.HKD:
        return "HKD";
      case ParaBirimi.NZD:
        return "NZD";
      case ParaBirimi.SEK:
        return "SEK";
      case ParaBirimi.KRW:
        return "KRW";
      case ParaBirimi.SGD:
        return "SGD";
      case ParaBirimi.NOK:
        return "NOK";
      case ParaBirimi.MXN:
        return "MXN";
      case ParaBirimi.INR:
        return "INR";
      case ParaBirimi.RUB:
        return "RUB";
      case ParaBirimi.ZAR:
        return "ZAR";
      case ParaBirimi.BRL:
        return "BRL";
      case ParaBirimi.TWD:
        return "TWD";
      case ParaBirimi.DKK:
        return "DKK";
      case ParaBirimi.PLN:
        return "PLN";
      case ParaBirimi.THB:
        return "THB";
      case ParaBirimi.IDR:
        return "IDR";
      case ParaBirimi.HUF:
        return "HUF";
      case ParaBirimi.CZK:
        return "CZK";
      case ParaBirimi.ILS:
        return "ILS";
      case ParaBirimi.CLP:
        return "CLP";
      case ParaBirimi.PHP:
        return "PHP";
      case ParaBirimi.AED:
        return "AED";
      case ParaBirimi.COP:
        return "COP";
      case ParaBirimi.SAR:
        return "SAR";
      case ParaBirimi.MYR:
        return "MYR";
      case ParaBirimi.RON:
        return "RON";
      case ParaBirimi.KWD:
        return "KWD";
      default:
        throw RangeError(this.toString() + " is out of the ParaBirimi Values");
    }
  } */
}

extension ParaBirimiAdi on String {
  ParaBirimi get toParaBirimiFromKodu {
    switch (this) {
      case "TRY":
        return ParaBirimi.TRY;

      case "USD":
        return ParaBirimi.USD;
      case "EUR":
        return ParaBirimi.EUR;
      case "JPY":
        return ParaBirimi.JPY;
      case "EGP":
        return ParaBirimi.EGP;
      case "LKR":
        return ParaBirimi.LKR;
      case "GBP":
        return ParaBirimi.GBP;
      case "AUD":
        return ParaBirimi.AUD;
      case "CAD":
        return ParaBirimi.CAD;
      case "CHF":
        return ParaBirimi.CHF;
      case "CNY":
        return ParaBirimi.CNY;
      case "HKD":
        return ParaBirimi.HKD;
      case "NZD":
        return ParaBirimi.NZD;
      case "SEK":
        return ParaBirimi.SEK;
      case "KRW":
        return ParaBirimi.KRW;
      case "SGD":
        return ParaBirimi.SGD;
      case "NOK":
        return ParaBirimi.NOK;
      case "MXN":
        return ParaBirimi.MXN;
      case "INR":
        return ParaBirimi.INR;
      case "RUB":
        return ParaBirimi.RUB;
      case "ZAR":
        return ParaBirimi.ZAR;
      case "BRL":
        return ParaBirimi.BRL;
      case "TWD":
        return ParaBirimi.TWD;
      case "DKK":
        return ParaBirimi.DKK;
      case "PLN":
        return ParaBirimi.PLN;
      case "THB":
        return ParaBirimi.THB;
      case "IDR":
        return ParaBirimi.IDR;
      case "HUF":
        return ParaBirimi.HUF;
      case "CZK":
        return ParaBirimi.CZK;
      case "ILS":
        return ParaBirimi.ILS;
      case "CLP":
        return ParaBirimi.CLP;
      case "PHP":
        return ParaBirimi.PHP;
      case "AED":
        return ParaBirimi.AED;
      case "COP":
        return ParaBirimi.COP;
      case "SAR":
        return ParaBirimi.SAR;
      case "MYR":
        return ParaBirimi.MYR;
      case "RON":
        return ParaBirimi.RON;
      case "KWD":
        return ParaBirimi.KWD;
      default:
        throw RangeError(this + " is out of the ParaBirimi Values");
    }
  }

  ParaBirimi get toParaBirimiFromSembol {
    switch (this) {
      case '₺':
        return ParaBirimi.TRY;

      case '\$':
        return ParaBirimi.USD;
      case '€':
        return ParaBirimi.EUR;

      case "¥":
        return ParaBirimi.JPY;
      case "E£":
        return ParaBirimi.EGP;
      case "Rs":
        return ParaBirimi.LKR;
      case "£":
        return ParaBirimi.GBP;
      case "A\$":
        return ParaBirimi.AUD;
      case "C\$":
        return ParaBirimi.CAD;
      case "CHF":
        return ParaBirimi.CHF;
      case "C¥":
        return ParaBirimi.CNY;
      case "H\$":
        return ParaBirimi.HKD;
      case "NZD":
        return ParaBirimi.NZD;
      case "SEK":
        return ParaBirimi.SEK;
      case "₩":
        return ParaBirimi.KRW;
      case "S\$":
        return ParaBirimi.SGD;
      case "kr":
        return ParaBirimi.NOK;
      case "MX\$":
        return ParaBirimi.MXN;
      case "₹":
        return ParaBirimi.INR;
      case "₽":
        return ParaBirimi.RUB;
      case "ZAR":
        return ParaBirimi.ZAR;
      case "R\$":
        return ParaBirimi.BRL;
      case "NT\$":
        return ParaBirimi.TWD;
      case "DKK":
        return ParaBirimi.DKK;
      case "zł":
        return ParaBirimi.PLN;
      case "฿":
        return ParaBirimi.THB;
      case "Rp":
        return ParaBirimi.IDR;
      case "Ft":
        return ParaBirimi.HUF;
      case "Kč":
        return ParaBirimi.CZK;
      case "₪":
        return ParaBirimi.ILS;
      case "CH\$":
        return ParaBirimi.CLP;
      case "₱":
        return ParaBirimi.PHP;
      case "د.إ":
        return ParaBirimi.AED;
      case "CO\$":
        return ParaBirimi.COP;
      case "﷼":
        return ParaBirimi.SAR;
      case "RM":
        return ParaBirimi.MYR;
      case "lei":
        return ParaBirimi.RON;
      case "د.ك":
        return ParaBirimi.KWD;

      default:
        throw RangeError(toString() + " is out of the ParaBirimi Values");
    }
  }
}
