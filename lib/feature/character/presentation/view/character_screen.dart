import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/common/widgets/custom_loading_bar.dart';
import 'package:shikimoriapp/common/widgets/headline_widget.dart';
import 'package:shikimoriapp/common/widgets/html_description_widget.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/character/presentation/controller/character_cubit.dart';

part '../widgets/character_name_widget.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({required int id, super.key}) : _id = id;

  final int _id;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    context.read<CharacterCubit>().getCharacter(widget._id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CharacterCubit, CharacterState>(
      listener: (context, state) {
        if (state is CharacterError) {
          Future.delayed(
            const Duration(seconds: 5),
            () => context.read<CharacterCubit>().getCharacter(widget._id),
          );
        }
      },
      builder: (context, state) {
        if (state is CharacterLoaded) {
          final character = state.character;
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
                      imageUrl:
                          '${Env.shikimoriUrl}${character.image?.preview}',
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          HeadlineWidget(title: 'Имя'),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                CharacterNameWidget(
                                  title: 'RU: ',
                                  name: character.russian ?? '',
                                ),
                                const Divider(),
                                CharacterNameWidget(
                                  title: 'JP: ',
                                  name: character.japanese ?? '',
                                ),
                                const Divider(),
                                CharacterNameWidget(
                                  title: 'US: ',
                                  name: character.name ?? '',
                                ),
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
                  padding: const EdgeInsets.all(8),
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
                      final seyu = character.seyu[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${Env.shikimoriUrl}${seyu?.image.original}',
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
                                  if (seyu?.russian != '')
                                    Tooltip(
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
                                  else
                                    Container(),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: character.seyu?.length,
                  ),
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
          body: Center(child: CustomLoadingIndicator()),
        );
      },
    );
  }
}
