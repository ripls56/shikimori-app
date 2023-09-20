import 'package:flutter/material.dart';
import 'package:shikimoriapp/common/widgets/image_widget.dart';

class ImageViewerWidget extends StatefulWidget {
  final String imageUrl;

  const ImageViewerWidget({super.key, required this.imageUrl});

  @override
  State<ImageViewerWidget> createState() => _ImageViewerWidgetState();
}

class _ImageViewerWidgetState extends State<ImageViewerWidget>
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
    /*
      страница обернута в гестур детектор, откуда я беру позицию при драге,
      дальше стек,
      в стеке картинка и ui
      картинка в гестурдетекторе, который дает мне узнать
      когда юзер тащит картинку
      анимирую позицию картинки в стеке, по глоьальной позиции первого детектора
      если позиция картинки при окончании драга меньше или болешь
      чем 1\3 высоты экрана вызываю pop
      также надо опасити заанимировать
     */
    final size = MediaQuery.of(context).size;
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
                tag: widget.imageUrl,
                child: ImageWidget(
                  url: widget.imageUrl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
