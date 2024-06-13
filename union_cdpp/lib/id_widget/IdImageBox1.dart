// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

//로컬 이미지 controller
class IdImageBox extends StatefulWidget {
  final double? imageWidth;
  final double? imageHeight;
  final String imagePath;
  final BoxFit imageFit;

  const IdImageBox({
    Key? key,
    this.imageWidth,
    this.imageHeight,
    required this.imagePath,
    required this.imageFit,
  }) : super(key: key);

  @override
  State<IdImageBox> createState() => _IdImageBoxState();
}

class _IdImageBoxState extends State<IdImageBox> {
  @override
  Widget build(BuildContext context) {
    var img = Image.asset(widget.imagePath, fit: widget.imageFit);

    return SizedBox(
      width: widget.imageWidth,
      height: widget.imageHeight,
      child: img,
    );
  }
}
