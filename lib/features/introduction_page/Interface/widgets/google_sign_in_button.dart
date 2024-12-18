import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/common/utils/google_login_provider.dart';
import 'package:travel_app/features/route/app_navigation.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  //* global scope property, or has part

  //* Show a loading dialog
  void _showLoadingDialog() {
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

  //* Method to connect with Firebase and Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      _showLoadingDialog();

      //* Step 1: Trigger the Google Sign-In flow. If the user signs in successfully, it returns a GoogleSignInAccount object. If the user cancels, it returns null.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('No google user is found');
        Navigator.pop(context);
        return;
      }
      //*Step 2: Retrieve authentication details for the signed-in Google user The `authentication` method fetches the user's access token and ID token.
      final googleAuth = await googleUser.authentication;
      //* These tokens will be used to authenticate the user with Firebase.
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      //* Step 6: Sign in to Firebase using the generated credential. Firebase validates the tokens with Google and creates or links the user in Firebase.
      await FirebaseAuth.instance.signInWithCredential(credential);

      //* How to Get Firebase UID? After a successful Firebase authentication (signInWithCredential), you can get the Firebase user object from FirebaseAuth. Here's how:
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('Firebase UID: ${user.uid}');
      }

      //* Get the user Details upload in provider also in fireStore users document.
      if (user != null) {
        //* Update Provider data after successful sign-in
        context.read<GoogleLoginProvider>().setUserData(
          {
            'email': user.email,
            'name': googleUser.displayName,
            'avatar': googleUser.photoUrl,
            'uid': user.uid,
          },
        );
      }

      //* document map upload in firestore
      try {
        if (user != null) {
          final Map<String, dynamic> fireStoreDoc = {
            'email': user.email,
            'name': googleUser.displayName,
            'avatar': googleUser.photoUrl,
            'uid': user.uid,
            'wishlistLocations':
                context.watch<GoogleLoginProvider>().allWishListReference
          };
          print('User Details: $fireStoreDoc');
          //! write Data in fire store
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid) //* Use UID as document ID
              .set(
                fireStoreDoc,
                SetOptions(
                  merge: true, //* Merge to avoid overwriting existing data
                ),
              );
          print('User data successfully uploaded to Firestore!');
        }
      } catch (error) {
        print('Error during Google Sign-In: $error');
      }

      if (user != null) {
        context.read<GoogleLoginProvider>().setAccessToken(user.uid);
      }

      context.read<GoogleLoginProvider>().getUserAccessToken();

      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppNavigation(user!.uid)),
      );
    } catch (error) {
      print('Error during sign-in: $error');
      Navigator.pop(context); //* Close dialog in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: signInWithGoogle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google_logo.png', // Ensure Google logo image exists in assets
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
