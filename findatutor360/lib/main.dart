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
        colorScheme: const ColorScheme.dark().copyWith(
          primary: customTheme['primaryColor'],
          secondary: customTheme['secondaryColor'],
        ),
      ),
      //Get the current theme value from the settings screen and set it here
      // themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      //themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
