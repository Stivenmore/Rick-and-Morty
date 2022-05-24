part of 'episode_cubit.dart';

abstract class EpisodeState extends Equatable {
  const EpisodeState();

  @override
  List<Object> get props => [];
}

class EpisodeLoading extends EpisodeState {}

class EpisodeLoaded extends EpisodeState {
    const EpisodeLoaded({required this.episodeModelList});
  final List<EpisodeModels> episodeModelList;

  @override
  List<Object> get props => [episodeModelList];
}

class EpisodeError extends EpisodeState {}
