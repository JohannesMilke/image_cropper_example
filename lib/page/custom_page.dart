import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_example/utils.dart';
import 'package:image_cropper_example/widget/floating_button.dart';
import 'package:image_cropper_example/widget/image_list_widget.dart';

class CustomPage extends StatefulWidget {
  final bool isGallery;

  const CustomPage({
    Key key,
    @required this.isGallery,
  }) : super(key: key);

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
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
      cropImage: cropCustomImage,
    );

    if (file == null) return;
    setState(() => imageFiles.add(file));
  }

  static Future<File> cropCustomImage(File imageFile) async =>
      await ImageCropper.cropImage(
        aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
        sourcePath: imageFile.path,
        androidUiSettings: androidUiSettings(),
        iosUiSettings: iosUiSettings(),
      );

  static IOSUiSettings iosUiSettings() => IOSUiSettings(
        aspectRatioLockEnabled: false,
      );

  static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
      );
}
