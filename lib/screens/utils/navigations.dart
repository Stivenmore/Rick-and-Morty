import 'package:flutter/material.dart';

void navigationsNameRemove(BuildContext context, String name) {
  Navigator.pushNamedAndRemoveUntil(context, name, (route) => false);
}

void navigationsName(BuildContext context, String name) {
  Navigator.pushNamed(context, name);
}

void navigationsPop(BuildContext context,) {
  Navigator.of(context).pop();
}
