import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';
import 'package:shikimoriapp/feature/anime_details/presentation/controller/videos/videos_cubit.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({required this.id, super.key});

  final int id;

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  @override
  void initState() {
    context.read<VideosCubit>().getAllVideos(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Видео'),
        centerTitle: true,
      ),
      body: BlocBuilder<VideosCubit, VideosState>(
        builder: (context, state) {
          if (state is VideosError) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is VideosLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.75,
              ),
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ImageWidget(
                          url: state.videos[index].imageUrl,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(onTap: () {}),
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
