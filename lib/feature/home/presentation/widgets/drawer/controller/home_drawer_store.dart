import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/delete_tokens.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token_from_storage.dart';
import 'package:shikimoriapp/feature/profile/domain/models/creditional.dart';
import 'package:shikimoriapp/feature/profile/domain/use_cases/get_creditional.dart';

part 'home_drawer_store.g.dart';

class HomeDrawerStore = _HomeDrawerStore with _$HomeDrawerStore;

abstract class _HomeDrawerStore with Store {
  _HomeDrawerStore(
    this._deleteTokensUseCase,
    this._getCreditionalUseCase,
    this._accessTokenFromStorageUseCase,
  );

  final DeleteTokens _deleteTokensUseCase;
  final GetCreditional _getCreditionalUseCase;
  final GetAccessTokenFromStorage _accessTokenFromStorageUseCase;

  @observable
  ObservableFuture<void> deleteTokensFuture = ObservableFuture.value({});

  @observable
  ObservableFuture<void> creditionalFuture = ObservableFuture.value({});

  @observable
  bool isDeleted = false;

  @observable
  Creditional? userCreditional;

  @action
  Future<void> deleteTokens() async {
    deleteTokensFuture = ObservableFuture(_deleteTokens());
  }

  @action
  Future<void> fetchCreditional() async {
    deleteTokensFuture = ObservableFuture(_getCreditional());
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

  Future<void> _deleteTokens() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await _deleteTokensUseCase.call(const NoParams());
    response.fold(
      (error) {
        throw MobXException(error.message ?? 'Tokens delete exception');
      },
      (_) {
        isDeleted = true;
      },
    );
  }
}
