
    /*
Sevk irsaliyesinde bulunması gereken bilgiler;

3- Gönderilen malın cinsi ve miktarı,  todo #islemKodu ->  hepsi

5- İrsaliyeyi düzenleyen mükellefin; adı, soyadı ile varsa ticaret unvanı, iş adresi, vergi dairesi ve hesap numarası,
6- Müşterinin adı, ticaret unvanı, varsa vergi dairesi, adresi ve hesap numarası, todo #cariId -> hepsi
7- Malın, taşıyana teslim tarihi, saati ve müteselsil irsaliye numarası, todo
                                                                          sevkTarihi -> sevkİrsaliye ve IrsaliyeliFatura
                                                                          duzenlemeTarihi  -> hepsi
                                                                          duzenlemeSaati -> hepsi
8- Mükellefin diğer iş yerine veya satılmak üzere bir alıcıya (müşteriye) gönderdiği hallerde malın kime ve nereye gönderildiği ayrıca belirtilir.*/

/*
    FATURADA BULUNMASI GEREKEN ASGARİ UNSURLAR;
1- Faturanın düzenlenme tarihi, sıra ve seri numarası, todo
                                                            sıraNo (belgeNo) -> hepsi
                                                            seri -> hepsi
2- Müşterinin adı, ticaret unvanı, adresi, varsa vergi dairesi ve hesap numarası, todo cariId
4- Malın veya işin nevi, miktarı, fiyatı ve tutarı todo işlemKodu
5- Satılan malların teslim tarihi, saati ve irsaliye numarası.*/

/*
*   yusuf muhasebe: Yedi günlük periyotlar halinde maksimum faturalanmasi gerekiyor
    yusuf muhasebe: 7 güne denk gelen irsaliyeler toplanır faturaya irsaliye nolari yazılır
    yusuf muhasebe: Özellikli durum ayın sonuna denk gelen irsaliyeler yeni aya devir etmeden faturalanir
    yusuf muhasebe: Misal 28 29 30 gunlere ait faturalar en geç 30 faturalanir
    yusuf muhasebe: 1 ile birleşemez
   * */


 
    /*
Sevk irsaliyesinde bulunması gereken bilgiler;
1- Sevk irsaliyesi ibaresi,
2- Maliye Bakanlığı klişesi veya noter tasdik mührü şekli,
3- Gönderilen malın cinsi ve miktarı,
4- Düzenleyenin, malı alan ve teslim edenin imzaları,
5- İrsaliyeyi düzenleyen mükellefin; adı, soyadı ile varsa ticaret unvanı, iş adresi, vergi dairesi ve hesap numarası,
6- Müşterinin adı, ticaret unvanı, varsa vergi dairesi, adresi ve hesap numarası,
7- Malın, taşıyana teslim tarihi, saati ve müteselsil irsaliye numarası,
8- Mükellefin diğer iş yerine veya satılmak üzere bir alıcıya (müşteriye) gönderdiği hallerde malın kime ve nereye gönderildiği ayrıca belirtilir.*/



/*
    FATURADA BULUNMASI GEREKEN ASGARİ UNSURLAR;
1- Faturanın düzenlenme tarihi, sıra ve seri numarası,
2- Müşterinin adı, ticaret unvanı, adresi, varsa vergi dairesi ve hesap numarası,
3- Faturayı düzenleyenin adı, varsa ticaret unvanı, iş adresi, bağlı olduğu vergi dairesi ve hesap numarası,
4- Malın veya işin nevi, miktarı, fiyatı ve tutarı
5- Satılan malların teslim tarihi, saati ve irsaliye numarası.*/


//Cari İşlem'ler ayrıca belge görevi görecek
// ->irsaliyeli fatura
// ->Sevk İrsaliyesi
// ->Makbuz (G.Resmi)
///Bu alan sevk irsaliyelerini faturaya çevirir
class Fatura  {
  String? faturaId;

  List<String>? sevkIrsaliyeKeyList;
}
