import 'package:findatutor360/firebase_options.dart';
import 'package:findatutor360/providers/app_providers.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initAppConfig();

  runApp(
    MultiProvider(
      providers: AppProviders.providers,
      child: const MyApp(),
    ),
  );
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

Future<void> initAppConfig() async {
  final prefs = AppPreferences();
  await prefs.init();
}
