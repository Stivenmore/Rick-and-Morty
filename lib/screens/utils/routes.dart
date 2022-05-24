

import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/home/allHome.dart';
import 'package:rickandmorty/screens/welcome/welcome.dart';

final Map <String, WidgetBuilder> routes = {
  '/'          : (BuildContext context) => const Welcome(),
  '/allhome'   : (BuildContext context) => const AllHome(),
};