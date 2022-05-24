import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final Color colortext;
  final double fontSize;
  final FontWeight fontWeight;
  final String data;
  final TextAlign? textAlign;
  final double? wordspacing;
  final double? letterSpacing;
  final double? height;
  final int? maxlines;
  const CustomText(
      {Key? key,
      required this.colortext,
      this.letterSpacing,
      this.wordspacing,
      this.height,
      this.maxlines,
      required this.data,
      required this.fontSize,
      required this.fontWeight,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              color: colortext,
              fontWeight: fontWeight,
              fontSize: fontSize,
              wordSpacing: wordspacing,
              letterSpacing: letterSpacing,
              height: height,
              overflow: TextOverflow.ellipsis),
        ),
        maxLines: maxlines,
        textAlign: textAlign);
  }
}
