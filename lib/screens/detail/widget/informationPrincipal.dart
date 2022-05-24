// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/logic/provider/globalprovider.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/customStar.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';
import 'package:rickandmorty/screens/widgets/global.dart';

class InformationPrincipal extends StatelessWidget {
  const InformationPrincipal({
    Key? key,
    required this.responsive,
    required this.charaterModels,
  }) : super(key: key);

  final Responsive responsive;
  final CharaterModels charaterModels;

  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    final globalproviderlisten =
        Provider.of<GlobalProvider>(context, listen: true);
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            BackGroudPhoto(
              height: kDimens200,
              width: responsive.width,
              fit: BoxFit.cover,
              opacity: 0.8,
              image: detailphotobackgroun,
            ),
            Container(
              decoration: BoxDecoration(color: kColorbluemetal),
              height: kDimens200,
            )
          ],
        ),
        Positioned(
            left: 20,
            top: 30,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                size: 40,
                color: kColorwhite,
              ),
            )),
        Positioned(
            top: 125,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kDimens70),
                      border: Border.all(width: 4, color: kColorwhite)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kDimens70),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/code_send.png",
                      image: charaterModels.image,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, url, error) => Center(
                        child: CircularProgressIndicator(
                          color: kColorbluemetal,
                          backgroundColor: kColorwhite,
                        ),
                      ),
                    ),
                  ),
                  height: kDimens140,
                  width: kDimens140,
                ),
                const SizedBox(
                  height: kDimens15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle_rounded,
                      size: 8,
                      color: manageColor(charaterModels.status),
                    ),
                    CustomText(
                        colortext: kColorwhite,
                        data: " ${charaterModels.status.toUpperCase()}",
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        textAlign: TextAlign.left),
                  ],
                ),
                const SizedBox(
                  height: kDimens15,
                ),
                CustomText(
                    colortext: kColorwhite,
                    data: " ${charaterModels.name}",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left),
                const SizedBox(
                  height: kDimens15,
                ),
                CustomText(
                    colortext: kColorwhite,
                    data: " ${charaterModels.species.toUpperCase()}",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.left),
              ],
            )),
        Positioned(
            top: 245,
            child: GestureDetector(
                onTap: () async {
                  if (globalProvider.keyExist(charaterModels)) {
                    globalProvider.changeFavoriteDelete(charaterModels);
                  } else {
                    globalProvider.changeFavoriteAdd(charaterModels);
                  }
                },
                child: CustomStar(
                    kcolor: kColorwhite,
                    validate: globalproviderlisten.keyExist(charaterModels))))
      ],
    );
  }
}
