import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shikimoriapp/feature/presentation/home_screen/controller/home/profile_cubit.dart';
import 'package:shikimoriapp/feature/presentation/login_screen/view/login_screen.dart';
import 'package:shikimoriapp/injection.container.dart';

class HomeNavDrawer extends StatefulWidget {
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
  State<HomeNavDrawer> createState() => _HomeNavDrawerState();
}

class _HomeNavDrawerState extends State<HomeNavDrawer> {
  @override
  void initState() {
    context.read<ProfileCubit>().getCreditionals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) => {
                if (state is ProfileTokenException)
                  {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false),
                    sl<FlutterSecureStorage>().deleteAll(),
                  }
              },
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
            itemCount: widget.drawerItems.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = widget.drawerItems[index];
              return Column(
                children: [
                  if (index == 0)
                    const Divider(
                      height: 2,
                    ),
                  ListTile(
                    leading: Icon(
                      item['icon'],
                      color: widget._page == index
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.titleMedium?.color,
                    ),
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        color: widget._page == index
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                    onTap: () {
                      widget._controller.jumpToPage(index);
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
          const Spacer(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              'Выйти',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
