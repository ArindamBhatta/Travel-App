import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/side_drawer.dart';
import '../../../common/utils/google_login_provider.dart';
import 'widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  final String? userAccessToken;
  HomePage(this.userAccessToken);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? userLoginData;

  @override
  void initState() {
    super.initState();
    silentLoginWithAccessToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //* only for android
  void silentLoginWithAccessToken() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
    try {
      if (googleUser != null) {
        context.read<GoogleLoginProvider>().setUserData(
          {
            'email': googleUser.email,
            'name': googleUser.displayName,
            'photoUrl': googleUser.photoUrl,
          },
        );
      }
    } catch (error) {
      print(
        "error in silent login $error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    userLoginData = context.watch<GoogleLoginProvider>().userData;

    return Scaffold(
      drawer: SideDrawer(userLoginData),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: new HomePageBody(
          userLoginData: userLoginData,
        ),
      ),
    );
  }
}
