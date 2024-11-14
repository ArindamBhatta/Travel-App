import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      //barrierColor: Colors.white, //use a barrier color
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[500],
                    padding: EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    googleLogout(context);
                  },
                  child: const Text(
                    'logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        );
      });
}





//  import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../../introduction_page/Interface/introduction_page.dart';

// Future<void> googleLogout(BuildContext context) async {
//   try {
//     // Sign out from Firebase Auth and Google Sign-In
//     await FirebaseAuth.instance.signOut();
//     await GoogleSignIn().signOut();

//     // Navigate to the Introduction page after logout
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => IntroductionPage(),
//       ),
//     );
//   } catch (error) {
//     print("Logout failed: $error");
//     // Optionally display an error message to the user
//   }
// }

// void logoutPopup(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext dialogContext) {
//       return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Confirm logout',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(dialogContext); // Close dialog
//                       googleLogout(context); // Proceed with logout
//                     },
//                     child: Text('Yes', style: TextStyle(color: Colors.teal)),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(dialogContext); // Close dialog without logout
//                     },
//                     child: Text('No', style: TextStyle(color: Colors.red)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }




// showDialog(
//     context: context,
//     barrierDismissible: false, //* tapping outside is prevented
//     builder: (BuildContext context) {
//       return AlertDialog(
//         actionsAlignment: MainAxisAlignment.spaceAround,
//         title: Text('Confirm Logout'),
//         content: const Text('Are you sure you want to log out?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: Colors.teal),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               googleLogout(context);
//             },
//             child: const Text(
//               'Logout',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       );
//     },
//   );
 
