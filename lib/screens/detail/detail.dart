import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/logic/cubit/cubit/episode_cubit.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/logic/models/episodeModels.dart';
import 'package:rickandmorty/screens/detail/widget/informationPrincipal.dart';
import 'package:rickandmorty/screens/detail/widget/informationSecundary.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/custombuttom.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';
import 'package:rickandmorty/screens/widgets/global.dart';
import 'package:rickandmorty/screens/widgets/shimmerList.dart';

class Detail extends StatefulWidget {
  final List<CharaterModels>? charaterInterest;
  final CharaterModels charaterModels;
  const Detail({required this.charaterModels, this.charaterInterest, Key? key})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool more = false;

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      body: SizedBox(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: kDimens400,
                width: responsive.width,
                child: InformationPrincipal(
                    responsive: responsive,
                    charaterModels: widget.charaterModels),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDimens20, vertical: kDimens50),
                child: InformationSecundari(
                    responsive: responsive,
                    charaterModels: widget.charaterModels),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: kDimens20, bottom: kDimens20),
                child: CustomText(
                    colortext: kColorgrayDetail,
                    data: "Episodios",
                    fontSize: kDimens18,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left),
              ),
            ),
            BlocBuilder<EpisodeCubit, EpisodeState>(
                builder: ((context, state) {
              switch (state.runtimeType) {
                case EpisodeLoaded:
                  List<EpisodeModels> list =
                      state.props[0] as List<EpisodeModels>;
                  return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: index % 2 == 0 ? 15 : 10,
                                right: index % 2 == 0 ? 10 : 15),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: kColorwhite,
                                    border: Border.all(
                                        width: 1, color: kColorgray),
                                    borderRadius:
                                        BorderRadius.circular(kDimens10)),
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          colortext: kColorblack,
                                          data: list[index].name,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          textAlign: TextAlign.left),
                                      CustomText(
                                          colortext: kColorblack,
                                          data: list[index].episode,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textAlign: TextAlign.left),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                          colortext: kColorblack,
                                          data: list[index].date,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          textAlign: TextAlign.left)
                                    ],
                                  ),
                                )),
                          );
                        },
                        childCount: more == false
                            ? (list.length > 4 ? 4 : list.length)
                            : list.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 0,
                        childAspectRatio: 2.2,
                      ));
                case EpisodeLoading:
                  return ShimmerList(
                    responsive: responsive,
                    count: 4,
                  );
                case EpisodeError:
                  return SliverToBoxAdapter(
                    child: CustomText(
                      colortext: kColorgreenblue,
                      data: "No disponibles",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  );
                default:
                  return SliverToBoxAdapter(
                    child: Container(),
                  );
              }
            })),
            BlocBuilder<EpisodeCubit, EpisodeState>(
                builder: ((context, state) {
              switch (state.runtimeType) {
                case EpisodeLoaded:
                  return SliverToBoxAdapter(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            more = !more;
                          });
                        },
                        child: CustomText(
                            colortext: kColorgreenblue,
                            data: more == false ? 'Ver más' : "Ver menos",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center)),
                  );
                default:
                  return const SliverToBoxAdapter();
              }
            })),
            if (widget.charaterInterest != null &&
                widget.charaterInterest!.isNotEmpty)
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return GestureDetector(
                  onTap: () {
                    List allEpisodes =
                        allEpisode(widget.charaterInterest![index].episodios);
                    context
                        .read<EpisodeCubit>()
                        .getEpisodeForCharacter(episodes: allEpisodes);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  charaterModels:
                                      widget.charaterInterest![index],
                                )));
                  },
                  child: Padding(
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
                                placeholder: "assets/images/code_send.png",
                                image: widget.charaterInterest![index].image,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, url, error) =>
                                    Center(
                                  child: CircularProgressIndicator(
                                    color: kColorbluemetal,
                                    backgroundColor: kColorwhite,
                                  ),
                                ),
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
                                          color: manageColor(widget
                                              .charaterInterest![index]
                                              .status),
                                        ),
                                        CustomText(
                                            colortext: kColorblack,
                                            data:
                                                "${widget.charaterInterest![index].status} - ${widget.charaterInterest![index].species}",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            textAlign: TextAlign.left),
                                      ],
                                    ),
                                    CustomText(
                                        colortext: kColorblack,
                                        data:
                                            " ${widget.charaterInterest![index].name}",
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
                                        data: widget.charaterInterest![index]
                                            .location,
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
                                        data: widget.charaterInterest![index]
                                                .firsEpisode.name.isEmpty
                                            ? "Not available"
                                            : widget.charaterInterest![index]
                                                .firsEpisode.name,
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
                  ),
                );
              }, childCount: widget.charaterInterest!.length)),
            SliverToBoxAdapter(
              child: CustomButtom(
                  responsive: responsive,
                  left: responsive.wp(15),
                  right: responsive.wp(15),
                  text: "Compartir personaje",),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    top: kDimens50,
                    left: responsive.wp(15),
                    right: responsive.wp(15)),
                child: SizedBox(
                  height: kDimens50,
                  width: responsive.wp(80),
                ),
              ),
            )
          ],
        ),
        height: responsive.height,
        width: responsive.width,
      ),
    );
  }
}

