import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/common/utils/theme/colors.dart';

class HomePageAppBar extends StatelessWidget {
  final String headingText;
  final VoidCallback onAvatarTap;
  final Map<String, dynamic>? userInfo;

  HomePageAppBar({
    super.key,
    required this.userInfo,
    required this.headingText,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Builder(
        builder: (context) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onAvatarTap,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  '${userInfo?['photoUrl']}',
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      headingText,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: AppColors.baseColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Center(
                    child: Text(
                      'Your Dream Destinations',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(0),
              ),
              onPressed: null,
              icon: Icon(
                Icons.notifications_none_sharp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
