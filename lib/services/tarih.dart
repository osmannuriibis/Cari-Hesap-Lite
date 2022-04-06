// class Tarih {
//   var calendar = DateTime.now();

//   int _dakika = 0;
//   int _saat = 0;

//   int _gun;
//   int _ay;
//   int _yil;

//   String _tamSaat;
//   String _tarih;
//   String _tamTarih;
//   String _ayAdi;
//   String _gunAdi;

//   static final int kisa = 0;
//   static final int uzun = 1;

//   Tarih() {
//     calendar = DateTime.now().toLocal();

//     _saat = calendar.hour;
//     _dakika = calendar.minute;

//     _gun = calendar.day;
//     _ay = calendar.month;
//     _yil = calendar.year;
//     _setTamSaat();
//     _setTarih();
//     _setTamTarih();
//     setAyAdi();
//     setGunAdi();
//   }

//   Tarih.tamTarih(int dakika, int saat, int gun, int ay, int yil) {
//     this._dakika = dakika;
//     this._saat = saat;
//     this._gun = gun;
//     this._ay = ay;
//     this._yil = yil;
//     DateTime(
//       yil,
      
//     );
//     calendar.setTimeZone(TimeZone.getDefault());
//     _setTamSaat();
//     _setTarih();
//     _setTamTarih();
//     setAyAdi();
//     setGunAdi();
//   }

//   Tarih.tarih(int gun, int ay, int yil) {
//     this._gun = gun;
//     this._ay = ay;
//     this._yil = yil;
//     calendar = new GregorianCalendar(yil, ay - 1, gun);
//     _setTamSaat();
//     _setTarih();
//     _setTamTarih();
//     setAyAdi();
//     setGunAdi();
//   }

//   Tarih.byType(String tamTarih, int tipi) {
//     if (tipi == uzun) {
//       //format GG/AA/YYYY SS:DD
//       //format 01/34/6789 12:45
//       dakika = Integer.parseInt(String.valueOf(tamTarih.charAt(14)) +
//           String.valueOf(tamTarih.charAt(15)));
//       saat = Integer.parseInt(String.valueOf(tamTarih.charAt(11)) +
//           String.valueOf(tamTarih.charAt(12)));

//       gun = Integer.parseInt(String.valueOf(tamTarih.charAt(0)) +
//           String.valueOf(tamTarih.charAt(1)));
//       ay = Integer.parseInt(String.valueOf(tamTarih.charAt(3)) +
//           String.valueOf(tamTarih.charAt(4)));
//       yil = Integer.parseInt(String.valueOf(tamTarih.charAt(6)) +
//           String.valueOf(tamTarih.charAt(7)) +
//           String.valueOf(tamTarih.charAt(8)) +
//           String.valueOf(tamTarih.charAt(9)));

//       calendar = new GregorianCalendar(yil, ay - 1, gun, saat, dakika);

//       _setTamSaat();
//       _setTarih();
//       _setTamTarih();
//       setAyAdi();
//       setGunAdi();
//     } else if (tipi == kisa) {
//       //format "GG/AA/YYYY"
//       //format "01/34/6789"
//       dakika = 0;
//       saat = 0;
//       gun = Integer.parseInt(String.valueOf(tamTarih.charAt(0)) +
//           String.valueOf(tamTarih.charAt(1)));
//       ay = Integer.parseInt(String.valueOf(tamTarih.charAt(3)) +
//           String.valueOf(tamTarih.charAt(4)));
//       yil = Integer.parseInt(String.valueOf(tamTarih.charAt(6)) +
//           String.valueOf(tamTarih.charAt(7)) +
//           String.valueOf(tamTarih.charAt(8)) +
//           String.valueOf(tamTarih.charAt(9)));

//       calendar = new GregorianCalendar(yil, ay - 1, gun);

//       _setTamSaat();
//       _setTarih();
//       _setTamTarih();
//       setAyAdi();
//       setGunAdi();
//     }
//   }

//   int get dakika => calendar.minute ?? 0;
  
//   int get saat => calendar.hour ?? 0;
  

//   String get tamSaat=>_tamSaat;
  

//   int get gun {
//     return _gun;
//   }

//   int get ay {
//     return _ay;
//   }

//   int get yil {
//     return _yil;
//   }

//   String get tarih {
//     return this._tarih =
//         "" + intToString(gun) + "/" + intToString(ay) + "/" + intToString(yil);
//   }

//   String get tamTarih {
//     return _tamTarih;
//   }

//   String get ayAdi {
//     return _ayAdi;
//   }

//   String get gunAdi() {
//     return _gunAdi;
//   }

//   /////
//   ////
//   ////
//   ////
//   ////

//   set dakika(int dakika) {
//     this.dakika = dakika;
//   }

//    set saat(int saat) {
//     this.saat = saat;
//   }

//    set gun(int gun) {
//     calendar.day = gun;
//     this._gun = gun;
//   }

//    set ay(int ay) {
//     calendar.set(Calendar.MONTH, ay);
//     this._ay = ay;
//   }

//    set yil(int yil) {
//     calendar.set(Calendar.YEAR, yil);
//     this._yil = yil;
//   }

//    _setTarih(int yil, int ay, int gun) {
//     calendar.set(yil, ay, gun);
//     this._yil = yil;
//     this._ay = ay;
//     this._gun = gun;
//     setTarih();
//     _setTamTarih();
//   }

//   void _setTamSaat(/*String*/) {
//     //format SS:DD
//     if (calendar.isSet(Calendar.HOUR_OF_DAY)) {
//       _tamSaat = intToString(saat) + ":" + intToString(dakika);
//     } else {
//       _tamSaat = "00:00";
//     }
//   }

//   void setTarih() {
//     //format GG/AA/YYYY;
//     this.tarih =
//         "" + intToString(gun) + "/" + intToString(ay) + "/" + intToString(yil);
//   }

//   void _setTamTarih() {
//     //format GG/AA/YYYY SS:DD
//     this.tamTarih = tarih + " " + tamSaat;
//   }

//   void setAyAdi() {
//     //exp: OCAK
//     this.ayAdi = calendar.getDisplayName(
//         Calendar.MONTH, Calendar.SHORT, Locale.getDefault());
//   }

//   void setGunAdi() {
//     this.gunAdi = calendar.getDisplayName(
//         Calendar.DAY_OF_WEEK, Calendar.SHORT, Locale.getDefault());
//   }

//   static String intToString(int deger) {
//     String degerString;
//     if (deger < 10) {
//       degerString = "0" + deger.toString();
//     } else {
//       degerString = "" + deger.toString();
//     }
//     return degerString;
//   }

//   void sifirla() {
//     this.saat = 0;
//     this.dakika = 0;

//     this.gun = 0;
//     this.ay = 0;
//     this.yil = 0;
//   }
// }
