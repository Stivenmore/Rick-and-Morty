// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {Key? key,
      required this.responsive,
      required this.charaterModels,
      required this.title,
      required this.subtitle})
      : super(key: key);

  final Responsive responsive;
  final CharaterModels charaterModels;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: kDimens1, color: kColorgrayDetail)),
      height: kDimens60,
      width: responsive.wp(kDimens42),
      child: Padding(
        padding: const EdgeInsets.only(top: kDimens10, left: kDimens20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  icon1,
                  height: kDimens20,
                  width: kDimens20,
                ),
                const SizedBox(
                  width: kDimens5,
                ),
                CustomText(
                    colortext: kColorblack,
                    data: title,
                    fontSize: kDimens12,
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.center)
              ],
            ),
            CustomText(
                colortext: kColorblack,
                data: subtitle,
                fontSize: kDimens16,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left)
          ],
        ),
      ),
    );
  }
}