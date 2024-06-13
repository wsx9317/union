import 'dart:io';

import 'package:flutter/material.dart';

//URL 이미지 controller
class IdImageBox3 extends StatefulWidget {
  final double imageWidth;
  final double imageHeight;
  final File imagePath;
  final BoxFit imageFit;
  const IdImageBox3({super.key, required this.imageWidth, required this.imageHeight, required this.imagePath, required this.imageFit});

  @override
  State<IdImageBox3> createState() => _IdImageBox3State();
}

class _IdImageBox3State extends State<IdImageBox3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.imageWidth,
      height: widget.imageHeight,
      child: Image.file(
        widget.imagePath,
        fit: widget.imageFit,
      ),
    );
  }
}
