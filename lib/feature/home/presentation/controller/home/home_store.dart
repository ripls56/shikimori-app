import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shikimoriapp/feature/anime/domain/models/anime.dart';
import 'package:shikimoriapp/feature/anime/domain/use_cases/get_animes.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore(this._getAnimesUseCase);

  final GetAnimes _getAnimesUseCase;

  @observable
  ObservableFuture<void> fetchFuture = ObservableFuture.value({});

  @observable
  List<Anime> animes = [];

  @action
  Future<void> fetch() async {
    fetchFuture = ObservableFuture(_getAnimes());
  }

  @action
  Future<void> _getAnimes() async {
    final response = await _getAnimesUseCase.call(
      const GetAnimesParams(
        page: 1,
        limit: 10,
        season: 'summer_2023',
        status: 'ongoing',
        order: 'ranked',
      ),
    );
    response.fold(
      (error) {
        throw FlutterError('animes doesn\'t get');
      },
      (loaded) => animes = loaded,
    );
  }
}
