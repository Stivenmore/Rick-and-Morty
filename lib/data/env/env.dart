import 'package:dio/dio.dart';
import 'package:rickandmorty/data/api/api_utils.dart';

const baseUrl = "rickandmortyapi.com";

  ApiUtils apiUtils = ApiUtils(
      client: Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 5000,
      )),
      host: baseUrl);