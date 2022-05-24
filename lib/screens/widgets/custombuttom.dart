import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';

class CustomButtom extends StatefulWidget {
  const CustomButtom(
      {Key? key,
      required this.responsive,
      required this.left,
      required this.right,
      required this.text,
      this.top,
      this.height,
      this.widht,
      this.callback})
      : super(key: key);

  final Responsive responsive;
  final String text;
  final double left;
  final double right;
  final double? top;
  final double? height;
  final double? widht;
  final VoidCallback? callback;

  @override
  State<CustomButtom> createState() => _CustomButtomState();
}

class _CustomButtomState extends State<CustomButtom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: widget.top ?? kDimens50, left: widget.left, right: widget.right),
      child: Container(
        child: Center(
          child: CustomText(
              colortext: kColorwhite,
              data: widget.text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center),
        ),
        decoration: BoxDecoration(
            color: kColorgreenblue,
            borderRadius: BorderRadius.circular(kDimens50)),
        height: widget.height ?? kDimens50,
        width: widget.widht ?? widget.responsive.wp(80),
      ),
    );
  }
}
