import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SozlesmeView extends StatelessWidget {
  const SozlesmeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          titleText: "Sözleşme",
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 13.0, right: 25, top: 15, bottom: 15),
          child: Column(
            children: [
              Text(
                "Sorumluluk Reddi Beyanı",
                style: context.textTheme.headline6,
              ),
              const Divider(),
              const Text(
                """
      İş bu uygulama, tamamen ticari faaliyet amacından uzak olup, proje amaçlı geliştirilmiştir.

      Herhangi bir veri kaybı veya tutarsızlığı ve saire durumlardan oluşabilecek herhangi bir olumsuzluk durumunun kullanıcıya ait olduğunu bildiririz.

      Yasal bir sorumluluğumuzun olmadığını, tüm sorumluluğun kullanıcıya ait olduğunu beyan ederiz.
                
      Teşekkürler
      Cari Hesapp Proje Takımı
                """,
                textAlign: TextAlign
                    .justify, /* 
                style: TextStyle(fontSize: 1), */
              ),
            ],
          ),
        ),
      ),
    );
  }
}
