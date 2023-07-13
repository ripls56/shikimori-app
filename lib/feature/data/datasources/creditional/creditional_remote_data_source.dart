import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/domain/entities/creditional/creditional.dart';

///User creditional remote data source
abstract interface class CreditionalRemoteDataSource {
  ///Get anime list with page
  ///
  ///Throws [ServerException] for all code errors
  Future<Creditional> getCreditionals(String token);
}
