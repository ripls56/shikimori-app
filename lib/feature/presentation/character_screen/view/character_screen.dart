import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/widgets/headline_widget.dart';
import 'package:shikimoriapp/core/widgets/html_description_widget.dart';
import 'package:shikimoriapp/feature/domain/entities/character/character.dart'
    as entity_character;
import 'package:shikimoriapp/core/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/feature/presentation/character_screen/controller/character_cubit.dart';

part '../widgets/character_name_widget.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    context.read<CharacterCubit>().getCharacter(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterState>(
      listener: (context, state) {
        if (state is CharacterError) {
          Future.delayed(
            const Duration(seconds: 5),
            () => context.read<CharacterCubit>().getCharacter(widget.id),
          );
        }
      },
      builder: (context, state) {
        if (state is CharacterLoaded) {
          entity_character.Character character = state.character;
          return Scaffold(
            appBar: AppBar(
              title: Text(character.name ?? ''),
            ),
            body: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                        width: 154,
                        height: 240,
                        imageUrl: '$SHIKIMORI_URL${character.image?.preview}'),
                    Expanded(
                      child: Column(
                        children: [
                          HeadlineWidget(title: 'Имя', height: 30),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CharacterNameWidget(
                                    title: 'RU: ',
                                    name: character.russian ?? ''),
                                const Divider(),
                                CharacterNameWidget(
                                    title: 'JP: ',
                                    name: character.japanese ?? ''),
                                const Divider(),
                                CharacterNameWidget(
                                    title: 'US: ', name: character.name ?? ''),
                                const Divider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlDescriptionWidget(data: character.descriptionHtml),
                ),
                HeadlineWidget(
                  title: 'Сеью',
                ),
                SizedBox(
                  height: 230,
                  child: ListView.builder(
                      itemExtent: 140,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var seyu = character.seyu?[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Image.network(
                                    '$SHIKIMORI_URL${seyu?.image.original}',
                                    height: 150,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Tooltip(
                                      message: seyu?.name,
                                      child: Text(
                                        seyu?.name ?? '',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    seyu?.russian != ''
                                        ? Tooltip(
                                            message: seyu?.russian,
                                            child: Text(
                                              seyu?.russian ?? '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: character.seyu?.length),
                )
              ],
            ),
          );
        }
        if (state is CharacterError) {
          return Scaffold(
            body: Center(child: Text(state.errorMessage)),
          );
        }
        return const Scaffold(
          body: Center(child: CustomLoadingBar()),
        );
      },
    );
  }
}
