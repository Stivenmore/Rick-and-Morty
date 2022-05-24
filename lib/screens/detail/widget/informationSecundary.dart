// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/screens/detail/widget/customContainer.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';

class InformationSecundari extends StatelessWidget {
  const InformationSecundari({
    Key? key,
    required this.responsive,
    required this.charaterModels,
  }) : super(key: key);

  final Responsive responsive;
  final CharaterModels charaterModels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDimens185,
      width: responsive.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              colortext: kColorgrayDetail,
              data: "Información",
              fontSize: kDimens18,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center),
          const SizedBox(
            height: kDimens20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomContainer(
                  responsive: responsive,
                  charaterModels: charaterModels,
                  title: "Gender:",
                  subtitle: charaterModels.gender.toUpperCase()),
              CustomContainer(
                  responsive: responsive,
                  charaterModels: charaterModels,
                  title: "Origen:",
                  subtitle: charaterModels.origin),
            ],
          ),
          const SizedBox(
            height: kDimens20,
          ),
          CustomContainer(
              responsive: responsive,
              charaterModels: charaterModels,
              title: "Type:",
              subtitle: charaterModels.status),
        ],
      ),
    );
  }
}
