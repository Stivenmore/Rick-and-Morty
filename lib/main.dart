// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/data/env/env.dart';
import 'package:rickandmorty/data/services/api.dart';
import 'package:rickandmorty/logic/cubit/cubit/business_cubit.dart';
import 'package:rickandmorty/logic/cubit/cubit/episode_cubit.dart';
import 'package:rickandmorty/logic/provider/globalprovider.dart';
import 'package:rickandmorty/screens/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalProvider())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => BusinessCubit(api: Api(apiUtils: apiUtils))),
          BlocProvider(create: (context) => EpisodeCubit(apiUtils: apiUtils)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rick And Morty',
          routes: routes,
          initialRoute: '/',
        ),
      ),
    );
  }
}
