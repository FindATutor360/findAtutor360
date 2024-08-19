import 'package:findatutor360/routes/index.dart';
import 'package:findatutor360/views/auth/splash/splash_view.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  navigatorKey: rootKey,
  initialLocation: SplashView.path,
  debugLogDiagnostics: true,
  routes: routes,
);
