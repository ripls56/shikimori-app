import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/related/data/datasources/related_remote_data_source.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';

///Anime related remote data source implementation
class RelatedRemoteDataSourceImpl implements RelatedRemoteDataSource {
  ///Need http client to work
  RelatedRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Related>> getRelated(int id) async {
    final response = await _dio.get(ApiEndpoints.animeRelateds(id));
    if (response.statusCode == 200) {
      // TODO(ripls56): implement
      throw UnimplementedError();
      // return (response.data as List<dynamic>)
      //     .map((e) => RelatedModel.fromJson(e as Map<String, dynamic>))
      //     .toList();
    } else {
      throw ServerException();
    }
  }
}
