import 'package:findatutor360/routes/index.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  navigatorKey: rootKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: routes,
);
