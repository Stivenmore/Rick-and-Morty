// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final int? count;
  const ShimmerList({
    this.count,
    Key? key,
    required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kColorblack.withOpacity(0.3))),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: kColorwhite.withOpacity(0.5),
                  highlightColor: kColorgray.withOpacity(0.3),
                  child: Container(
                    width: responsive.wp(37),
                    color: kColorbluemetal,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerComponent(
                          height: 15,
                          width: 100,
                        ),
                        SizedBox(height: 2),
                        ShimmerComponent(
                          height: 15,
                          width: 100,
                        ),
                        SizedBox(height: 10),
                        ShimmerComponent(
                          height: 15,
                          width: 110,
                        ),
                        SizedBox(height: 2),
                        ShimmerComponent(
                          height: 15,
                          width: 80,
                        ),
                        SizedBox(height: 10),
                        ShimmerComponent(
                          height: 15,
                          width: 80,
                        ),
                        SizedBox(height: 2),
                        ShimmerComponent(
                          height: 15,
                          width: 140,
                        ),
                      ],
                    ),
                    width: responsive.wp(50),
                  ),
                )
              ],
            ),
            height: 155,
            width: responsive.width,
          ),
        ),
      );
    }, childCount: count?? 10));
  }
}

class ShimmerComponent extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerComponent({
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kColorwhite.withOpacity(0.5),
      highlightColor: kColorgray.withOpacity(0.3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kColorwhite,
        ),
        height: height,
        width: width,
      ),
    );
  }
}