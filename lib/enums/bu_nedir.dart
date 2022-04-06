enum BuNedirEnum { siniflandirma, riskLimiti, uyariMesaji, emniyetStogu }

extension BuNedirValueAciklama on BuNedirEnum {
  String getAciklama({String? cariAdi}) {
    switch (this) {
      case BuNedirEnum.siniflandirma:
        return "Sınıflandirma;\nCarinin${(cariAdi != null ? "($cariAdi)" : "")} kategorisini belirleyip, size yaptığınız işlemlerde, sadece renk kodu ile görünecektir";

      case BuNedirEnum.riskLimiti:
        return "Risk Limiti;\nEmniyet stoğu gibi çalışıp, Cari'nin${(cariAdi != null ? "($cariAdi)" : "")} bu değeri geçmesi durumunda uyarı veren sistemdir.";

      case BuNedirEnum.uyariMesaji:
        return "Uyarı Mesajı;\nBu Cari${(cariAdi != null ? "($cariAdi)" : "")} ile olan işlemlerinizde size yazılı olarak görünecektir";
      case BuNedirEnum.emniyetStogu:
        return "Emniyet Stoğu;\nStoğun bu sınırın altına düştüğünde uyarı veren değerdir";

      default:
       throw Exception("Değer Yok=> BuNedirEnum");
    }
  }
}
