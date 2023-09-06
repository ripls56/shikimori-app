import 'package:flutter/material.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';

class ScreenshotViewerWidget extends StatefulWidget {
  final String screenshotUrl;

  const ScreenshotViewerWidget({super.key, required this.screenshotUrl});

  @override
  State<ScreenshotViewerWidget> createState() => _ScreenshotViewerWidgetState();
}

class _ScreenshotViewerWidgetState extends State<ScreenshotViewerWidget>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
        _transformationController.value = _animation.value;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _transformationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _animation = Matrix4Tween(
          begin: _transformationController.value,
          end: Matrix4.identity(),
        ).animate(
          CurveTween(curve: Curves.easeOut).animate(_animationController),
        );
        _animationController.forward(from: 0);
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: InteractiveViewer(
          transformationController: _transformationController,
          child: SizedBox(
            height: MediaQuery.of(context).size.width / 2,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Hero(
                tag: widget.screenshotUrl,
                child: ImageWidget(
                  url: widget.screenshotUrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
