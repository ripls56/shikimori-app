import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/theme/app_colors.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
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
    context.read<UpdateStore>().fetchUpdateInformation();
    super.initState();
  }

  Future<void> _asyncMethod() async {
    packageInfo = await PackageInfo.fromPlatform();
    path = '${(await getTemporaryDirectory()).path}/${packageInfo.appName}.apk';
  }

  @override
  Widget build(BuildContext context) {
    final updateStore = context.read<UpdateStore>();
    final theme = context.theme;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Обновление',
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Observer(
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(18),
                        child: MarkdownBody(data: updateStore.information),
                      );
                    },
                  )
                ],
              ),
            ),
            ColoredBox(
              color: AppColors.purple.shade600,
              child: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          AppAssets.shikimoriLogo,
                          colorFilter: ColorFilter.mode(
                            AppColors.purple.shade50,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text('Размер: '),
                          Observer(
                            builder: (context) {
                              return Text(
                                '${updateStore.currentSize.toStringAsFixed(2)} '
                                '/ ${updateStore.apkSize.toStringAsFixed(2)}',
                              );
                            },
                          ),
                        ],
                      ),
                      Observer(
                        builder: (context) {
                          if (updateStore.checkApkExist(path)) {
                            return ElevatedButton(
                              onPressed: () => updateStore.updateApp(path),
                              child: const Text(
                                'Установить',
                              ),
                            );
                          }
                          if (updateStore.currentSize == updateStore.apkSize) {
                            return IconButton.outlined(
                              onPressed: () =>
                                  updateStore.fetchUpdate('', path),
                              icon: const Icon(
                                size: 20,
                                CupertinoIcons.arrow_down_to_line,
                              ),
                            );
                          }
                          if (updateStore.currentSize < updateStore.apkSize) {
                            return IconButton.outlined(
                              onPressed: () =>
                                  updateStore.cancelToken?.cancel(),
                              icon: const Icon(
                                size: 20,
                                CupertinoIcons.stop_fill,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
