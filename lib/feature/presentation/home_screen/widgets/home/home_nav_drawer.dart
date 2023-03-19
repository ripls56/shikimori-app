import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';

class HomeNavDrawer extends StatelessWidget {
  const HomeNavDrawer({
    super.key,
    required this.drawerItems,
    required int page,
    required PageController controller,
  })  : _page = page,
        _controller = controller;

  final List drawerItems;
  final int _page;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileInitial) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            imageUrl: state.creditional.image.x160,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        state.creditional.nickname,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: drawerItems.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = drawerItems[index];
              return Column(
                children: [
                  if (index == 0)
                    const Divider(
                      height: 2,
                    ),
                  ListTile(
                    leading: Icon(
                      item['icon'],
                      color: _page == index
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.titleMedium?.color,
                    ),
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        color: _page == index
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                    onTap: () {
                      _controller.jumpToPage(index);
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(
                    height: 2,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
