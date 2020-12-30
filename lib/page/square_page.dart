import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_example/utils.dart';
import 'package:image_cropper_example/widget/floating_button.dart';
import 'package:image_cropper_example/widget/image_list_widget.dart';

class SquarePage extends StatefulWidget {
  final bool isGallery;

  const SquarePage({
    Key key,
    @required this.isGallery,
  }) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
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
      cropImage: cropSquareImage,
    );

    if (file == null) return;
    setState(() => imageFiles.add(file));
  }

  Future<File> cropSquareImage(File imageFile) async =>
      await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        compressQuality: 70,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: androidUiSettingsLocked(),
        iosUiSettings: iosUiSettingsLocked(),
      );

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      );
}
