// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class EpisodeModels extends Equatable {
  final int id;
  final String name;
  final String episode;
  final String url;
  final String date;

  const EpisodeModels({
    required this.id,
    required this.episode,
    required this.name,
    required this.url,
    required this.date,
  });

  factory EpisodeModels.fromJson(Map<dynamic, dynamic> json) {
    return EpisodeModels(
      id: json["id"],
      episode: json["episode"],
      name: json["name"],
      url: json["url"],
      date: json["air_date"],
    );
  }

  @override
  List<Object?> get props => [id, name, url, episode, date];
}
