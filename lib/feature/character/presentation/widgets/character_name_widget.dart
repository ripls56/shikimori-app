part of '../view/character_screen.dart';

class CharacterNameWidget extends StatelessWidget {
  const CharacterNameWidget({
    required this.title, required this.name, super.key,
  });

  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: title),
          TextSpan(
            text: name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color
                      ?.withOpacity(.6),
                ),
          ),
        ],
      ),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
