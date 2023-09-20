import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shikimoriapp/common/widgets/custom_app_bar.dart';
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
    super.initState();
  }

  Future<void> _asyncMethod() async {
    packageInfo = await PackageInfo.fromPlatform();
    path = '${(await getTemporaryDirectory()).path}/${packageInfo.appName}.apk';
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
            Expanded(
              child: Container(
                color: Colors.black26,
                child: ListView(
                  children: [],
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      AppAssets.shikimoriLogo,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    // TODO(ripls56): дата выхода обновы
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      locale: const Locale('ru', 'RU'),
                    ),
                    Observer(
                      builder: (context) => DownloadButton(
                        status: DownloadStatus.fetchingDownload,
                        onTap: () {},
                      ),
                    ),
                    Observer(
                      builder: (context) {
                        return Text(
                          '${updateStore.currentSize.toStringAsFixed(2)} / ${updateStore.apkSize.toStringAsFixed(2)}',
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum DownloadStatus {
  none,
  fetchingDownload,
  downloading,
  downloaded,
}

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key, required this.onTap, required this.status});

  final VoidCallback onTap;

  final DownloadStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case DownloadStatus.downloaded:
        return const SizedBox.shrink();
      case DownloadStatus.fetchingDownload:
        return const SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      case DownloadStatus.downloading:
        return const SizedBox.shrink();
      case DownloadStatus.none:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.download,
              size: 20,
            ),
          ),
        );
    }
  }
}
