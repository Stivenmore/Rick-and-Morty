// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickandmorty/data/api/api_utils.dart';
import 'package:rickandmorty/data/env/env.dart';
import 'package:rickandmorty/data/services/mock.dart';
import 'package:rickandmorty/logic/cubit/cubit/business_cubit.dart';
import 'package:rickandmorty/logic/models/characterModels.dart';
import 'package:rickandmorty/logic/models/episodeModels.dart';
import 'package:rickandmorty/logic/response/result.dart';

void main() {
  ApiUtils apiUtils = ApiUtils(
      client: Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      )),
      host: baseUrl,
      mockfile: "chartersucces.json");
  Mock mock = Mock(apiUtils: apiUtils);
  String name = "Gadeon";

  CharaterModels chart = const CharaterModels(
      id: 15,
      episodios: [
        "https://rickandmortyapi.com/api/episode/15",
        "https://rickandmortyapi.com/api/episode/25"
      ],
      created: "2017-15-04T18:48:46.250Z",
      firsEpisode:
          EpisodeModels(id: 0, episode: '', name: "", url: "", date: ""),
      gender: "Male",
      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      name: "Rick Sanchez",
      species: "Human",
      status: "Alive",
      type: "Nose",
      url: "https://rickandmortyapi.com/api/character/1",
      origin: "Earth",
      location: "Earth");

  group("Testing Group Integrations Testing From Layer Logic/Bussines To Data",
      () {
    TestWidgetsFlutterBinding.ensureInitialized();
    blocTest("Testing Get All Character Sucess",
        build: () => BusinessCubit(api: mock),
        act: (BusinessCubit cubit) => cubit.getAllCharacter(null),
        expect: () => <BusinessState>[
              BusinessLoading(),
              BusinessLoaded(charatermodelslist: [chart])
            ]);

    blocTest("Testing Get All Character Error",
        build: () => BusinessCubit(api: Mock(apiUtils: apiUtils)),
        act: (BusinessCubit cubit) => cubit.getCharancterForName(
              '1',
              name: '',
              cleardata: true,
            ),
        expect: () => <BusinessState>[BusinessError()]);

    blocTest("Testing Ge Character For Name Success",
        build: () => BusinessCubit(api: Mock(apiUtils: apiUtils)),
        act: (BusinessCubit cubit) => cubit.getCharancterForName(
              '1',
              name: name,
              cleardata: false,
            ),
        expect: () => <BusinessState>[
              BusinessLoaded(charatermodelslist: [chart])
            ]);

    blocTest("Testing Get Character For Name Error",
        build: () => BusinessCubit(api: mock),
        act: (BusinessCubit cubit) =>
            cubit.getCharancterForName("2", name: '', cleardata: true),
        expect: () => <BusinessState>[BusinessError()]);
  });

  group("Testing Group United Testing To Data", () {
    TestWidgetsFlutterBinding.ensureInitialized();

    test("Success response all character", () async {
      final Result<dynamic, BackendError> result =
          await mock.getAllCharacter(page: 1);
      expect(result.isSuccess, isTrue);
    });

    test("Failure response all character", () async {
      final Result<dynamic, BackendError> result =
          await mock.getAllCharacter(page: -1);
      expect(result.isFail, isTrue);
    });

    test("Success response Name character", () async {
      final Result<dynamic, BackendError> result =
          await mock.getCharacterForName('1', name: '');
      expect(result.isSuccess, isTrue);
    });

    test("Failure response Name character", () async {
      final Result<dynamic, BackendError> result =
          await mock.getCharacterForName('0', name: name);
      expect(result.isFail, isTrue);
    });

    test("Success response gender and status character", () async {
      final Result<dynamic, BackendError> result =
          await mock.getCharacterForGenderAndStatus(
              page: 1, gender: "Human", status: "Alive");
      expect(result.isSuccess, isTrue);
    });

    test("Failure response gender and status character", () async {
      final Result<dynamic, BackendError> result = await mock
          .getCharacterForGenderAndStatus(page: -1, gender: "", status: "");
      expect(result.isFail, isTrue);
    });
  });
}


// Tambien realizo normalmente WidgetTesting pero en esta caso no lo hare por temas de tiempos.
// Saludos revisor, espero tenga un buen dia ;p