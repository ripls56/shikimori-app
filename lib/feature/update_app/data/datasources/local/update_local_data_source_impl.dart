import 'package:install_plugin/install_plugin.dart';
import 'package:shikimoriapp/feature/update_app/data/datasources/local/update_local_data_source.dart';

///Anime remote data source implementation
class UpdateLocalDataSourceImpl implements UpdateLocalDataSource {
  ///Need dio client to work
  UpdateLocalDataSourceImpl();

  @override
  Future<void> update(String path) async {
    await InstallPlugin.installApk(path);
  }
}
