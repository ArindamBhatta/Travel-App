import 'package:flutter/material.dart';
import 'package:travel_app/common/utils/theme/colors.dart';

import 'package:travel_app/features/home_page/interface/widgets/google_log_out.dart';

class AppBarContent extends StatelessWidget {
  //* has part
  final String? headingText;
  final VoidCallback onAvatarTap;
  final Map<String, dynamic>? userInfo;

  AppBarContent({
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
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Builder(
        builder: (context) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onAvatarTap,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
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
                      headingText.toString(),
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
            TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(0),
              ),
              onPressed: () {},
              child: Icon(
                Icons.notifications_none_sharp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
