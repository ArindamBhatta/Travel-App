import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../../common/utils/google_login_provider.dart';
import '../../../introduction_page/Interface/introduction_page.dart';

Future<void> googleLogout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => IntroductionPage(),
      ),
    );
  } catch (error) {
    print("Logout failed: $error");
  }
}

void logoutPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withAlpha(50),
                    ),
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Are you sure you want to logout?',
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 2,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  googleLogout(context);
                  context.read<GoogleLoginProvider>().removeUserAccessToken();
                },
                child: const Text(
                  'logout',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 2,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
        ],
      );
    },
  );
}
