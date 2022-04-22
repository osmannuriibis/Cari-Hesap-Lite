import 'dart:io';

import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/buttons/base_primary_button.dart';
import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:cari_hesapp_lite/components/text_fields/base_form_field.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/services/firebase/auth/service/auth_service.dart';
import 'package:cari_hesapp_lite/services/firebase/database/service/database_service.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/konum_service/konum_service.dart';
import 'package:cari_hesapp_lite/utils/my_view_progress_indicator.dart';
import 'package:cari_hesapp_lite/views/contribution_view/contribution_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../services/firebase/storage/service/storage_service.dart';
import '../../utils/image/image_util.dart';

// ignore: must_be_immutable
class ContributionView extends StatelessWidget {
  ContributionView({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  late ContributionViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<ContributionViewModel>(context);
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
Geri bildirimleriniz bizim için çok değerlidir
Konu ile alakalı görüntü ekleyebilirsiniz (opsiyonel)
""",

                      ///  style: context.textTheme.ti
                    ),
                    const Divider(),
                    const Align(
                        alignment: Alignment.centerLeft, child: Text("*Konu:")),
                    BaseFormField(
                      controller: viewModel.controllerKonu,
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
                      controller: viewModel.controllerMesaj,
                      validator: (String? val) {
                        if (val.isNullOrEmpty) return "Zorunlu alan";
                        return null;
                      },
                      minLines: 3,
                      maxLines: 6,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    const Divider(),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Görüntü:")),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              File? image = await ImageUtil().getImage(context,
                                  cropStyle: CropStyle.rectangle);
                              if (image == null) return;
                              viewModel.image = image;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 3),
                              width: 50,
                              height: 50,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 900),
                                child: viewModel.image != null
                                    ? Image.file(viewModel.image!)
                                    : const Icon(Icons.no_photography_outlined),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    width: 1,
                                    color: kPrimaryColor,
                                  ),
                                  shape: BoxShape.rectangle),
                            ),
                          ),
                          if (viewModel.image != null)
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: GestureDetector(
                                onTap: () {
                                  viewModel.image = null;
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const ShapeDecoration(
                                      color: kPrimaryColor,
                                      shape: CircleBorder()),
                                  child: const Icon(
                                    Icons.close_outlined,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    const Divider(),
                    MyBaseButton(
                        onPressed: () async {
                          var progress = MyViewProgressUtil(context);
                          if (formKey.currentState!.validate()) {
                            var id = DBService()
                                .firestoreInstance
                                .collection("collectionPath")
                                .doc()
                                .id;
                            String? url;

                            if (viewModel.image != null) {
                              url = await StorageService().setImage(
                                  StorageFolder.mesajlar,
                                  AuthService().currentUserId ?? "",
                                  viewModel.image!,
                                  id);
                            }
                            DBService()
                                .firestoreInstance
                                .collection("mesajlar")
                                .doc(id)
                                .set({
                              "id": id,
                              "imageUrl": url,
                              "subject": viewModel.controllerKonu.text.trim(),
                              "message": viewModel.controllerMesaj.text.trim(),
                              "userId": AuthService().currentUserId,
                              "userName": AuthService().currentUserDisplayName,
                              "location":
                                  KonumService().lastLocation?.toGeoPoint,
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
                          progress.closeProgress();
                        },
                        buttonText: "GÖNDER")
                  ],
                ),
              ),
            )));
  }
}
