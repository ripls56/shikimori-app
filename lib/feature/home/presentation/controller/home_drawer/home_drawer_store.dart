import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/core/usecase/no_params.dart';
import 'package:shikimoriapp/feature/authorization/domain/use_cases/delete_tokens.dart';

part 'home_drawer_store.g.dart';

class HomeDrawerStore = _HomeDrawerStore with _$HomeDrawerStore;

abstract class _HomeDrawerStore with Store {
  _HomeDrawerStore(
    this._deleteTokensUseCase,
  );

  final DeleteTokens _deleteTokensUseCase;

  @observable
  ObservableFuture<void> deleteTokensFuture = ObservableFuture.value({});

  @observable
  bool isDeleted = false;

  @observable
  bool isUrlCopied = false;

  @action
  Future<void> deleteTokens() async {
    deleteTokensFuture = ObservableFuture(_deleteTokens());
  }

  @action
  void copied() {
    isUrlCopied = !isUrlCopied;
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
