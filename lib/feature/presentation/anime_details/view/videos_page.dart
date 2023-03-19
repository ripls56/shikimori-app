import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/presentation/anime_details/controller/videos/videos_cubit.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key, required this.id});

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
      body: BlocBuilder<VideosCubit, VideosState>(
        builder: (context, state) {
          if (state is VideosError) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is VideosLoaded) {
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return Text(state.videos[index].playerUrl);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
