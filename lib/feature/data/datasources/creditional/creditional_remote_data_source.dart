import 'package:shikimori_app/feature/domain/entities/creditional/creditional.dart';

abstract class CreditionalRemoteDataSource {
  ///Get anime list with page
  ///
  ///Throws [ServerException] for all code errors
  Future<Creditional> getCreditionals(String token);
}
