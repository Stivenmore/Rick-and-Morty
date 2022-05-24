import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/data/api/api_utils.dart';
import 'package:rickandmorty/data/services/api.dart';
import 'package:rickandmorty/logic/models/episodeModels.dart';
import 'package:rickandmorty/logic/response/result.dart';

part 'episode_state.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final ApiUtils _apiUtils;
  EpisodeCubit({required ApiUtils apiUtils})
      : _apiUtils = apiUtils,
        super(EpisodeLoading());

  Future getEpisodeForCharacter({required List episodes}) async {
    emit(EpisodeLoading());
    Api api = Api(apiUtils: _apiUtils);
    final Result<dynamic, BackendError> result =
        await api.getAllEpisodeForNumber(episode: episodes);
    if (result.isSuccess) {
      List<EpisodeModels> allEpisode = (result.successRes as Iterable)
          .map((e) => EpisodeModels.fromJson(e))
          .toList();
      emit(EpisodeLoaded(episodeModelList: allEpisode));
    } else {
      emit(EpisodeError());
    }
  }
}
