import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shikimoriapp/core/extension/context_extension.dart';
import 'package:shikimoriapp/core/helpers/images.dart';

/// Custom app bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor
  const CustomAppBar({
    super.key,
    this.title,
    this.bottom,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation,
  });

  /// Title of the app bar
  final String? title;

  /// Bottom size of the app bar
  final PreferredSizeWidget? bottom;

  /// Center title of the app bar
  final bool? centerTitle;

  final Widget? leading;

  final List<Widget>? actions;

  final Color? backgroundColor;

  final double? elevation;

  @override
  Widget build(BuildContext context) {
    const logoSize = 26.0;

    final theme = context.theme;

    Widget calculateLeading() {
      if (leading != null) {
        return leading!;
      }
      if (ModalRoute.of(context)?.settings.name == 'home') {
        debugPrint(ModalRoute.of(context)?.settings.name);
        return IconButton(
          icon: SvgPicture.asset(
            AppAssets.shikimoriLogo,
            height: logoSize,
            width: logoSize,
            color: theme.brightness != Brightness.dark ? Colors.black : Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }
      return IconButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        icon: const Icon(Icons.arrow_back),
      );
    }

    return AppBar(
      iconTheme: theme.iconTheme.copyWith(
        color:
            theme.brightness != Brightness.dark ? Colors.black : Colors.white,
      ),
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      elevation: elevation,
      actions: actions ?? [],
      leading: calculateLeading(),
      title: Text(
        title ?? '',
        style: theme.textTheme.headlineSmall,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(0, _PreferredAppBarSize(bottom?.preferredSize.height).height);
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.bottomHeight)
      : super.fromHeight(
          kToolbarHeight + (bottomHeight ?? 0),
        );

  final double? bottomHeight;
}
