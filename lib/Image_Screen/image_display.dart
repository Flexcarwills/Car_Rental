import 'dart:io';

import 'package:flutter/material.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key, required this.imageFileList});

  final imageFileList;
  @override
  State<StatefulWidget> createState() {
    return _ImageDisplayState();
  }
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: widget.imageFileList.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              File(widget.imageFileList[index].path),
              fit: BoxFit.cover,
            ),
          );
        });
  }
}
