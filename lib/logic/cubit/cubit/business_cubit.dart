import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/data/abstractions/abstra_api.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/logic/models/episodeModels.dart';
import 'package:rickandmorty/logic/response/result.dart';

part 'business_state.dart';

class BusinessCubit extends Cubit<BusinessState> {
  final ContractClassApi _api;
  BusinessCubit({required ContractClassApi api})
      :  _api = api,
        super(BusinessLoading());

  int page = 0;
  int pageSearch = 2;
  int pageFilter = 1;
  late int pages;
  late int count;
  String kgender = "All";
  String kstatus = "Alive";
  bool isFilter = false;
  List<CharaterModels> charaterModelList = [];
  EpisodeModels episodeMock =
      const EpisodeModels(id: 0, episode: "", name: "", url: "", date: "");

  int get countingPages => pages;

  Future getAllCharacter(int? paginate) async {
    try {
      if (charaterModelList.isEmpty) {
        page = 0;
        emit(BusinessLoading());
      }
      Result<dynamic, BackendError> result =
          await _api.getAllCharacter(page: paginate?? page + 1);
      if (result.isSuccess) {
        pages = result.successRes["info"]["pages"];
        count = result.successRes["info"]["count"];
        List<CharaterModels> internalList =
            (result.successRes["results"] as Iterable)
                .map((e) => CharaterModels.fromJson(e))
                .toList();
        if (internalList.isNotEmpty) {
          for (var i = 0; i < internalList.length; i++) {
            final Result<dynamic, BackendError> singleEpisode =
                await _api.getEpisodeForNumber(
                    episode: result.successRes["results"][i]["episode"][0]
                        .toString()
                        .split('episode')[1]);
            if (singleEpisode.isSuccess) {
              EpisodeModels episodeModels =
                  EpisodeModels.fromJson(singleEpisode.successRes);
              CharaterModels copyWith = CharaterModels(
                  id: internalList[i].id,
                  episodios: internalList[i].episodios,
                  created: internalList[i].created,
                  gender: internalList[i].gender,
                  image: internalList[i].image,
                  name: internalList[i].name,
                  species: internalList[i].species,
                  status: internalList[i].status,
                  type: internalList[i].type,
                  url: internalList[i].url,
                  origin: internalList[i].origin,
                  location: internalList[i].location,
                  firsEpisode: episodeModels);
              internalList[i] = copyWith;
            }
          }
          charaterModelList = [
            ...charaterModelList,
            ...internalList,
          ];
          page++;
          emit(BusinessLoaded(charatermodelslist: charaterModelList));
        } else {
          emit(BusinessLoaded(charatermodelslist: charaterModelList));
        }
      } else {
        if (result.failRes!.err == "connectTimeout" ||
            result.failRes!.err == "sendTimeout" ||
            result.failRes!.err == "receiveTimeout") {
          emit(BusinessNotConections());
        } else {
          emit(BusinessError());
        }
      }
    } catch (e) {
      emit(BusinessError());
    }
  }

  Future getCharancterForName(String? pageSearc,
      {required String name, required bool cleardata}) async {
    try {
      if (name.isNotEmpty) {
        if (cleardata) {
          emit(BusinessLoading());
          charaterModelList = [];
        }
        Result<dynamic, BackendError> result = await _api.getCharacterForName(
            pageSearc ?? pageSearch.toString(),
            name: name);
        if (result.isSuccess) {
          pages = result.successRes["info"]["pages"];
          count = result.successRes["info"]["count"];
          List<CharaterModels> internalList =
              (result.successRes["results"] as Iterable)
                  .map((e) => CharaterModels.fromJson(e))
                  .toList();
          for (var i = 0; i < internalList.length; i++) {
            final Result<dynamic, BackendError> singleEpisode =
                await _api.getEpisodeForNumber(
                    episode: result.successRes["results"][i]["episode"][0]
                        .toString()
                        .split('episode')[1]);
            if (singleEpisode.isSuccess) {
              EpisodeModels episodeModels =
                  EpisodeModels.fromJson(singleEpisode.successRes);
              CharaterModels copyWith = CharaterModels(
                  id: internalList[i].id,
                  episodios: internalList[i].episodios,
                  created: internalList[i].created,
                  gender: internalList[i].gender,
                  image: internalList[i].image,
                  name: internalList[i].name,
                  species: internalList[i].species,
                  status: internalList[i].status,
                  type: internalList[i].type,
                  url: internalList[i].url,
                  origin: internalList[i].origin,
                  location: internalList[i].location,
                  firsEpisode: episodeModels);
              internalList[i] = copyWith;
            }
          }
          charaterModelList = [
            ...charaterModelList,
            ...internalList,
          ];
          emit(BusinessLoaded(charatermodelslist: charaterModelList));
          nextPageSearch();
        } else {
          if (result.failRes!.err == "connectTimeout" ||
              result.failRes!.err == "sendTimeout" ||
              result.failRes!.err == "receiveTimeout") {
            emit(BusinessNotConections());
          } else {
            emit(BusinessError());
          }
        }
      } else {
        emit(BusinessError());
      }
    } catch (e) {
      emit(BusinessError());
    }
  }

  Future getCharacterForGenderAndStatus(
      {String? gender, String? status, required bool cleardata, int? paginate}) async {
    try {
      if (cleardata) {
        pageFilter = 1;
        emit(BusinessLoading());
        charaterModelList = [];
      }
      Result<dynamic, BackendError> result =
          await _api.getCharacterForGenderAndStatus(
              gender: gender ?? kgender,
              status: status ?? kstatus,
              page: pageFilter++);
      if (result.isSuccess) {
        pages = result.successRes["info"]["pages"];
        count = result.successRes["info"]["count"];
        List<CharaterModels> internalList =
            (result.successRes["results"] as Iterable)
                .map((e) => CharaterModels.fromJson(e))
                .toList();
        for (var i = 0; i < internalList.length; i++) {
          final Result<dynamic, BackendError> singleEpisode =
              await _api.getEpisodeForNumber(
                  episode: result.successRes["results"][i]["episode"][0]
                      .toString()
                      .split('episode')[1]);
          if (singleEpisode.isSuccess) {
            EpisodeModels episodeModels =
                EpisodeModels.fromJson(singleEpisode.successRes);
            CharaterModels copyWith = CharaterModels(
                id: internalList[i].id,
                episodios: internalList[i].episodios,
                created: internalList[i].created,
                gender: internalList[i].gender,
                image: internalList[i].image,
                name: internalList[i].name,
                species: internalList[i].species,
                status: internalList[i].status,
                type: internalList[i].type,
                url: internalList[i].url,
                origin: internalList[i].origin,
                location: internalList[i].location,
                firsEpisode: episodeModels);
            internalList[i] = copyWith;
          }
        }
        charaterModelList = [
          ...charaterModelList,
          ...internalList,
        ];
        emit(BusinessLoaded(charatermodelslist: charaterModelList));
      } else {
        if (result.failRes!.err == "connectTimeout" ||
            result.failRes!.err == "sendTimeout" ||
            result.failRes!.err == "receiveTimeout") {
          emit(BusinessNotConections());
        } else {
          emit(BusinessError());
        }
      }

      emit(BusinessError());
    } catch (e) {
      emit(BusinessError());
    }
  }

  void nextPageSearch() {
    if (pages > pageSearch) {
      pageSearch = pageSearch + 1;
    }
  }

  void cleardata() {
    pageSearch = 0;
    charaterModelList = [];
  }

  void changeGenderAndStatus(String g, String s) {
    kgender = g;
    kstatus = s;
  }

  void changeIsFilter(bool v) {
    isFilter = v;
  }
}
