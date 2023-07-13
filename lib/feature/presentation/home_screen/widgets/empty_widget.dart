import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shikimoriapp/core/widgets/loading_card.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      shrinkWrap: true,
      itemExtent: 200,
      itemCount: 15,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          child: const FadeInAnimation(
              duration: Duration(milliseconds: 500), child: LoadingCard(),),
        );
      },
    );
  }
}
