import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/introduction_page/model/google_login_provider.dart';
import 'package:travel_app/features/route/app_navigation.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Login is in progress. Please wait...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Google Sign-In
  void signInWithGoogle(BuildContext buildContext) async {
    try {
      showLoadingDialog();

      // Use the provider data outside async calls
      final googleLoginProvider = buildContext.read<GoogleLoginProvider>();

      //* Step 1: If the user signs in successfully, it returns a GoogleSignInAccount object.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('No google user is found');
        Navigator.pop(buildContext);
        return;
      }

      //*Step 2: google authentication details store in a variable
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      //* Step 3: These tokens help to authenticate the user with Firebase.
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //* Step 4: Sign in with Firebase.
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Step 5: get Firebase UID
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('Firebase👍 UID: ${user.uid}');
      }

      //* Document map upload in Firestore
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'name': googleUser.displayName,
          'avatar': googleUser.photoUrl,
          'uid': user.uid,
          'wishlistLocations': googleLoginProvider.allWishListReference,
        });
        print('User data successfully uploaded to Firestore!');
      }

      //* Update provider data user UID store in firebase
      if (user != null) {
        googleLoginProvider.setUserData(
          {
            'name': googleUser.displayName,
            'email': user.email,
            'photoUrl': googleUser.photoUrl,
          },
        );
        googleLoginProvider.setAccessToken(user.uid);
      }

      // Navigate to the next screen
      Navigator.pushReplacement(
        buildContext,
        MaterialPageRoute(builder: (context) => AppNavigation()),
      );
    } catch (error) {
      print('Error during sign-in: $error');
      Navigator.pop(buildContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            signInWithGoogle(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google_logo.png',
                height: 34,
              ),
              SizedBox(width: 20),
              Text(
                'Sign in with Google',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * Differences Between Google User ID and Firebase User UID
      1. Google User ID (googleUser.id)
      The googleUser.id represents the unique ID provided by Google for the user.
      It is specific to Google's services and identifies the user within Google's ecosystem.
      This ID is not managed by Firebase and may not be suitable if you plan to use Firebase services (e.g., Firestore, Realtime Database) for authentication and user management.
      2. Firebase User UID (user.uid)
      Firebase User UID is a unique identifier for a user managed by Firebase.
      It is generated after the user successfully signs in via Firebase Authentication (e.g., with Google, Email/Password, etc.).
      This UID is consistent across all sign-in methods for the same user (e.g., if the same Google account is linked with email/password, both sign-ins will result in the same Firebase UID).
* Why Use Firebase UID Instead of Google User ID?
      Firebase UID is tied to Firebase's authentication system, ensuring consistent identification across Firebase services.
      Firebase allows you to manage user data and perform operations (e.g., linking accounts, managing user sessions) based on the UID.
      Using the Google User ID (googleUser.id) can cause inconsistencies if you later switch to other authentication providers or need Firebase-specific operations.
*/
}
