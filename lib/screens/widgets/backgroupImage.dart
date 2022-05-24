// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';

class BackGroudPhoto extends StatelessWidget {
  final BoxFit? fit;
  final double height;
  final double width;
  final double opacity;
  final String? image;
  const BackGroudPhoto({
    this.fit,
    this.image,
    required this.height,
    required this.width,
    required this.opacity,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kColorblack),
      height: height,
      width: width,
      child: Opacity(
        child: Image(image: AssetImage(image?? kbackgroudimages), fit: fit,),
        opacity: opacity,
      ),
    );
  }
}