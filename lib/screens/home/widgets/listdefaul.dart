import 'package:flutter/material.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';
import 'package:rickandmorty/screens/widgets/global.dart';

class ListDefaul extends StatelessWidget {
  const ListDefaul({
    Key? key,
    required this.responsive,
    required this.list,
  }) : super(key: key);

  final Responsive responsive;
  final List<CharaterModels> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate:
            SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: kColorblack.withOpacity(0.3))),
              child: Row(
                children: [
                  SizedBox(
                    height: 170,
                    width: responsive.wp(37),
                    child: FadeInImage.assetNetwork(
                      placeholder:
                          "assets/images/code_send.png",
                      image: list[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle_rounded,
                                size: 8,
                                color: manageColor(
                                    list[index].status),
                              ),
                              CustomText(
                                  colortext: kColorblack,
                                  data:
                                      " ${list[index].status} - ${list[index].species}",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  textAlign: TextAlign.left),
                            ],
                          ),
                          CustomText(
                              colortext: kColorblack,
                              data: " ${list[index].name}",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.left),
                          const SizedBox(height: 8),
                          CustomText(
                              colortext: kColorblack,
                              data: "Last know location:",
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              textAlign: TextAlign.left),
                          Expanded(
                            child: CustomText(
                              colortext: kColorblack,
                              data: list[index].location,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.left,
                              maxlines: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                              colortext: kColorblack,
                              data: "First seen in:",
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              textAlign: TextAlign.left),
                          Expanded(
                            child: CustomText(
                              colortext: kColorblack,
                              data: list[index]
                                      .firsEpisode
                                      .name
                                      .isEmpty
                                  ? "Not available"
                                  : list[index]
                                      .firsEpisode
                                      .name,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.left,
                              maxlines: 2,
                            ),
                          ),
                        ],
                      ),
                      width: responsive.wp(50),
                    ),
                  )
                ],
              ),
              height: 170,
              width: responsive.width,
            ),
          ),
        );
      }, childCount: list.length));
  }
}
