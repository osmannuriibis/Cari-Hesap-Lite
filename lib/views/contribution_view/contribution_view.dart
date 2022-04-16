import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/buttons/base_primary_button.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/text_fields/base_form_field.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/services/firebase/database/service/database_service.dart';
import 'package:cari_hesapp_lite/utils/konum_service/konum_service.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ContributionView extends StatelessWidget {
  ContributionView({Key? key}) : super(key: key);
  TextEditingController controllerKonu = TextEditingController();
  TextEditingController controllerMesaj = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          titleText: "Sizi Dinliyoruz...",
        ),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: MyCard(
                child: Column(
                  children: [
                    const Text(
                      """Uygulamamız sizlerin istek, talep, görüş, öneri ve eleştirileriniz yönünde geliştirecektir.
Dolayısı ile uygulama hakkındaki mütemadiyen geri bildirimleriniz çok değerlidir""",

                      ///  style: context.textTheme.ti
                    ),
                    const Divider(),
                    const Align(
                        alignment: Alignment.centerLeft, child: Text("*Konu:")),
                    BaseFormField(
                      controller: controllerKonu,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      validator: (String? val) {
                        if (val.isNullOrEmpty) return "Zorunlu alan";
                        return null;
                      },
                    ),
                    const Divider(),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("*Mesaj:")),
                    BaseFormField(
                      controller: controllerMesaj,
                      validator: (String? val) {
                        if (val.isNullOrEmpty) return "Zorunlu alan";
                        return null;
                      },
                      minLines: 3,
                      maxLines: 6,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    const Divider(),
                    MyBaseButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            DBService()
                                .firestoreInstance
                                .collection("mesajlar")
                                .add({
                              "subject": controllerKonu.text.trim(),
                              "message": controllerMesaj.text.trim(),
                              "userId": AuthService().currentUserId,
                              "userName": AuthService().currentUserDisplayName,
                              "location":
                                  KonumService().lastLocation.toGeoPoint,
                              "time": DateTime.now(),
                              "email": AuthService().currentUser?.email
                            }).then((value) async {
                      
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Teşekkür Ederiz"),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.green,
                                              size: 40,
                                            ),
                                            Divider(),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                  """Bildiriminiz başarılı bir şekilde gönderildi"""),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("KAPAT"))
                                        ],
                                      ));
                              Navigator.pop(context);
                            });
                          }
                        },
                        buttonText: "GÖNDER")
                  ],
                ),
              ),
            )));
  }
}
