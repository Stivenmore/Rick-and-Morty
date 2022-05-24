
import 'package:rickandmorty/screens/utils/colors.dart';

  manageColor(String color) {
    switch (color) {
      case "Alive":
        return kColorgreen;
      case "Dead":
        return kColorblack;
      case "unknown":
        return kColorOrange;
      default:
        return kColorOrange;
    }
  }

  allEpisode(List episode) {
  List allEpisode = [];
  for (var i = 0; i < episode.length; i++) {
    String mock = episode[i].toString().split("episode/")[1];
    allEpisode.add(mock);
  }
  return allEpisode;
}