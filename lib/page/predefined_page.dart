import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_example/utils.dart';
import 'package:image_cropper_example/widget/floating_button.dart';
import 'package:image_cropper_example/widget/image_list_widget.dart';

class PredefinedPage extends StatefulWidget {
  final bool isGallery;

  const PredefinedPage({
    Key key,
    @required this.isGallery,
  }) : super(key: key);

  @override
  _PredefinedPageState createState() => _PredefinedPageState();
}

class _PredefinedPageState extends State<PredefinedPage> {
  List<File> imageFiles = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ImageListWidget(imageFiles: imageFiles),
        floatingActionButton: FloatingButtonWidget(onClicked: onClickedButton),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  Future onClickedButton() async {
    final file = await Utils.pickMedia(
      isGallery: widget.isGallery,
      cropImage: cropPredefinedImage,
    );

    if (file == null) return;
    setState(() => imageFiles.add(file));
  }

  Future<File> cropPredefinedImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: androidUiSettingsLocked(),
        iosUiSettings: iosUiSettingsLocked(),
      );

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        aspectRatioLockEnabled: false,
        resetAspectRatioEnabled: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      );
}
