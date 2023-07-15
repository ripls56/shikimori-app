import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/profile/data/datasources/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/profile/data/dto/creditional_dto.dart';
import 'package:shikimoriapp/feature/profile/data/mappers/creditional_mapper.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional.dart';

///Creditional remote data source implementation
class CreditionalRemoteDataSourceImpl implements CreditionalRemoteDataSource {
  ///Need http client to work
  CreditionalRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Creditional> getCreditionals(String token) async {
    final response = await _dio.get(
      ApiEndpoints.creditional,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200) {
      return CreditionalDTO.fromJson(response.data as Map<String, dynamic>)
          .toEntity();
    } else {
      throw ServerException();
    }
  }
}
