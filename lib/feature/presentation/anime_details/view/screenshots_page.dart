import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/helpers/images.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/screenshots/screenshots_cubit.dart';
import 'package:shikimoriapp/core/widgets/custom_loading_bar.dart';

class ScreenshotsPage extends StatefulWidget {
  const ScreenshotsPage({super.key, required this.id});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Кадры"),
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
                  crossAxisCount: 2, childAspectRatio: 14 / 8),
              itemCount: state.screenshots.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) =>
                              Image.asset(AppImages.missing),
                          imageUrl:
                              '$SHIKIMORI_URL${state.screenshots[index].original}',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width / 2,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '$SHIKIMORI_URL${state.screenshots[index].original}',
                                  ),
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
          return const CustomLoadingBar();
        },
      ),
    );
  }
}
