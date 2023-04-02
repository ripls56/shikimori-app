import 'package:dio/dio.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/related/related_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/related/related.dart';
import 'package:shikimoriapp/feature/domain/entities/related/related.dart';

class RelatedRemoteDataSourceImpl implements RelatedRemoteDataSource {
  final Dio dio;
  RelatedRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Related>> getRelated(int id) async {
    var response = await dio.get('$HOST/animes/$id/related');
    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((e) => RelatedModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
