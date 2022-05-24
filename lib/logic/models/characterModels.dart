// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:rickandmorty/logic/models/episodeModels.dart';

class CharaterModels extends Equatable {
  final int id;
  final List episodios;
  final String created;
  final String gender;
  final String image;
  final String name;
  final String species;
  final String status;
  final String type;
  final String url;
  final String origin;
  final String location;
  final EpisodeModels firsEpisode;

  const CharaterModels({
    required this.id,
    required this.episodios,
    required this.created,
    required this.firsEpisode,
    required this.gender,
    required this.image,
    required this.name,
    required this.species,
    required this.status,
    required this.type,
    required this.url,
    required this.origin,
    required this.location,
  });

  factory CharaterModels.fromJson(Map<dynamic, dynamic> json) {
    return CharaterModels(
        id: json["id"] ?? 0,
        created: json["created"] ?? '',
        episodios: json["episode"] == []? []: (json["episode"] as List<dynamic>).toList(),
        gender: json["gender"] ?? "Unknown",
        image: json["image"] ?? "http://via.placeholder.com/640x360",
        name: json["name"] ?? "",
        species: json["species"] ?? "",
        status: json["status"] ?? "",
        type: json["type"] ?? "",
        url: json["url"] ?? "",
        origin: json["origin"]["name"] ?? "",
        location: json["location"]["name"] ?? "",
        firsEpisode: const EpisodeModels(
            episode: "", name: "", id: 0, url: "", date: ""));
  }

  CharaterModels copyWith({required CharaterModels copywith}) {
    return CharaterModels(
        id: copywith.id,
        episodios: copywith.episodios,
        created: copywith.created,
        gender: copywith.gender,
        image: copywith.image,
        name: copywith.name,
        species: copywith.species,
        status: copywith.status,
        type: copywith.type,
        url: copywith.url,
        origin: copywith.origin,
        location: copywith.location,
        firsEpisode: copywith.firsEpisode);
  }

  @override
  List<Object?> get props => [
        firsEpisode,
        episodios,
        id,
        name,
        status,
        type,
        gender,
        image,
        species,
        url,
        created,
        location
      ];
}
