import 'dart:io';

import 'package:cari_hesapp_lite/components/dialogs/custom_alert_dialog.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  Future<File?> cropImage(File image) async {
    File? croppedFile = await ImageCropper() .cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        cropStyle: CropStyle.circle,
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Kırp',
            toolbarColor: kPrimaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Kırp',
        ));
    if (croppedFile != null) {
      return croppedFile;
    } else {
      return null;
    }
  }

  Future<File?> getImage(BuildContext context,
      {bool thenCropImage = true}) async {
    ImageSource? isCamera = (await showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text("Fotoğraf çek"),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text("Galeriden seç"),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    ));

    if (isCamera != null) {
      var pickedFile = (await ImagePicker().pickImage(source: isCamera));

      if (pickedFile != null) {
        if (thenCropImage) {
          return cropImage(File(pickedFile.path));
        } else {
          return File(pickedFile.path);
        }
      }
    }
  }
}
