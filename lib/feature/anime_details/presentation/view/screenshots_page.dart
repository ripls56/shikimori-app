import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/common/hero_dialog_route.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/common/widgets/image_viewer_widget.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/screenshots/screenshots_cubit.dart';

class ScreenshotsPage extends StatefulWidget {
  const ScreenshotsPage({required this.id, super.key});

  final int id;
  @override
  State<ScreenshotsPage> createState() => _ScreenshotsPageState();
}

class _ScreenshotsPageState extends State<ScreenshotsPage> {
  @override
  void initState() {
    context.read<ScreenshotsCubit>().getAllScreenshots(widget.id);
    super.initState();
  }

  String _screenshotUrl(int index, List<AnimeDetailsScreenshot> screenshots) =>
      '${Env.shikimoriUrl}${screenshots[index].original}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кадры'),
        centerTitle: true,
      ),
      body: BlocBuilder<ScreenshotsCubit, ScreenshotsState>(
        builder: (context, state) {
          if (state is ScreenshotsError) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is ScreenshotsLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 14 / 8,
              ),
              itemCount: state.screenshots.length,
              itemBuilder: (context, index) {
                final screenshotUrl = _screenshotUrl(index, state.screenshots);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: screenshotUrl,
                          child: ImageWidget(
                            url: screenshotUrl,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            HeroDialogRoute(
                              builder: (context) => RepaintBoundary(
                                child: ImageViewerWidget(
                                  imageUrl: screenshotUrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const CustomLoadingIndicator();
        },
      ),
    );
  }
}
