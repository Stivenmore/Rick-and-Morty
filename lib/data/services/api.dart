import 'package:rickandmorty/data/abstractions/abstra_api.dart';
import 'package:rickandmorty/data/api/api_utils.dart';
import 'package:rickandmorty/logic/response/result.dart';

class Api extends ContractClassApi {
  final ApiUtils _apiUtils;

  Api({required ApiUtils apiUtils}) : _apiUtils = apiUtils;

  @override
  Future<Result<dynamic, BackendError>> getAllCharacter(
      {required int page}) async {
    final result = await _apiUtils.makeRequest(
        method: Method.get,
        path: "/api/character/",
        queryParameters: {"page": page.toString()});
    return result.when(
        fail: (fail) => Fail(fail), success: (success) => Success(success));
  }

  @override
  Future<Result<dynamic, BackendError>> getCharacterForGenderAndStatus(
      {required String? gender,
      required String? status,
      required int page}) async {
    final result = await _apiUtils.makeRequest(
        method: Method.get,
        path: "/api/character/",
        queryParameters: {
          "page": page.toString(),
          "gender": gender,
          "status": status
        });
    return result.when(
        fail: (fail) => Fail(fail), success: (success) => Success(success));
  }

  @override
  Future<Result<dynamic, BackendError>> getCharacterForName(String? page,
      {required String name}) async {
    final result = await _apiUtils.makeRequest(
        method: Method.get,
        path: "/api/character/",
        queryParameters: {
          "page": page ?? '1',
          "name": name,
        });
    return result.when(
        fail: (fail) => Fail(fail), success: (success) => Success(success));
  }

  @override
  Future<Result<dynamic, BackendError>> getEpisodeForNumber(
      {required String episode}) async {
    final result = await _apiUtils.makeRequest(
      method: Method.get,
      path: "/api/episode$episode",
    );
    return result.when(
        fail: (fail) => Fail(fail), success: (success) => Success(success));
  }

  @override
  Future<Result<dynamic, BackendError>> getAllEpisodeForNumber(
      {required List episode}) async {
    final result = await _apiUtils.makeRequest(
      method: Method.get,
      path: "/api/episode/$episode",
    );
    return result.when(
        fail: (fail) => Fail(fail), success: (success) => Success(success));
  }
}
