import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  });

  /// Title of the app bar
  final String? title;

  /// Bottom size of the app bar
  final PreferredSizeWidget? bottom;

  /// Center title of the app bar
  final bool? centerTitle;

  final Widget? leading;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    const logoSize = 26.0;

    final theme = context.theme;
    return AppBar(
      iconTheme: theme.iconTheme.copyWith(
        color:
            theme.brightness != Brightness.dark ? Colors.black : Colors.white,
      ),
      centerTitle: centerTitle,
      backgroundColor: theme.colorScheme.primaryContainer,
      actions: actions ?? [],
      leading: leading ??
          IconButton(
            icon: SvgPicture.asset(
              AppImages.shikimoriLogo,
              height: logoSize,
              width: logoSize,
              colorFilter: ColorFilter.mode(
                theme.brightness != Brightness.dark
                    ? Colors.black
                    : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
      title: Text(
        title ?? '',
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(0, _PreferredAppBarSize(bottom?.preferredSize.height).height);
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.bottomHeight)
      : super.fromHeight(kToolbarHeight + (bottomHeight ?? 0));

  final double? bottomHeight;
}
