part of '../view/anime_details.dart';

///Roles widget
class RolesWidget extends StatelessWidget {
  ///Constructor
  const RolesWidget({
    required this.roles,
    super.key,
  });

  ///Roles
  final List<AnimeDetailsRoles> roles;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    if (roles.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        HeadlineWidget(
          title: 'Персонажи',
        ),
        SizedBox(
          height: 130,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: roles.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 14,
            ),
            itemBuilder: (context, index) {
              final role = roles[index];
              return role.character == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: 90,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Dimension.borderRadius,
                            ),
                            child: ImageWidget(
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                              url: '${Env.shikimoriUrl}'
                                  '${role.character!.image.original}',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            role.character?.russian ??
                                role.character?.name ??
                                '',
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          if (role.character?.russian != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Text(
                                role.character!.name,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
