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
  //* global scope property, has part
  final ColorScheme kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
  );

  final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125),
  );

  @override
  Widget build(BuildContext context) {
    context.read<GoogleLoginProvider>().getUserAccessToken();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      //* for Dark theme
      darkTheme: ThemeData.dark().copyWith(
        //* useMaterial3: true,
        colorScheme: kDarkColorScheme,

        textTheme: GoogleFonts.poppinsTextTheme(),

        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          elevation: 1.5,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      //* for Normal theme
      theme: ThemeData().copyWith(
        //* useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),

        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          elevation: 3,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
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
