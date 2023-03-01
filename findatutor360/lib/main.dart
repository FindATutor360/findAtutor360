import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'routes/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'FindATutor360',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xFF253341)),
        scaffoldBackgroundColor: const Color(0xFF15202B),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          subtitle1: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          subtitle2: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          caption: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          overline: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: customTheme['primaryColor'],
          secondary: customTheme['secondaryColor'],
        ),
      ),
      //Get the current theme value from the settings screen and set it here
      // themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
