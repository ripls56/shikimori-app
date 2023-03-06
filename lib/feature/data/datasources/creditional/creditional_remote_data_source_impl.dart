// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';

class CreditionalRemoteDataSourceImpl implements CreditionalRemoteDataSource {
  final _dio = Dio();
  CreditionalRemoteDataSourceImpl() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    _dio.options.headers = {
      'User-Agent': 'mpt coursework',
      'Authorization': 'Bearer $TOKEN'
    };
  }

  @override
  Future<Creditional> getCreditionals(String token) async {
    var response = await _dio.get(
      '$HOST/users/whoami',
    );
    _dio.options.headers = {
      'User-Agent': 'mpt coursework',
      'Authorization': 'Bearer $token'
    };
    TOKEN = token;
    if (response.statusCode == 200) {
      return CreditionalModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
