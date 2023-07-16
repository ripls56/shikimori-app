import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/profile/domain/models/user_rate.dart';

///User rates remote data source
abstract class UserRateRemoteDataSource {
  ///Get user rate by id
  ///
  ///Throws [ServerException] for all code errors
  Future<UserRate> getUserRateById(int userId, int animeId);

  ///Add user rate, and return updated rate list
  ///
  ///Throws [ServerException] for all code errors
  Future<List<UserRate>> addAnimeInUserRates(UserRate rate, String token);

  ///Get user rates list
  ///
  ///Throws [ServerException] for all code errors
  Future<List<UserRate>> getAllUserRates(int userId);
}
