import 'dart:io';

import 'package:cari_hesapp_lite/components/appbar/my_app_bar.dart';
import 'package:cari_hesapp_lite/components/buttons/rounded_button.dart';
import 'package:cari_hesapp_lite/components/dialogs/custom_alert_dialog.dart';
import 'package:cari_hesapp_lite/components/scroll_column.dart';
import 'package:cari_hesapp_lite/components/snack_bar.dart/snack_bar.dart';
import 'package:cari_hesapp_lite/components/text_fields/base_form_field.dart';
import 'package:cari_hesapp_lite/components/text_fields/rounded_text_field.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/enums/route_names.dart';
import 'package:cari_hesapp_lite/models/user_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/services/firebase/storage/service/storage_service.dart';
import 'package:cari_hesapp_lite/utils/image/image_util.dart';
import 'package:cari_hesapp_lite/utils/my_view_progress_indicator.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/profile_view/profile_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../utils/user_provider.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  late ProfileViewModel _viewModel;
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _viewModel = Provider.of<ProfileViewModel>(context);
    _userProvider = Provider.of<UserProvider>(context);

    var user = _viewModel.user;
    var isEditing = _viewModel.isEditing;

    return WillPopScope(
      onWillPop: () async {
        var user = FirebaseAuth.instance.currentUser;
        var progress = MyViewProgressUtil(context);

        if (user != null) await user.reload();
        progress.closeProgress();
        return true;
      },
      child: AnimatedSize(
          duration: const Duration(milliseconds: 400),
          child: Scaffold(
            appBar: MyAppBar(
              titleText: "Profil",
              actions: [
                if (_viewModel.isOwner)
                  IconButton(
                      onPressed: (false /* user == null */)
                          ? null
                          : () async {
                              /*  goToView(context,
                                    viewToGo: ProfileAddView(),
                                    viewModel:
                                        ProfileAddViewModel.showExist(user)); */
                              /*    if (_viewModel.isEditing) {
                              var progress = MyViewProgressUtil(context);
    
                              await _viewModel.setUsersField().then((value) {
                                progress.closeProgress();
                              });
                            } */

                              if (_viewModel.isEditing) _viewModel.saveFields();

                              _viewModel.isEditing = !_viewModel.isEditing;
                            },
                      icon: _viewModel.isEditing
                          ? const Icon(Icons.check)
                          : const Icon(Icons.edit))
              ],
            ),
            body: false //user == null
                ? const Center(child: Text("Böyle bir kullacını bulanamadı!"))
                : MyColumn(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: user?.photoURL != null
                                ? Image.network(
                                    user!.photoURL!,
                                  ).image
                                : _viewModel.ppStoragePath() ?? defaultImage,
                            radius: width(context) / 4,
                          ),
                          Positioned(
                              right: 11,
                              bottom: 11,
                              child: GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const ShapeDecoration(
                                      color: Colors.white70,
                                      shape: CircleBorder()),
                                  child: const Icon(Icons.edit_outlined),
                                ),
                                onTap: () async {
                                  _viewModel.isBottomOpen =
                                      !_viewModel.isBottomOpen;
                                  File? image = await ImageUtil().getImage(
                                    context,
                                  );

                                  if (image != null) {
                                    var url = await StorageService().setImage(
                                        StorageFolder.users,
                                        _viewModel.userId,
                                        image,
                                        "pp.jpeg");
                              

                                    DBUtils().addOrSetModel(
                                        user!.copyWith(photoURL: url));
                                  }
                                },
                              ))
                        ],
                      ),
                      const Divider(),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: 1,
                            child: _buildRow(context,
                                iconData: Icons.person,
                                controller: _viewModel.controllerAdi,
                                viewModel: _viewModel),
                          ),
                          Flexible(
                            flex: 1,
                            child: _buildRow(context,
                                controller: _viewModel.controllerSoyadi,
                                viewModel: _viewModel),
                          ),
                        ],
                      ),
                      _buildRow(context,
                          iconData: Icons.phone_outlined,
                          controller: _viewModel.controllerTel,
                          viewModel: _viewModel),
                      _buildRow(context,
                          iconData: Icons.email_outlined,
                          controller: _viewModel.controllerEmail,
                          readOnly: true,
                          onPressed: !isEditing
                              ? null
                              : () {
                                  _showEmailChangeDialog(context);
                                },
                          viewModel: _viewModel),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 400),
                        child: _viewModel.isEditing
                            ? _buildRow(context,
                                iconData: Icons.security,
                                viewModel: _viewModel,
                                readOnly: true, onPressed: () {
                                _showPassChangeDialog(context, _viewModel);
                              },
                                controller: TextEditingController(
                                    text: "****(Şifreniz)"))
                            : const SizedBox.shrink(),
                      ),
                      Visibility(
                          visible: _viewModel.verify,
                          child: RoundedButton(
                            "Kaydet",
                            onPressed: () async {
                              await _viewModel.saveFields();
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteNames.AuthWrapper.route,
                                  (route) => false);
                            },
                          ))
                    ],
                  ),
          )),
    );
  }

  Future<dynamic> _showEmailChangeDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider<ProfileViewModel>.value(
        value: _viewModel,
        child: const _EmailDialog(),
      ),
    );
  }

  Future<dynamic> _showPassChangeDialog(
      BuildContext context, ProfileViewModel viewModel) {
    return showDialog(
        context: context,
        builder: (context) {
          return ChangeNotifierProvider<ProfileViewModel>.value(
            value: viewModel,
            child: const _PassDialog(),
          );
        });
  }

  Widget _buildRow(BuildContext context,
      {IconData? iconData,
      VoidCallback? onPressed,
      TextEditingController? controller,
      required ProfileViewModel viewModel,
      bool? readOnly}) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: iconData != null,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(iconData),
                ),
              ),
              /* SizedBox(width: MediaQuery.of(context).size.width * 0.05), */
              Expanded(
                  child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: BaseFormField(
                    enabled: viewModel.isEditing,
                    padding: const EdgeInsets.all(0),
                    controller: controller,
                    border: OutlineInputBorder(
                        borderSide: _viewModel.isEditing
                            ? const BorderSide()
                            : BorderSide.none), //InputBorder.none,
                    readOnly: readOnly ?? !viewModel.isEditing,
                    onTap: (readOnly != null && readOnly) ? onPressed : null,
                    style: context.textTheme.headline6),
              )),
              /*   Expanded(
              child: Container(
                color: Colors.amberAccent.shade100,
                alignment: Alignment.center,
                child: TextField(
                  
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                  ),
                  style: context.textTheme.subtitle1,
                  maxLines: 3,
                ),
              ),
            ), */
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailDialog extends StatelessWidget {
  const _EmailDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileViewModel>(context);

    return CustomAlertDialog(
      title: "Email Değiştir",
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: viewModel.formKeyChangeEmail,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (viewModel.warningOldPass != null)
                _WarningText(warning: viewModel.warningOldPass!),
              MyRoundedTextField(
                label: "Güncel Şifreniz",
                controller: viewModel.controllerChangeEmailPassword,
                obscureText: !viewModel.isPassVisible,
                enableSuggestions: false,
                suffixIcon: IconButton(
                  onPressed: () {
                    viewModel.isPassVisible =
                        viewModel.isPassVisible ? false : true;
                  },
                  icon: Icon(!viewModel.isPassVisible
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash),
                ),
              ),
              if (viewModel.warningNewEmail != null)
                _WarningText(warning: viewModel.warningNewEmail!),
              MyRoundedTextField(
                label: "Yeni Email",
                keyboardType: TextInputType.emailAddress,
                controller: viewModel.controllerChangeEmailEmail,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              viewModel.removeDialogFields();

              Navigator.pop(context);
            },
            child: const Text("Vazgeç")),
        TextButton(
            onPressed: () async {
              var result = await viewModel.changeEmail();
              if (result) {
                showSnackBar(
                    context: context,
                    message:
                        """${viewModel.controllerChangeEmailEmail.text} adresine 
                    doğrulama maili gönderildi""");

                viewModel.removeDialogFields();
                Navigator.pop(context);
              }
            },
            child: const Text("Tamam")),
      ],
    );
  }
}

class _PassDialog extends StatelessWidget {
  const _PassDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProfileViewModel>(context);
    return CustomAlertDialog(
      title: "Şifre Yenileme",
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: viewModel.formKeyChangeEmail,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (viewModel.warningOldPass != null)
                  _WarningText(warning: viewModel.warningOldPass!),
                MyRoundedTextField(
                  label: "Güncel Şifreniz",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !viewModel.isPassVisible,
                  enableSuggestions: false,
                  controller: viewModel.controllerChangePasswordOldPass,
                  suffixIcon: IconButton(
                    onPressed: () {
                      viewModel.isPassVisible =
                          viewModel.isPassVisible ? false : true;
                    },
                    icon: Icon(!viewModel.isPassVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash),
                  ),
                ),
                MyRoundedTextField(
                  label: "Yeni Şifre",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !viewModel.isPassVisible,
                  enableSuggestions: false,
                  controller: viewModel.controllerChangePasswordNew1Pass,
                ),
                if (viewModel.warningNewPass != null)
                  _WarningText(warning: viewModel.warningNewPass!),
                MyRoundedTextField(
                    label: "Şifre Tekrar",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !viewModel.isPassVisible,
                    enableSuggestions: false,
                    controller: viewModel.controllerChangePasswordNew2Pass),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              viewModel.removeDialogFields();
              Navigator.pop(context);
            },
            child: const Text("Vazgeç")),
        TextButton(
            onPressed: () async {
              var result = await viewModel.changePassword();

              if (result) {
                viewModel.removeDialogFields();
                showSnackBar(
                    context: context, message: "Şifre başarıyla değiştirildi");
                Navigator.pop(context);
              }
            },
            child: const Text("Tamam")),
      ],
    );
  }
}

class _WarningText extends StatelessWidget {
  const _WarningText({
    Key? key,
    required this.warning,
  }) : super(key: key);

  final String warning;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          "*" + warning,
          style: context.textTheme.caption!.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
