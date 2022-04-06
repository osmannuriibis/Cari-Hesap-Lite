
import 'package:cari_hesapp_lite/enums/para_birimi.dart';
import 'package:cari_hesapp_lite/models/base_model/base_model.dart';
import 'package:cari_hesapp_lite/models/hesaplar_model/aaa_main/hesaplar_base.dart';
import 'package:cari_hesapp_lite/models/hesaplar_model/banka/banka_bagli_hesap.dart/banka_hesap_model.dart';
import 'package:cari_hesapp_lite/models/hesaplar_model/banka/banka_bagli_hesap.dart/kredi_kart.dart';
import 'package:cari_hesapp_lite/models/hesaplar_model/banka/banka_bagli_hesap.dart/pos.dart';


/// [BankaHesap], [PosHesap], [KartHesap]
abstract class BankaHesaplarBaseModel implements HesaplarBaseModel {
 
  

  String? aciklama;
  String? bagliBankaId;
  String? bagliBankaAdi;
}
