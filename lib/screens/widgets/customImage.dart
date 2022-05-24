// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double kheight;
  final double kwidth;
  const CustomImage({
    Key? key,
    required this.image,
    required this.kheight,
    required this.kwidth,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(image))),
      height: kheight,
      width: kwidth,
    );
  }
}