import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/common/utils/card_to_details_page_provider.dart';
import 'package:travel_app/features/details_page/utils/details_page_provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/home_page_navigation.dart';
import 'package:travel_app/features/introduction_page/Interface/introduction_page.dart';
import 'common/utils/google_login_provider.dart';
import 'features/home_page/module/data/home_page_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailsPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CardToDetailsPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoogleLoginProvider(),
        ),
      ],
      child: TravelApp(),
    ),
  );
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<GoogleLoginProvider>().getUserAccessToken();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Builder(
        builder: (context) {
          String? userAccessToken =
              context.watch<GoogleLoginProvider>().userAccessToken;
          return userAccessToken != null
              ? HomePageNavigation(userAccessToken)
              : IntroductionPage();
        },
      ),
    );
  }
}
