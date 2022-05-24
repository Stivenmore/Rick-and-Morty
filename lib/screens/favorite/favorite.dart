// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/logic/cubit/cubit/episode_cubit.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/logic/provider/globalprovider.dart';
import 'package:rickandmorty/screens/detail/detail.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/customStar.dart';
import 'package:rickandmorty/screens/widgets/custombuttom.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';
import 'package:rickandmorty/screens/widgets/global.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    final globalproviderlisten =
        Provider.of<GlobalProvider>(context, listen: true);
    Responsive responsive = Responsive(context);
    if (globalproviderlisten.favorite.isNotEmpty) {
      List<CharaterModels> list = globalproviderlisten.favorite;
      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return GestureDetector(
          onTap: () {
            List allEpisodes = allEpisode(list[index].episodios);
            context
                .read<EpisodeCubit>()
                .getEpisodeForCharacter(episodes: allEpisodes);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detail(
                          charaterModels: list[index],
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(kDimens8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kDimens10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDimens10),
                    border: Border.all(color: kColorblack.withOpacity(0.3))),
                child: Row(
                  children: [
                    SizedBox(
                        height: kDimens170,
                        width: responsive.wp(kDimens37),
                        child: Stack(
                          children: [
                            Positioned(
                              top: kDimens0,
                              bottom: kDimens0,
                              left: kDimens0,
                              right: kDimens0,
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/code_send.png",
                                image: list[index].image,
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
                            Positioned(
                                bottom: kDimens10,
                                right: kDimens10,
                                child: GestureDetector(
                                    onTap: () async {
                                      if (globalProvider
                                          .keyExist(list[index])) {
                                        globalProvider
                                            .changeFavoriteDelete(list[index]);
                                        setState(() {});
                                      } else {
                                        globalProvider
                                            .changeFavoriteAdd(list[index]);
                                        setState(() {});
                                      }
                                    },
                                    child: CustomStar(
                                        kcolor: kColorwhite,
                                        validate: globalproviderlisten
                                            .keyExist(list[index]))))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDimens10, vertical: kDimens10),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  size: kDimens8,
                                  color: manageColor(list[index].status),
                                ),
                                CustomText(
                                    colortext: kColorblack,
                                    data:
                                        " ${list[index].status} - ${list[index].species}",
                                    fontSize: kDimens12,
                                    fontWeight: FontWeight.w300,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            CustomText(
                                colortext: kColorblack,
                                data: " ${list[index].name}",
                                fontSize: kDimens16,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.left),
                            const SizedBox(height: kDimens8),
                            CustomText(
                                colortext: kColorblack,
                                data: "Last know location:",
                                fontSize: kDimens12,
                                fontWeight: FontWeight.w300,
                                textAlign: TextAlign.left),
                            Expanded(
                              child: CustomText(
                                colortext: kColorblack,
                                data: list[index].location,
                                fontSize: kDimens14,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.left,
                                maxlines: 2,
                              ),
                            ),
                            const SizedBox(height: kDimens10),
                            CustomText(
                                colortext: kColorblack,
                                data: "First seen in:",
                                fontSize: kDimens12,
                                fontWeight: FontWeight.w300,
                                textAlign: TextAlign.left),
                            Expanded(
                              child: CustomText(
                                colortext: kColorblack,
                                data: list[index].firsEpisode.name.isEmpty
                                    ? "Not available"
                                    : list[index].firsEpisode.name,
                                fontSize: kDimens14,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.left,
                                maxlines: 2,
                              ),
                            ),
                          ],
                        ),
                        width: responsive.wp(kDimens50),
                      ),
                    )
                  ],
                ),
                height: kDimens170,
                width: responsive.width,
              ),
            ),
          ),
        );
      }, childCount: list.length));
    } else {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            CustomText(
                colortext: kColorblack,
                data: "Uh-oh!",
                fontSize: 30,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center),
            const SizedBox(
              height: kDimens10,
            ),
            CustomText(
                colortext: kColorblack.withOpacity(0.7),
                data: "Pareces perdido en tu viaje",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center),
            GestureDetector(
              onTap: () {
                globalProvider.changeFavorite = false;
                globalProvider.isFavorite;
              },
              child: CustomButtom(
                responsive: responsive,
                left: responsive.wp(20),
                right: responsive.wp(20),
                text: "Eliminar filtros",
              ),
            )
          ],
        ),
      );
    }
  }
}
