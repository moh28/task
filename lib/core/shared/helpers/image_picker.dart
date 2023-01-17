import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../generated/locale_keys.g.dart';

class AppAlert {
  static AppAlert get init => AppAlert._();
  AppAlert._();

  Future imagePickerDialog({Function(File file)? onSubmit, bool withCrop = false, Function(List<File> file)? onSubmitMulti,required BuildContext context}) async {
    ImagePicker pick = ImagePicker();
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoButton(
            child: Text(LocaleKeys.cancel.tr()),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            CupertinoButton(
              child: Row(
                children: <Widget>[
                  const Icon(CupertinoIcons.photo_camera_solid,),
                  const SizedBox(width: 20),
                  Text(LocaleKeys.camera.tr()),
                ],
              ),
              onPressed: () async {
                XFile? pickedFile = await pick.pickImage(source: ImageSource.camera, maxWidth: 400);
                if (pickedFile != null) {
                  Navigator.pop(context);
                  if (onSubmit != null) onSubmit(File(pickedFile.path));
                  if (onSubmitMulti != null) onSubmitMulti([File(pickedFile.path)]);
                }
              },
            ),
            CupertinoButton(
              child: Row(
                children: <Widget>[
                  const Icon(Icons.insert_photo),
                  const SizedBox(width: 20),
                  Text(LocaleKeys.gallery.tr()),
                ],
              ),
              onPressed: () async {
                if (onSubmitMulti != null) {
                  List<XFile> result = await pick.pickMultiImage();
                  if (result.isNotEmpty) {
                    Navigator.pop(context);
                    onSubmitMulti(List.generate(result.length, (index) => File(result[index].path)));
                  }
                } else if (onSubmit != null) {
                  XFile? pickedFile = await pick.pickImage(source: ImageSource.gallery, maxWidth: 400);

                  if (pickedFile != null) {
                    Navigator.pop(context);
                    onSubmit(File(pickedFile.path));
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

}
