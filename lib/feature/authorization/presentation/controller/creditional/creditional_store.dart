import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token_from_storage.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional.dart';
import 'package:shikimoriapp/feature/profile/domain/use_cases/get_creditional.dart';

part 'creditional_store.g.dart';

class CreditionalStore = _CreditionalStoreBase with _$CreditionalStore;

abstract class _CreditionalStoreBase with Store {
  _CreditionalStoreBase(
    this._getCreditionalUseCase,
    this._accessTokenFromStorageUseCase,
  );

  final GetCreditional _getCreditionalUseCase;
  final GetAccessTokenFromStorage _accessTokenFromStorageUseCase;

  @observable
  ObservableFuture<void> creditionalFuture = ObservableFuture.value({});

  @observable
  Creditional? userCreditional;

  @action
  Future<void> fetchCreditional() async {
    creditionalFuture = ObservableFuture(_getCreditional());
  }

  Future<void> _getCreditional() async {
    final token = await _getAccessToken();
    final response = await _getCreditionalUseCase.call(
      GetCreditionalParams(
        accessToken: token,
      ),
    );
    response.fold(
      (error) => throw MobXException(error.message ?? 'Get creditional failed'),
      (loaded) => userCreditional = loaded,
    );
  }

  Future<String> _getAccessToken() async {
    var token = '';
    final response =
        await _accessTokenFromStorageUseCase.call(const NoParams());
    response.fold(
      (error) =>
          throw MobXException(error.message ?? 'Get access token failed'),
      (loaded) => token = loaded,
    );
    return token;
  }
}
