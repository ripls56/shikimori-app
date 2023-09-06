import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
import 'package:shikimoriapp/feature/update_app/presentation/controller/update_store.dart';

///Screen with information about update and download button
class UpdateScreen extends StatefulWidget {
  ///Constructor
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late final PackageInfo packageInfo;
  late final String path;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  Future<void> _asyncMethod() async {
    packageInfo = await PackageInfo.fromPlatform();
    path = '${(await getTemporaryDirectory()).path}/${packageInfo.appName}.apk';
    debugPrint(path);
  }

  @override
  Widget build(BuildContext context) {
    final updateStore = context.read<UpdateStore>();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Обновление',
      ),
      body: Center(
        child: Column(
          children: [
            Observer(
              builder: (context) {
                return Text(
                  '${updateStore.currentSize.toStringAsFixed(2)} / ${updateStore.apkSize.toStringAsFixed(2)}',
                );
              },
            ),
            ElevatedButton(
              onPressed: () => context
                  .read<UpdateStore>()
                  .fetchUpdate(packageInfo.version, path),
              child: const Text('download'),
            ),
            ElevatedButton(
              onPressed: () => context.read<UpdateStore>().installUpdate(path),
              child: const Text('install'),
            ),
          ],
        ),
      ),
    );
  }
}
