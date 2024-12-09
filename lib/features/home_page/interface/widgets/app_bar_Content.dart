import 'package:flutter/material.dart';

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
              onTap: onAvatarTap, // Trigger the callback // Open the drawer
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  '${userInfo?['photoUrl']}',
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userInfo?['name']}',
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    headingText.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
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
              onPressed: () => logoutPopup(context),
              child: Icon(
                Icons.logout_sharp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
