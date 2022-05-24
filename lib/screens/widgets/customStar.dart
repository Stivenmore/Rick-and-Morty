// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';

class CustomStar extends StatefulWidget {
  const CustomStar({
    Key? key,
    required this.validate,
    this.kcolor
  }) : super(key: key);

  final bool validate;
  final Color? kcolor;

  @override
  State<CustomStar> createState() => _CustomStarState();
}

class _CustomStarState extends State<CustomStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDimens50),
          color: widget.kcolor ?? kColorgray.withOpacity(0.3)),
      child: Icon(
        Icons.star,
        color: widget.validate == false ? kColorgrayDetail : kColoryellow,
      ),
      height: kDimens36,
      width: kDimens36,
    );
  }
}