import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/logic/cubit/cubit/business_cubit.dart';
import 'package:rickandmorty/screens/utils/colors.dart';
import 'package:rickandmorty/screens/utils/constants.dart';
import 'package:rickandmorty/screens/utils/navigations.dart';
import 'package:rickandmorty/screens/utils/responsive.dart';
import 'package:rickandmorty/screens/widgets/exportWidgets.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            BackGroudPhoto(
              height: responsive.height,
              width: responsive.width,
              opacity: kDimens015,
            ),
            Positioned(
                left: kDimens0,
                right: kDimens0,
                top: responsive.hp(kDimens12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImage(
                      image: knamelogo,
                      kheight: kDimens50,
                      kwidth: kDimens200,
                    ),
                    CustomImage(
                      image: krickandmortylogo,
                      kheight: kDimens200,
                      kwidth: kDimens250,
                    ),
                    const SizedBox(
                      height: kDimens8,
                    ),
                    CustomText(
                      data: kwelcomeTitle,
                      colortext: kColorwhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      textAlign: TextAlign.center,
                    ),
                   const SizedBox(
                      height: kDimens12,
                    ),
                    CustomText(
                      data: kwelcomeDescription,
                      colortext: kColorwhite,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      letterSpacing: 1,
                      height: 1.3,
                      maxlines: 5,
                    ),
                   const SizedBox(
                      height: kDimens100,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.read<BusinessCubit>().getAllCharacter(null);
                          navigationsNameRemove(context, "/allhome");
                        },
                        child: Container(
                          child: Center(
                            child: CustomText(
                              data: "Continuar",
                              fontSize: 18,
                              colortext: kColorwhite,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: kColorgreenblue,
                              borderRadius: BorderRadius.circular(kDimens50)),
                          height: kDimens50,
                          width: kDimens130,
                        ))
                  ],
                ))
          ],
        ),
        height: responsive.height,
        width: responsive.width,
      ),
    );
  }
}
