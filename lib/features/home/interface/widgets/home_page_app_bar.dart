import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/common/utils/theme/colors.dart';

class HomePageAppBar extends StatelessWidget {
  final String headingText;
  final VoidCallback onAvatarTap;
  final VoidCallback onNotificationTap;
  final Map<String, dynamic>? userInfo;

  HomePageAppBar({
    super.key,
    required this.userInfo,
    required this.headingText,
    required this.onAvatarTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Avatar
          GestureDetector(
            onTap: onAvatarTap,
            child: CircleAvatar(
              backgroundImage: userInfo?['photoUrl'] != null
                  ? CachedNetworkImageProvider(
                      userInfo!['photoUrl'],
                    )
                  : AssetImage('assets/images/loading_image.jpg')
                      as ImageProvider,
              radius: 20,
            ),
          ),
          const SizedBox(width: 12),

          // App Title & Subtitle
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  headingText,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.baseColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your Dream Destinations',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // Notification Icon
          IconButton(
            style: IconButton.styleFrom(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(0),
            ),
            onPressed: onNotificationTap,
            icon: const Icon(
              Icons.notifications_none_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
