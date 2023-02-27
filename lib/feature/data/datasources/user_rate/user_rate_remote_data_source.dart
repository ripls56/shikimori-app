import 'package:shikimori_app/feature/domain/entities/user_rate/user_rate.dart';

abstract class UserRateRemoteDataSource {
  ///Get user rate by id
  ///
  ///Throws [ServerException] for all code errors
  Future<UserRate> getUserRateById(int userId, int animeId);

  ///Add user rate, and return updated rate list
  ///
  ///Throws [ServerException] for all code errors
  Future<List<UserRate>> addAnimeInUserRates(UserRate rate);

  ///Get user rates list
  ///
  ///Throws [ServerException] for all code errors
  Future<List<UserRate>> getAllUserRates(int userId);
}
