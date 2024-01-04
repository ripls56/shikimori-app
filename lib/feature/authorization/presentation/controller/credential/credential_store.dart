import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/get_access_token_from_storage.dart';
import 'package:shikimoriapp/feature/profile/domain/models/credential.dart';
import 'package:shikimoriapp/feature/profile/domain/use_cases/get_credential.dart';

part 'credential_store.g.dart';

class CredentialStore = _CredentialStoreBase with _$CredentialStore;

abstract class _CredentialStoreBase with Store {
  _CredentialStoreBase(
    this._getCredentialUseCase,
    this._accessTokenFromStorageUseCase,
  );

  final GetCredential _getCredentialUseCase;
  final GetAccessTokenFromStorage _accessTokenFromStorageUseCase;

  @observable
  ObservableFuture<void> credentialFuture = ObservableFuture.value({});

  @observable
  Credential? userCredential;

  @action
  Future<void> fetchCreditional() async {
    credentialFuture = ObservableFuture(_getCreditional());
  }

  Future<void> _getCreditional() async {
    final token = await _getAccessToken();
    final response = await _getCredentialUseCase.call(
      GetCredentialParams(
        accessToken: token,
      ),
    );
    response.fold(
      (error) => throw MobXException(error.message ?? 'Get credential failed'),
      (loaded) => userCredential = loaded,
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
