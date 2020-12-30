import 'dart:io';

import 'package:flutter/material.dart';

class ImageListWidget extends StatelessWidget {
  final List<File> imageFiles;

  const ImageListWidget({
    Key key,
    @required this.imageFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GridView.count(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(12),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: imageFiles
            .map((imageFile) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(imageFile),
                ))
            .toList(),
      );
}
