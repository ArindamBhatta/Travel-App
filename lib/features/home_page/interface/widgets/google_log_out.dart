import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../introduction_page/model/google_login_provider.dart';
import '../../../introduction_page/Interface/introduction_page.dart';

void googleLogout(BuildContext context) async {
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

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to logout?',
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36,
                  ),
                  backgroundColor: Theme.of(context).dialogTheme.iconColor,
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
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'cancel',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
