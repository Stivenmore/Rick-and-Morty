// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/logic/cubit/cubit/business_cubit.dart';
import 'package:rickandmorty/logic/cubit/cubit/episode_cubit.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/logic/provider/globalprovider.dart';
import 'package:rickandmorty/screens/detail/detail.dart';
import 'package:rickandmorty/screens/favorite/favorite.dart';
import 'package:rickandmorty/screens/home/widgets/listdefaul.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/customStar.dart';
import 'package:rickandmorty/screens/widgets/custombuttom.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';
import 'package:rickandmorty/screens/widgets/global.dart';
import 'package:rickandmorty/screens/widgets/shimmerList.dart';

class AllHome extends StatefulWidget {
  const AllHome({Key? key}) : super(key: key);

  @override
  State<AllHome> createState() => _AllHomeState();
}

class _AllHomeState extends State<AllHome> with SingleTickerProviderStateMixin {
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDimens8),
      borderSide: BorderSide(color: kColorwhite, width: kDimens2));
  ScrollController scrollController = ScrollController();
  TextEditingController textcontroller = TextEditingController();
  bool favorite = false;

  @override
  void initState() {
    final buss = context.read<BusinessCubit>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          (scrollController.position.maxScrollExtent - 1000)) {
        BlocListener<BusinessCubit, BusinessState>(listener: ((context, state) {
          if (state.runtimeType == BusinessLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 5),
                content: CustomText(
                  data: "Cargando data...",
                  fontSize: kDimens14,
                  colortext: kColorwhite,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
                backgroundColor: kColorbluemetal,
              ),
            );
          }
        }));

        if (textcontroller.text.isNotEmpty) {
          if (buss.pages >= buss.pageSearch) {
            buss.getCharancterForName(null,
                name: textcontroller.text, cleardata: false);
          }
        } else if (buss.isFilter) {
          if (buss.pages >= buss.pageFilter) {
            buss.getCharacterForGenderAndStatus(cleardata: false);
          }
        } else {
          if (buss.pages >= buss.page) {
            buss.getAllCharacter(null);
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    final globalproviderlisten =
        Provider.of<GlobalProvider>(context, listen: true);
    Responsive responsive = Responsive(context);
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.center,
              children: [
                BackGroudPhoto(
                  height: responsive.hp(kDimens28),
                  width: responsive.width,
                  fit: BoxFit.cover,
                  opacity: 0.3,
                  image: krick,
                ),
                CustomImage(
                  image: krickandmortylogo,
                  kheight: kDimens200,
                  kwidth: kDimens250,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: kColorbluemetal,
              height: kDimens90,
              width: responsive.width,
              child: Padding(
                padding: const EdgeInsets.all(kDimens20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: responsive.wp(kDimens70),
                      child: TextFormField(
                        controller: textcontroller,
                        cursorColor: kColorwhite,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(color: kColorwhite)),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: kColorwhite,
                            ),
                            hintText: 'Buscar personaje...',
                            hintStyle: GoogleFonts.montserrat(
                                textStyle: TextStyle(color: kColorwhite)),
                            border: border,
                            focusedBorder: border,
                            enabledBorder: border),
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            Future.delayed(const Duration(milliseconds: 1500),
                                () {
                              context
                                  .read<BusinessCubit>()
                                  .getCharancterForName('1',
                                      name: v, cleardata: true);
                            });
                          } else {
                            context.read<BusinessCubit>().cleardata();
                            context.read<BusinessCubit>().getAllCharacter(null);
                          }
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (globalproviderlisten.filterVisible) {
                            globalProvider.changeFilter(false);
                          } else {
                            globalProvider.changeFilter(true);
                          }
                        },
                        icon: Icon(
                          globalproviderlisten.filterVisible
                              ? Icons.close
                              : Icons.menu,
                          color: kColorwhite,
                        ))
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
                visible: globalproviderlisten.filterVisible,
                child: Filter(
                  responsive: responsive,
                  context: context,
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kDimens30, horizontal: kDimens20),
                child: Row(
                  children: [
                    CustomText(
                        colortext: kColorblack,
                        data: "Mostrar favoritos:",
                        fontSize: kDimens18,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left),
                    const SizedBox(
                      width: kDimens8,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (globalProvider.isFavorite) {
                            globalProvider.changeFavorite = false;
                            setState(() {});
                          } else {
                            globalProvider.changeFavorite = true;
                            setState(() {});
                          }
                        },
                        child: CustomStar(
                          validate: globalProvider.isFavorite,
                        ))
                  ],
                )),
          ),
          if (globalproviderlisten.isFavorite == false)
            BlocBuilder<BusinessCubit, BusinessState>(
                builder: ((context, state) {
              switch (state.runtimeType) {
                case BusinessLoading:
                  return ShimmerList(responsive: responsive);
                case BusinessLoaded:
                  List<CharaterModels> list =
                      state.props[0] as List<CharaterModels>;
                  return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Random rng = Random();
                        List<CharaterModels> random = [];
                        random.add(list[rng.nextInt(list.length - 1)]);
                        random.add(list[rng.nextInt(list.length - 1)]);
                        List allEpisodes = allEpisode(list[index].episodios);
                        context
                            .read<EpisodeCubit>()
                            .getEpisodeForCharacter(episodes: allEpisodes);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detail(
                                    charaterModels: list[index],
                                    charaterInterest: random)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(kDimens8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kDimens10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kDimens10),
                                border: Border.all(
                                    color: kColorblack.withOpacity(0.3))),
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
                                            placeholder:
                                                "assets/images/code_send.png",
                                            image: list[index].image,
                                            fit: BoxFit.cover,
                                            imageErrorBuilder:
                                                (context, url, error) => Center(
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
                                                        .changeFavoriteDelete(
                                                            list[index]);
                                                    setState(() {});
                                                  } else {
                                                    globalProvider
                                                        .changeFavoriteAdd(
                                                            list[index]);
                                                    setState(() {});
                                                  }
                                                },
                                                child: CustomStar(
                                                    kcolor: kColorwhite,
                                                    validate:
                                                        globalproviderlisten
                                                            .keyExist(
                                                                list[index]))))
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDimens10,
                                      vertical: kDimens10),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle_rounded,
                                              size: kDimens8,
                                              color: manageColor(
                                                  list[index].status),
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
                                            data: list[index]
                                                    .firsEpisode
                                                    .name
                                                    .isEmpty
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
                case BusinessError:
                return SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      colortext: kColorgrayDetail,
                      data: "Justo ahora no podemos continuar :c ...",
                      fontSize: kDimens14,
                      fontWeight: FontWeight.w600,
                       maxlines: 2,
                    ),
                  ),
                );
                case BusinessNotConections:
                return SliverToBoxAdapter(
                  child: Center(
                    child: CustomText(
                      colortext: kColorgrayDetail,
                      data: "Error, Por favor verifica tu conexion a internet :c ...",
                      fontSize: kDimens14,
                      fontWeight: FontWeight.w600,
                      maxlines: 2,
                    ),
                  ),
                );
                
                default:
                  List<CharaterModels> list =
                      context.read<BusinessCubit>().charaterModelList;
                  return list.isNotEmpty
                      ? ListDefaul(responsive: responsive, list: list)
                      : ShimmerList(responsive: responsive);
              }
            })),
          if (globalproviderlisten.isFavorite) const FavoritosScreen()
        ],
      ),
    );
  }
}

class Filter extends StatefulWidget {
  final BuildContext context;
  final Responsive responsive;
  const Filter({Key? key, required this.responsive, required this.context})
      : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int primaryindex = 0;
  List<String> listgender = ["All", "Unknown", "Female", "Male", "Genderless"];
  int secundaryindex = 0;
  List<String> liststatus = [
    "Alive",
    "Unknown",
    "Dead",
  ];
  String gender = "All";
  String status = "Alive";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(widget.context, listen: false);
    return Container(
        decoration: BoxDecoration(
          color: kColorwhite,
          borderRadius: const BorderRadius.all(Radius.circular(kDimens10)),
        ),
        height: kDimens270,
        width: widget.responsive.width,
        child: Padding(
          padding: const EdgeInsets.all(kDimens8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CustomText(
                          colortext: kColorgreenblue,
                          data: "Elige el genero",
                          fontSize: kDimens14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center),
                      SizedBox(
                          height: kDimens140,
                          width: widget.responsive.wp(kDimens35),
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kDimens10),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: listgender.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      primaryindex = index;
                                      gender = listgender[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: kDimens5),
                                    child: CustomText(
                                        colortext: primaryindex == index
                                            ? kColorblack
                                            : kColorgreenblue,
                                        data: listgender[index],
                                        fontSize: kDimens14,
                                        fontWeight: FontWeight.w400,
                                        textAlign: TextAlign.center),
                                  ),
                                );
                              })))
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(
                          colortext: kColorgreenblue,
                          data: "Elige el status",
                          fontSize: kDimens14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center),
                      SizedBox(
                          height: kDimens140,
                          width: widget.responsive.wp(kDimens35),
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kDimens10),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: liststatus.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      secundaryindex = index;
                                      status = liststatus[index];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(kDimens8),
                                    child: CustomText(
                                        colortext: secundaryindex == index
                                            ? manageColor(liststatus[index])
                                            : kColorgreenblue,
                                        data: liststatus[index],
                                        fontSize: kDimens14,
                                        fontWeight: FontWeight.w400,
                                        textAlign: TextAlign.center),
                                  ),
                                );
                              })))
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  provider.changeFilter(false);
                  context.read<BusinessCubit>()
                    ..getCharacterForGenderAndStatus(
                      gender: gender,
                      status: status,
                      cleardata: true,
                    )
                    ..changeGenderAndStatus(gender, status)
                    ..changeIsFilter(true);
                },
                child: CustomButtom(
                  responsive: widget.responsive,
                  left: widget.responsive.wp(kDimens20),
                  right: widget.responsive.wp(kDimens20),
                  text: "Buscar",
                  widht: kDimens120,
                  height: kDimens40,
                ),
              ),
            ],
          ),
        ));
  }
}
