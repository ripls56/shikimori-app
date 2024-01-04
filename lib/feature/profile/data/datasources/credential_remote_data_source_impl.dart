import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/profile/data/datasources/credential_remote_data_source.dart';
import 'package:shikimoriapp/feature/profile/data/dto/credential_dto.dart';
import 'package:shikimoriapp/feature/profile/data/mappers/credential_mapper.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';

///Creditional remote data source implementation
class CreditionalRemoteDataSourceImpl implements CredentialRemoteDataSource {
  ///Need http client to work
  CreditionalRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Credential> getCredentials(String token) async {
    final response = await _dio.get(
      ApiEndpoints.credential,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200) {
      return CredentialDTO.fromJson(response.data as Map<String, dynamic>)
          .toEntity();
    } else {
      throw ServerException();
    }
  }
}
