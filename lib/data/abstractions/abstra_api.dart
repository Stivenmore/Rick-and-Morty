import 'package:rickandmorty/logic/response/result.dart';

abstract class ContractClassApi {
  Future<Result<dynamic, BackendError>> getAllCharacter({required int page});

  Future<Result<dynamic, BackendError>> getEpisodeForNumber(
      {required String episode});

  Future<Result<dynamic, BackendError>> getCharacterForGenderAndStatus(
      {required String? gender, required String? status, required int page});

  Future<Result<dynamic, BackendError>> getCharacterForName(String? page,
      {required String name});

  Future<Result<dynamic, BackendError>> getAllEpisodeForNumber(
      {required List episode});
}
