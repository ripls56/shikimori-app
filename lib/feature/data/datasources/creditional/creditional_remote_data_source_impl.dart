import 'package:dio/dio.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/creditional/creditional_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';
import 'package:shikimoriapp/feature/domain/entities/user_auth/user_auth.dart';
import 'package:shikimoriapp/injection.container.dart' as di;

class CreditionalRemoteDataSourceImpl implements CreditionalRemoteDataSource {
  final Dio dio;
  CreditionalRemoteDataSourceImpl(this.dio);

  @override
  Future<Creditional> getCreditionals(String token) async {
    var response = await dio.get(
      '$HOST/users/whoami',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${di.sl<UserAuth>().accessToken}',
        },
      ),
    );
    if (response.statusCode == 200) {
      return CreditionalModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
