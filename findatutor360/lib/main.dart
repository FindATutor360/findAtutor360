import 'package:findatutor360/core/view_models/main/theme_controller.dart';
import 'package:findatutor360/firebase_options.dart';
import 'package:findatutor360/providers/app_providers.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  setupLocator();

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
    return Consumer<ThemeController>(
      builder: (BuildContext context, themeController, Widget? child) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'FindATutor360',
          theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(color: customTheme['whiteColor']),
            brightness: Brightness.light,
            scaffoldBackgroundColor: customTheme['whiteColor'],
            iconTheme: const IconThemeData(
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
            colorScheme: const ColorScheme.dark().copyWith(
              primary: customTheme['primaryColor'],
              secondary: customTheme['secondaryColor'],
            ),
            dividerTheme: DividerThemeData(
              color: customTheme['dividerColor'],
              thickness: 1,
            ),
            textTheme: const TextTheme().apply(
              displayColor: customTheme['mainTextColor'],
            ),
          ),

          darkTheme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(color: Color(0xFF253341)),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            colorScheme: const ColorScheme.dark().copyWith(
              primary: customTheme['primaryColor'],
              secondary: customTheme['secondaryColor'],
            ),
            textTheme: const TextTheme().apply(
              displayColor: customTheme['whiteColor'],
            ),
            dividerTheme: DividerThemeData(
              color: customTheme['whiteColor'],
              thickness: 1,
            ),
          ),
          //Get the current theme value from the settings screen and set it here
          // themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          //themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          themeMode: themeController.currentTheme,
        );
      },
    );
  }
}

Future<void> initAppConfig() async {
  final prefs = AppPreferences();
  await prefs.init();
}
