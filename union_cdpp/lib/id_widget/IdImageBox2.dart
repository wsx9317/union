import 'package:flutter/material.dart';

//URL 이미지 controller
class IdImageBox2 extends StatefulWidget {
  final double? imageWidth;
  final double? imageHeight;
  final double? round;
  final String imagePath;
  final BoxFit imageFit;
  const IdImageBox2({super.key, this.imageWidth, this.imageHeight, this.round, required this.imagePath, required this.imageFit});

  @override
  State<IdImageBox2> createState() => _IdImageBox2State();
}

class _IdImageBox2State extends State<IdImageBox2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.imageWidth,
      height: widget.imageHeight,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.imagePath),
          fit: widget.imageFit,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.round!)),
      ),
    );

    // SizedBox(
    //   width: widget.imageWidth,
    //   height: widget.imageHeight,
    //   child: Image.network(
    //     widget.imagePath,
    //     fit: widget.imageFit,
    //   ),
    // );
  }
}
